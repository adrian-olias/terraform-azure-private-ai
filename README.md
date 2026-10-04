# 🏗️ Azure Private AI Lab — Terraform Infrastructure

> **Portfolio project.** Infrastructure-as-Code for a **secure, private AI platform** on Azure,
> deployed from scratch with Terraform. Zero public exposure — VM isolated behind Bastion / Cloudflare Tunnel.

---

## 📐 Architecture

```
┌────────────────────────────────────────────────────────────────────┐
│  Resource Group: rg-ai-lab-001  (spaincentral / adjustable)        │
│                                                                    │
│  ┌──────────────────────────────────────────┐                      │
│  │  VNet: vnet-ai-lab (10.0.0.0/16)         │                      │
│  │                                          │                      │
│  │  ┌────────────────────────────────────┐  │  ┌─────────────────┐ │
│  │  │ snet-compute-001  (10.0.1.0/24)   │  │  │  Storage        │ │
│  │  │                                    │  │  │  Account (LRS)  │ │
│  │  │  ┌──────────────────────────────┐  │  │  │                 │ │
│  │  │  │ vm-ai-engine-001             │──┼──┼─►│ docs container  │ │
│  │  │  │ Ubuntu 22.04 + NVIDIA GPU    │  │  │  │ (Blob Reader)   │ │
│  │  │  │ Docker + NVIDIA Toolkit      │  │  │  │                 │ │
│  │  │  │ System-assigned MI  ─────────┼──┼──┼─►│                 │ │
│  │  │  └──────────────────────────────┘  │  │  └─────────────────┘ │
│  │  │                                    │  │                      │
│  │  │  NSG: nsg-ai-lab                   │  │  ┌─────────────────┐ │
│  │  │  ✅ SSH (22) — deployer IP only    │  │  │  Key Vault      │ │
│  │  │  🔒 All other traffic blocked      │  │  │  (standard)     │ │
│  │  └────────────────────────────────────┘  │  └─────────────────┘ │
│  │                                          │                      │
│  │  ┌────────────────────────────────────┐  │  ┌─────────────────┐ │
│  │  │ snet-private-endpoint (10.0.2.0/24)│  │  │  ACR (Basic)    │ │
│  │  │  Private Endpoints → Storage + KV  │  │  │  Managed ID     │ │
│  │  └────────────────────────────────────┘  │  │  AcrPull role   │ │
│  └──────────────────────────────────────────┘  └─────────────────┘ │
└────────────────────────────────────────────────────────────────────┘

Bootstrap (rg-tf-bootstrap-001)
  └── Storage Account → tfstate blob container
```

---

## 📁 Repository Structure

```
terraform/
│
├── bootstrap/                          # 🔧 Remote Terraform state setup (run once)
│   └── environment/
│       └── lab/
│           ├── provider.tf             # AzureRM provider (local state)
│           ├── tfstate_storage_account.tf  # Storage Account for tfstate
│           ├── variables.tf            # Bootstrap variables
│           └── README.md
│
├── manifests/                          # 🚀 Environment deployment
│   └── environment/
│       └── lab/
│           ├── provider.tf             # Provider + remote backend
│           ├── main.tf                 # Calls the environment_group module
│           ├── variables.tf            # Environment variables (no secrets)
│           ├── terraform.tfvars.example  # ✅ Template — copy to terraform.tfvars
│           └── outputs.tf              # Deployment outputs
│
└── modules/
    └── environment_group/              # 📦 Reusable module
        ├── main.tf                     # Resource Group + data sources
        ├── network.tf                  # VNet + Subnets + NSG rules
        ├── storage_account.tf          # Storage Account + blob container
        ├── virtual_machine.tf          # VM + NIC + Managed Identity
        ├── acr.tf                      # Azure Container Registry
        ├── key_vault.tf                # Key Vault + access policies
        ├── roles.tf                    # RBAC assignments
        ├── github.tf                   # Service Principal for CI/CD
        ├── variables.tf                # Module input variables
        ├── outputs.tf                  # Module outputs
        └── cloud-init/
            └── bastion-install-gpu.sh  # Docker + NVIDIA Container Toolkit
```

