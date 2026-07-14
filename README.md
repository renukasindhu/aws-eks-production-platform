# AWS EKS Platform with GitOps, Monitoring & Logging

![AWS](https://img.shields.io/badge/AWS-EKS-orange?logo=amazonaws)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform)
![Docker](https://img.shields.io/badge/Docker-Containerization-2496ED?logo=docker)
![Kubernetes](https://img.shields.io/badge/Kubernetes-EKS-326CE5?logo=kubernetes)
![Helm](https://img.shields.io/badge/Helm-Charts-0F1689?logo=helm)
![ArgoCD](https://img.shields.io/badge/ArgoCD-GitOps-EF7B4D?logo=argo)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?logo=prometheus)
![Grafana](https://img.shields.io/badge/Grafana-Dashboards-F46800?logo=grafana)
![Elasticsearch](https://img.shields.io/badge/Elasticsearch-Logging-005571?logo=elasticsearch)

---
## Project Overview

This project demonstrates the deployment of a production-style cloud-native platform on **Amazon Elastic Kubernetes Service (Amazon EKS)** using modern DevOps practices.
The infrastructure is provisioned using **Terraform**, while applications are containerized using **Docker** and deployed to Kubernetes using **Helm** and Kubernetes manifests. **Argo CD** is used to implement GitOps for automated backend application deployment.
The platform also integrates:
- Prometheus for metrics collection
- Grafana for visualization
- Alertmanager for alerting
- Fluent Bit, Elasticsearch and Kibana (EFK) for centralized logging
- Amazon Route 53 for DNS management
- AWS Load Balancer Controller for ingress
- Amazon EBS CSI Driver for persistent storage
- Amazon RDS MySQL as the backend database
The objective of this project was to build an end-to-end Kubernetes platform that closely resembles real-world deployment practices while gaining hands-on experience with Infrastructure as Code (IaC), Kubernetes, GitOps, observability, networking, and cloud-native application deployment.

---

# Table of Contents

- [Architecture](#architecture)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Repository Structure](#repository-structure)
- [Infrastructure Provisioning](#infrastructure-provisioning)
- [Cluster Configuration & AWS Integrations](#cluster-configuration--aws-integrations)
- [Application Deployment](#application-deployment)
- [Helm Deployment](#helm-deployment)
- [GitOps with Argo CD](#gitops-with-argo-cd)
- [Networking](#networking)
- [Persistent Storage](#persistent-storage)
- [Monitoring](#monitoring)
- [Alerting](#alerting)
- [Centralized Logging](#centralized-logging)
- [DNS & External Access](#dns--external-access)
- [Documentation](#documentation)
- [Project Validation](#project-validation)
- [Future Enhancements](#future-enhancements)

---

# Architecture

The platform combines AWS infrastructure, Kubernetes, GitOps, monitoring, logging, and networking components to deploy and manage a cloud-native application.

| High-Level Architecture | AWS Infrastructure |
|-------------------------|--------------------|
| ![](docs/screenshots/architecture/architecture-diagram.png) | ![](docs/screenshots/architecture/aws-services.png) |

---

# Features

## Infrastructure

- Infrastructure provisioning using Terraform
- Multi-AZ Amazon VPC architecture
- Amazon EKS Cluster
- Amazon RDS MySQL
- Amazon EBS CSI Driver
- Route 53 DNS integration

## Application Deployment

- Dockerized Java Spring Boot backend
- Dockerized Python Flask frontend
- Kubernetes Deployment Manifests
- Helm chart based deployment
- ConfigMaps and Secrets
- NGINX Ingress Controller

## GitOps

- Argo CD automated synchronization
- Helm-based backend deployment
- Declarative Kubernetes deployment

## Observability

- Prometheus monitoring
- Grafana dashboards
- Alertmanager alerts
- Fluent Bit log collection
- Elasticsearch log indexing
- Kibana log visualization

---

# Technology Stack

| Category | Technologies |
|-----------|--------------|
| Cloud | AWS |
| Infrastructure as Code | Terraform |
| Programming Languages | Java, Python |
| Containerization | Docker |
| Container Registry | Docker Hub |
| Container Orchestration | Amazon EKS |
| Package Management | Helm |
| GitOps | Argo CD |
| Database | Amazon RDS MySQL |
| Monitoring | Prometheus |
| Dashboards | Grafana |
| Alerting | Alertmanager |
| Logging | Fluent Bit, Elasticsearch, Kibana |
| Networking | Route53, NGINX Ingress Controller, AWS Load Balancer Controller |
| Storage | Amazon EBS CSI Driver |
| Version Control | Git & GitHub |

---

# Repository Structure

```text
aws-eks-devops-platform/
│
├── application/
│   ├── backend/                     # Java Spring Boot backend
│   └── frontend/                    # Python Flask frontend
│
├── docs/
│   ├── deployment-guide.md          # Complete deployment guide
│   ├── cleanup-guide.md             # Infrastructure cleanup guide
│   ├── architecture.md              # Architecture explanation
│   └── screenshots/
│       ├── architecture/
│       ├── aws/
│       ├── argocd/
│       ├── grafana/
│       ├── prometheus/
│       ├── kibana/
│       └── application/
│
├── kubernetes/
│   ├── deployment-manifests/
│   │   ├── backend/
│   │   └── frontend/
│   │
│   ├── helm/
│   │   └── datastore-backend/
│   │
│   ├── networking/
│   ├── monitoring/
│   ├── logging/
│   ├── storage/
│   ├── automation/
│   └── alerting/
│
├── scripts/
│   └── install-tools.sh
│
├── terraform/
│
├── .gitignore
│
└── README.md
```

---

> **Note**
>
> Detailed deployment steps, architecture explanations, and cleanup procedures are available inside the **docs/** directory.
