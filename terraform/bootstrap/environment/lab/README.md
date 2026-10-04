# 🔧 Bootstrap — Remote Terraform State

This directory creates the **Storage Account** that will store the remote `terraform.tfstate`
for all main deployments.

## ⚠️ Important

- Run this **once** before any other deployment.
- Uses **local state** (the `terraform.tfstate` stays here, git-ignored).
- **Do not destroy** this resource while active deployments exist.

## 🚀 Usage

```bash
cd terraform/bootstrap/environment/lab/

# Set your subscription (pick one method):
export ARM_SUBSCRIPTION_ID="<your-subscription-id>"
# or: az account set --subscription "<name-or-id>"

# 1. Initialize
terraform init

# 2. Review the plan
terraform plan

# 3. Create the remote state Storage Account
terraform apply
```

After `apply`, Terraform will print the backend configuration block to copy into
`manifests/environment/lab/provider.tf`.

## 📋 Resources created

| Resource | Default name | Purpose |
|----------|-------------|---------|
| Resource Group | `rg-tf-bootstrap-001` | Group bootstrap resources |
| Storage Account | `stterraformstate001` | Store tfstate files |
| Blob Container | `tfstate` | Container for state files |
