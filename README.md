# Project Bedrock

## Architecture
- EKS Cluster: project-bedrock-cluster (us-east-1)
- VPC: project-bedrock-vpc
- Data Layer: RDS MySQL, RDS PostgreSQL, DynamoDB

## Prerequisites
```bash
aws eks update-kubeconfig --region us-east-1 --name project-bedrock-cluster
kubectl create namespace retail-app
```

## Deploy Application (Single Command)
```bash
helm upgrade --install retail-store \
  oci://public.ecr.aws/aws-containers/retail-store-sample-ui-chart \
  --namespace retail-app \
  --values helm/values.yaml \
  --wait --timeout 10m
```

## CI/CD Pipeline
- Pull Request → triggers `terraform plan` (output posted as PR comment)
- Merge to master → triggers `terraform apply`

## Infrastructure Details

| Resource | Value |
|---|---|
| EKS Cluster | project-bedrock-cluster |
| Region | us-east-1 |
| VPC | project-bedrock-vpc |
| App Namespace | retail-app |
| App URL (HTTP) | http://k8s-retailap-retailst-17d19cf248-169468874.us-east-1.elb.amazonaws.com/ |
| Assets Bucket | bedrock-assets-alt-soe-025-3508 |
| Lambda | bedrock-asset-processor |

## Developer Access
- IAM User: bedrock-dev-view
- Permissions: ReadOnly (Console) + S3 PutObject (assets bucket) + K8s View (RBAC)

## Observability
- CloudWatch Control Plane logs: /aws/eks/project-bedrock-cluster/cluster
- CloudWatch Container logs: /aws/containerinsights/project-bedrock-cluster/application

## Access the Application
http://k8s-retailap-retailst-17d19cf248-169468874.us-east-1.elb.amazonaws.com/

## Grading Credentials
See submission Google Doc for credentials.

## Tear Down
```bash
cd terraform
terraform destroy -var-file="terraform.tfvars" -auto-approve
```