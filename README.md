# AWS EKS Platform with GitOps, Monitoring & Logging

## Project Overview

This project demonstrates the deployment of a cloud-native application on Amazon Elastic Kubernetes Service (Amazon EKS) using modern DevOps practices. The infrastructure is provisioned with Terraform, the application is containerized using Docker, Kubernetes resources are managed with YAML manifests and Helm, and GitOps is implemented for the backend application using Argo CD.
The platform also includes monitoring with Prometheus and Grafana, alerting with Alertmanager, and centralized logging using Fluent Bit, Elasticsearch, and Kibana (EFK). An Amazon RDS MySQL database is used as the backend data store, while supporting AWS components such as the AWS Load Balancer Controller and Amazon EBS CSI Driver provide ingress management and persistent storage.
The objective of this project was to build an end-to-end Kubernetes platform that closely resembles real-world deployment practices while gaining hands-on experience with infrastructure provisioning, application deployment, observability, and GitOps workflows. 

## Architecture

The platform consists of multiple AWS services and Kubernetes components working together to provide infrastructure provisioning, application deployment, GitOps, monitoring, logging, and persistent storage.
|....  | .... |
|------|-----|
| ![Architecture](architecture/architecture-diagram.png) | ![Architecture](architecture/architecture-diagram.png) |

## Features

- Infrastructure provisioning using Terraform
- Amazon EKS cluster deployment
- Amazon RDS MySQL database integration
- Containerized backend and frontend applications using Docker
- Kubernetes deployment manifests
- Helm chart for backend application deployment
- GitOps implementation for backend deployment using Argo CD
- NGINX Ingress Controller for external access
- Persistent storage using Amazon EBS CSI Driver
- Monitoring with Prometheus and Grafana
- Alerting using Alertmanager
- Centralized logging using Fluent Bit, Elasticsearch, and Kibana (EFK)
- Automatic application synchronization through Argo CD

## Technology Stack

| Category | Technologies |
|-----------|--------------|
| Cloud | AWS |
| Infrastructure as Code | Terraform |
| Containerization | Docker |
| Container Orchestration | Kubernetes (Amazon EKS) |
| Package Management | Helm |
| GitOps | Argo CD |
| Database | Amazon RDS MySQL |
| Monitoring | Prometheus, Grafana |
| Alerting | Alertmanager |
| Logging | Fluent Bit, Elasticsearch, Kibana |
| Networking | NGINX Ingress Controller |
| Storage | Amazon EBS CSI Driver |
| Version Control | Git, GitHub |

## Infrastructure Provisioning

The AWS infrastructure for this project is provisioned using **Terraform**. The configuration creates the networking, compute, and database resources required to host the Kubernetes platform and application.

### Provisioned Resources

- Amazon VPC
- Public and Private Subnets across multiple Availability Zones
- Internet Gateway
- NAT Gateway
- Route Tables and Associations
- Security Groups
- Amazon EKS Cluster
- Amazon EKS Managed Node Group
- Amazon RDS MySQL Database

After the infrastructure is provisioned, Terraform outputs are used to configure access to the EKS cluster and integrate the remaining Kubernetes components.

> **Terraform State Resources**
>
> *(Terraform state screenshot will be added here.)*

## Cluster Configuration & AWS Integrations

After provisioning the AWS infrastructure, several additional configuration steps were completed to prepare the Kubernetes platform for application deployment.

### Configuration Tasks

- Configured AWS CLI credentials
- Updated kubeconfig for Amazon EKS cluster access
- Installed kubectl, Helm, eksctl, and Terraform CLI
- Associated the IAM OIDC provider with the EKS cluster
- Installed the AWS Load Balancer Controller
- Installed the Amazon EBS CSI Driver
- Imported the Amazon EKS Cluster Security Group into Terraform
- Updated the Amazon RDS Security Group to allow MySQL access from the EKS Cluster Security Group
- Configured the default StorageClass for persistent volumes
- Verified cluster connectivity before deploying workloads

## Application Deployment

The platform hosts a containerized backend and frontend application deployed on Amazon EKS.

### Backend Application

- Built using Java and Spring Boot
- Packaged as a Docker image
- Stored in Docker Hub
- Connects to Amazon RDS MySQL
- Kubernetes resources managed using Helm

### Frontend Application

- Built using Python Flask
- Packaged as a Docker image
- Stored in Docker Hub
- Communicates with the backend service through Kubernetes networking

### Kubernetes Resources

The application deployment includes the following Kubernetes resources:

- Namespace
- Deployment
- Service
- ConfigMap
- Secret
- Ingress

## Helm Deployment

The backend application was packaged as a reusable Helm chart to simplify Kubernetes deployments and configuration management.

The Helm chart includes templates for:

- Deployment
- Service
- ConfigMap
- Secret
- Namespace

Environment-specific configuration is managed using:

- `values.yaml`
- `values-stg.yaml`
- `values-prod.yaml`

