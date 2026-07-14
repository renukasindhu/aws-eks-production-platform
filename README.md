# AWS EKS Platform with GitOps, Monitoring & Logging

## Project Overview

This project demonstrates the deployment of a cloud-native application on Amazon Elastic Kubernetes Service (Amazon EKS) using modern DevOps practices. The infrastructure is provisioned with Terraform, the application is containerized using Docker, Kubernetes resources are managed with YAML manifests and Helm, and GitOps is implemented for the backend application using Argo CD.
The platform also includes monitoring with Prometheus and Grafana, alerting with Alertmanager, and centralized logging using Fluent Bit, Elasticsearch, and Kibana (EFK). An Amazon RDS MySQL database is used as the backend data store, while supporting AWS components such as the AWS Load Balancer Controller and Amazon EBS CSI Driver provide ingress management and persistent storage.
The objective of this project was to build an end-to-end Kubernetes platform that closely resembles real-world deployment practices while gaining hands-on experience with infrastructure provisioning, application deployment, observability, and GitOps workflows. 

## Architecture

## Features