---

## 🚀 Deployment Guide

### Prerequisites

| Tool        | Min version | Install |
|-------------|-------------|---------|
| Terraform   | >= 1.5.0    | [terraform.io](https://developer.hashicorp.com/terraform/install) |
| Azure CLI   | >= 2.50     | `winget install Microsoft.AzureCLI` |
| SSH key     | RSA 4096    | `ssh-keygen -t rsa -b 4096` |

### Step 1 — Azure login

```bash
az login
az account set --subscription "<your-subscription-name-or-id>"

# Verify
az account show
```

### Step 2 — Bootstrap (run once)

Creates the remote Storage Account for Terraform state:

```bash
cd terraform/bootstrap/environment/lab/

# Subscription is read automatically from the active az CLI context
terraform init
terraform plan
terraform apply
```

### Step 3 — Configure deployer IP

Create `terraform/manifests/environment/lab/terraform.tfvars` (git-ignored):

```bash
cp terraform/manifests/environment/lab/terraform.tfvars.example \
   terraform/manifests/environment/lab/terraform.tfvars
# Then edit terraform.tfvars with your values
```

```hcl
subscription_id = "<your-subscription-id>"
deployer_ip     = "<your-current-public-ip>"  # curl ifconfig.me
```

### Step 4 — Deploy infrastructure

```bash
cd terraform/manifests/environment/lab/
terraform init
terraform plan
terraform apply
```

### Step 5 — Connect to the VM

```bash
# Wait ~5 min for cloud-init + reboot
ssh azureaiuser@<VM_PRIVATE_IP_OR_BASTION> -i ~/.ssh/id_rsa

# Verify GPU + Docker
nvidia-smi
docker info
```

---

## 🔒 Security Measures

| Measure | Detail |
|---------|--------|
| **No public IP on VM** | Isolated VM, accessible only via Azure Bastion or Cloudflare Tunnel |
| **NSG restrictive** | SSH (22) from deployer IP only; all else blocked |
| **No passwords** | SSH key-only authentication (RSA 4096) |
| **Managed Identity** | VM accesses Storage without keys or tokens |
| **Least privilege** | `Storage Blob Data Reader` role only |
| **TLS 1.2** | Encrypted communication with Storage Account |
| **HTTPS enforced** | No HTTP connections permitted to Storage |
| **Private Blobs** | No public blob access |
| **Private Endpoints** | Storage + Key Vault not exposed to internet |
| **Remote state** | tfstate in Azure Storage with blob versioning |
| **No hardcoded secrets** | Subscription ID and IPs passed via env vars or git-ignored tfvars |

---

## 💰 Cost Optimization

| Resource | Choice | Reason |
|----------|--------|--------|
| Storage (data) | LRS | Minimum redundancy for lab |
| Storage (state) | LRS | Sufficient for tfstate |
| No public IP | — | Removed entirely (Bastion/Tunnel pattern) |
| VM Size | `Standard_NC4as_T4_v3` | NVIDIA T4 GPU — best performance/cost ratio |

> **💡 Tip:** Deallocate the VM when not in use:
> ```bash
> az vm deallocate -g rg-ai-lab-001 -n vm-ai-engine-001
> ```

---

## 🗑️ Destroy

```bash
# 1. Destroy main infrastructure
cd terraform/manifests/environment/lab/
terraform destroy

# 2. Destroy bootstrap (only if you no longer need the state backend)
cd terraform/bootstrap/environment/lab/
terraform destroy
```

---

## 🧩 Related Repository

This infrastructure repo is used alongside the application stack:
👉 [`azure-private-ai-cicd`](https://github.com/adrian-olias/azure-private-ai-cicd) — Docker Compose microservices + GitHub Actions CI/CD pipeline

---

## 📄 License

MIT — Free to use as a portfolio reference or starting point for your own projects.