Application settings such as container image, replica count, resource limits, database connection details, and health probes are configurable through Helm values.

## GitOps with Argo CD

GitOps was implemented for the backend application using Argo CD.

The backend Helm chart is stored in the GitHub repository, and Argo CD continuously monitors the repository for changes. Whenever updates are committed to the Helm chart or configuration values, Argo CD automatically synchronizes the desired state with the Kubernetes cluster.

This workflow was validated by updating the backend replica count in the Helm values file, after which Argo CD automatically synchronized the deployment and scaled the application without manual Kubernetes changes.

## Networking

Application traffic is managed using the NGINX Ingress Controller.

Ingress resources were configured to provide external access for:

- Frontend application
- Grafana
- Prometheus
- Alertmanager
- Argo CD
- Kibana

The AWS Load Balancer Controller provisions an Application Load Balancer (ALB) to route external traffic into the Kubernetes cluster.

## Persistent Storage

Persistent storage is provided using the Amazon EBS CSI Driver.

A custom StorageClass and PersistentVolumeClaim (PVC) were created to dynamically provision Amazon EBS volumes for Kubernetes workloads requiring persistent storage.

## Monitoring

The Kubernetes platform is monitored using Prometheus and Grafana.

### Prometheus

Prometheus continuously scrapes metrics from Kubernetes components and application workloads.

Collected metrics include:

- Cluster metrics
- Node metrics
- Pod metrics
- Application metrics
- Resource utilization

### Grafana

Grafana is integrated with Prometheus to visualize cluster and application metrics through dashboards.

Implemented dashboards include:

- Kubernetes Cluster Monitoring
- Kubernetes Views (Pods)

These dashboards provide real-time visibility into cluster health, resource utilization, and workload status.

## Alerting

Alertmanager is integrated with Prometheus to provide centralized alert management.

A custom Prometheus alert rule was configured to detect backend application downtime.

The alert was validated by intentionally scaling the backend deployment to zero replicas, causing the application to become unavailable. Prometheus successfully fired the alert, which was received and displayed in Alertmanager.

This validation confirmed the end-to-end monitoring and alerting workflow.

## Centralized Logging

The platform includes an EFK (Elasticsearch, Fluent Bit, and Kibana) stack for centralized log management.

### Fluent Bit

- Collects container logs from Kubernetes nodes
- Forwards logs to Elasticsearch

### Elasticsearch

- Stores and indexes application logs
- Provides fast log searching and aggregation

### Kibana

- Visualizes logs through a web interface
- Enables searching and filtering of application logs

## DNS & External Access

Amazon Route 53 was used to configure DNS records for services exposed through the NGINX Ingress Controller.

Configured subdomains include:

- Frontend Application
- Argo CD
- Prometheus
- Grafana
- Alertmanager
- Kibana

Each subdomain routes traffic through the AWS Application Load Balancer created by the AWS Load Balancer Controller, providing user-friendly URLs for accessing platform services.

## Documentation

Additional documentation is available in the `docs` directory.
- [Deployment Guide](docs/deployment-guide.md)
- [Cleanup Guide](docs/cleanup-guide.md)
- [Architecture Details](docs/architecture.md)

## Project Validation

The following functionality was successfully validated during implementation:

- Terraform successfully provisioned AWS infrastructure
- Amazon EKS cluster became operational
- Backend and frontend applications were deployed successfully
- Backend connected successfully to Amazon RDS MySQL
- Helm deployments worked as expected
- Argo CD automatically synchronized Git changes
- Grafana dashboards displayed cluster metrics
- Prometheus successfully collected metrics
- Alertmanager successfully fired alerts during backend downtime
- Kibana was accessible through Ingress
- DNS records successfully resolved using Amazon Route 53

  ## Future Enhancements

The following improvements can be implemented to further enhance the platform:

- Expand Helm charts to package the frontend application and remaining Kubernetes components.
- Extend GitOps using Argo CD to manage the complete Kubernetes platform instead of only the backend application.
- Refactor the Terraform configuration into reusable modules for improved maintainability and scalability.
- Eliminate the manual Amazon EKS Cluster Security Group import by redesigning the infrastructure workflow with modular Terraform.
- Migrate the AWS Load Balancer Controller from Classic Load Balancer to Network Load Balancer (NLB) where appropriate.
- Upgrade the Amazon EKS cluster and Kubernetes version to stay aligned with the latest supported releases.
- Configure Alertmanager with Slack or Microsoft Teams notifications for real-time alert delivery.
- Add CI pipelines for automated application build, testing, and Docker image publishing.
- Implement Horizontal Pod Autoscaler (HPA) for automatic application scaling based on resource utilization.
- Secure sensitive configuration using AWS Secrets Manager or HashiCorp Vault instead of Kubernetes Secrets.
- Introduce certificate management using cert-manager and Let's Encrypt for HTTPS-enabled ingress.
- Configure automated backup and disaster recovery for Amazon RDS and Kubernetes workloads.
