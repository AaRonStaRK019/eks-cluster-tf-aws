# EKS Cluster Infrastructure Deployment

This guide outlines the steps for deploying an Amazon Elastic Kubernetes Service (EKS) cluster using Terraform.

## Prerequisites

Ensure you have the following tools installed and configured:

- **AWS Account:** With necessary permissions to create resources.
- **Terraform:** Installed on your machine (v1.0 or later recommended).
- **AWS CLI:** Installed and configured with appropriate credentials.
- **Git (optional):** For version control and collaboration.

---

## Deployment Steps

### 1. Clone the Repository (if applicable)
If your Terraform configuration is hosted on a Git repository:
```bash
git clone <repository_url>
cd <repository_name>
```

### 2. Initialize Terraform
Run the following command to initialize your working directory:
```bash
terraform init
```
This will download the required providers and modules.

### 3. Configure AWS Credentials
You can set up AWS credentials using one of these methods:
- **AWS CLI Configuration:** Run `aws configure` to set your credentials.
- **Environment Variables:**
  ```bash
  export AWS_ACCESS_KEY_ID=<your_access_key>
  export AWS_SECRET_ACCESS_KEY=<your_secret_key>
  export AWS_REGION=<region>
  ```
- **AWS Credentials File:** Store your credentials in `~/.aws/credentials`.

### 4. Review and Customize Variables
- Open the `variables.tf` file to review and customize values for your environment.
- Key variables:
  - `aws_region`: Specify the AWS region (e.g., `us-east-1`).
  - `vpc_cidr`: CIDR block for the VPC.
  - `kubernetes_version`: Set a supported Kubernetes version (e.g., `1.27`).

  **Important:** Avoid using `latest` for `kubernetes_version` as AWS does not support it. Refer to the [AWS documentation](https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html) for valid versions.

### 5. Plan the Infrastructure
Generate a plan for your resources:
```bash
terraform plan
```
Carefully review the output to ensure no unexpected changes will occur.

### 6. Apply the Infrastructure
Apply the changes to create your EKS cluster:
```bash
terraform apply --auto-approve
```

### 7. Validate the Cluster (Optional)
Verify the cluster’s status via the AWS Console or CLI:
```bash
aws eks describe-cluster --name <cluster_name> --region <region>
```

---

## Troubleshooting

### Error: Unsupported Kubernetes Version
If you encounter:
```
InvalidParameterException: unsupported Kubernetes version 2.35.1
```
**Resolution:**
1. Check the supported Kubernetes versions for your AWS region:
   ```bash
   aws eks describe-addon-versions --query "addons[].addonVersions[].kubernetesVersion" --output text
   ```
2. Update the `kubernetes_version` variable in `variables.tf` to a valid version (e.g., `1.27`):
   ```hcl
   variable "kubernetes_version" {
       description = "Kubernetes version"
       default     = "1.27"
   }
   ```
3. Re-run `terraform plan` and `terraform apply`.

### Error: Invalid Subnet Configuration
If Terraform cannot find private subnets for your cluster:
- Ensure the `vpc.tf` file defines `private_subnets` correctly in the VPC module.
- Verify the `subnet_ids` in `eks-cluster.tf` points to `module.vpc.private_subnet_ids` (without quotes).

---

## Best Practices

- **Security:** Use least-privilege IAM roles and secure access to your EKS cluster.
- **Version Control:** Track changes to your infrastructure code with Git.
- **Testing:** Test the configuration in a non-production environment before deployment.
- **Monitoring:** Enable logging and monitoring using AWS CloudWatch or Prometheus.

---

## Disclaimer

This guide provides a general framework for deploying EKS with Terraform. Adjustments may be required based on your environment or specific project needs. For detailed documentation, refer to the [Terraform AWS EKS Module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest) and AWS resources.

---

