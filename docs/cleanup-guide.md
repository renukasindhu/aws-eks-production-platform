# Cleanup Guide
This guide explains how to safely remove all resources created by the project and avoid unnecessary AWS charges.

---

# Delete Kubernetes Resources
Delete the application resources.
```bash
kubectl delete -f kubernetes/deployment-manifests/
```

Delete additional platform components if they were deployed separately.
- Argo CD
- Monitoring
- Logging
- Storage resources

Verify that all namespaces and workloads have been removed.
```bash
kubectl get all --all-namespaces
```

---

# Remove Helm Releases
List installed Helm releases.
```bash
helm list -A
```

Uninstall each release.

Example:
```bash
helm uninstall prometheus -n monitoring
helm uninstall grafana -n monitoring
helm uninstall datastore-backend -n backend
```

Verify the releases have been removed.
```bash
helm list -A
```

---

# Destroy Terraform Infrastructure
Navigate to the Terraform directory.
```bash
cd terraform
```

Review the resources to be removed.
```bash
terraform plan -destroy
```

Destroy the infrastructure.
```bash
terraform destroy
```

Terraform removes:
- Amazon VPC
- Public and Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- Amazon EKS Cluster
- Managed Node Group
- Amazon RDS MySQL

---

# Manual Cleanup
Some AWS resources may remain after Terraform destroy depending on the deployment state or installed add-ons. \
Verify the following services before considering the cleanup complete.

### Amazon EBS
Check for remaining EBS volumes. \
Delete any unused volumes that were dynamically created by Kubernetes.

---

### CloudFormation
Check for remaining CloudFormation stacks created by AWS add-ons. \
Delete any stacks that are no longer required.

---

### Load Balancer 
Verify that the Application Load Balancer has been removed. \
If necessary, delete it manually.

---

### Route 53 
Remove DNS records that point to deleted load balancers. \
Delete the hosted zone if it is no longer required.

---

### Security Groups
Verify that unused security groups have been removed.

---

# Verify Cleanup
Confirm that no project resources remain. \
Verify:
- No running Amazon EKS clusters
- No Amazon RDS instances
- No EC2 instances
- No Application Load Balancers
- No NAT Gateways
- No EBS volumes
- No CloudFormation stacks
- No Route 53 records (if removing the domain)
- No remaining Kubernetes resources \
The environment has now been completely cleaned up.
