# Terraform WordPress Infrastructure on AWS

This Terraform project deploys a complete WordPress infrastructure on AWS using a modular approach. The infrastructure includes VPC networking, database server, WordPress application servers with auto-scaling capabilities.

## Architecture Overview

The infrastructure consists of the following components:

- **VPC Module**: Creates an isolated network environment with public and private subnets
- **Database Module**: Deploys an EC2 instance running MySQL in the private subnet
- **WordPress Module**: Deploys WordPress application servers using Auto Scaling Groups
- **Remote State**: Terraform state is stored in an S3 bucket for team collaboration and state locking

## Prerequisites

Before you begin, ensure you have:

- AWS CLI configured with appropriate credentials
- Terraform >= 6.0 installed
- An S3 bucket created for storing Terraform state
- MySQL AMI ID (pre-configured with MySQL)
- WordPress AMI ID (pre-configured with WordPress)
- SSH key pair created in AWS

## Project Structure

```
├── main.tf                     # Root module configuration
├── variables.tf                # Root module variables
├── outputs.tf                  # Root module outputs
├── backend.tf                  # S3 backend configuration
├── provider.tf                 # root module for specify terraforma and aws version
└── modules/
    ├── vpc/
    │   ├── main.tf             # VPC, subnets, route tables, IGW
    │   ├── variables.tf        # Input variables for VPC module
    │   └── outputs.tf          # Outputs for VPC module (e.g., vpc_id, subnet_ids)
    │
    ├── db/
    │   ├── main.tf             # EC2 instance for MySQL
    │   ├── variables.tf        # Input variables for DB module (e.g., instance_type, db_name)
    │   └── outputs.tf          # Outputs for DB module (e.g., db_endpoint, db_instance_id)
    │
    └── wordpress/
        ├── main.tf             # Launch template, ASG, ALB
        ├── variables.tf        # Input variables for WordPress module (e.g., ami_id, instance_type)
        └── outputs.tf          # Outputs for WordPress module (e.g., alb_dns_name, asg_name)
```


## Module Details

### VPC Module

Creates the network infrastructure:

- **VPC**: A custom VPC with a specified CIDR block
- **Public Subnet**: Subnet with internet access via Internet Gateway
- **Private Subnet**: Subnet for database and internal resources
- **Internet Gateway**: Provides internet access to public subnet
- **Route Tables**: Separate route tables for public and private subnets with appropriate associations

**Outputs**: VPC ID, subnet IDs, security group IDs

### Database Module

Deploys the MySQL database server:

- **EC2 Instance**: Launches an EC2 instance from a pre-configured MySQL AMI
- **Security Group**: Controls inbound/outbound traffic to the database
- **Private Subnet Placement**: Ensures the database is not directly accessible from the internet

**Outputs**: Database private IP address

### WordPress Module

Deploys the WordPress application layer:

- **Launch Template**: Defines the configuration for WordPress EC2 instances
- **Auto Scaling Group**: Automatically scales WordPress instances based on demand
- **Security Groups**: Controls access to WordPress instances and load balancer

**Outputs**: Auto Scaling Group name

## Backend Configuration

The Terraform state is stored remotely in an S3 bucket with the following configuration:

```hcl
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile = true 
  }
}
```

**Benefits:**
- Team collaboration with shared state
- State locking to prevent concurrent modifications
- State versioning for rollback capabilities
- Encryption at rest for security

## Usage

### 1. Initialize Terraform

```bash
terraform init
```

This command:
- Downloads required provider plugins
- Configures the S3 backend
- Initializes the working directory

### 2. Configure Variables

Create a `terraform.tfvars` file with your specific values:

```hcl
aws_region          = "us-east-1"
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
mysql_ami_id        = "ami-xxxxxxxxxxxxxxxxx"
wordpress_ami_id    = "ami-xxxxxxxxxxxxxxxxx"
key_name            = HazemEc2Task"
db_instance_type    = "t3.small"
wp_instance_type    = "t3.small"
asg_min_size        = 1
asg_max_size        = 3
asg_desired_size    = 1
```

### 3. Plan the Deployment

```bash
terraform plan
```

Review the execution plan to ensure all resources will be created as expected.

### 4. Apply the Configuration

```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment.




## Important Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `aws_region` | AWS region for deployment | `us-east-1` |
| `vpc_cidr` | CIDR block for VPC | `10.0.0.0/16` |
| `mysql_ami_id` | AMI ID with MySQL pre-installed | `ami-xxxxx` |
| `wordpress_ami_id` | AMI ID with WordPress pre-installed | `ami-xxxxx` |
| `asg_min_size` | Minimum number of WordPress instances | `1` |
| `asg_max_size` | Maximum number of WordPress instances | `3` |

## Outputs

After deployment, Terraform provides the following outputs:

- `vpc_id`: The ID of the created VPC
- `public_subnet_id`: The ID of the public subnet
- `private_subnet_id`: The ID of the private subnet
- `database_private_ip`: Private IP address of the MySQL database
- `wordpress_url`: Load balancer URL to access WordPress
- `asg_name`: Name of the Auto Scaling Group

## Cleanup

To destroy all resources:

```bash
terraform destroy
```

Type `yes` when prompted. This will remove all infrastructure created by Terraform.

## Security Considerations

- Database instances are deployed in private subnets with no direct internet access
- Security groups follow the principle of least privilege
- State file is encrypted in S3


## Troubleshooting

### State Lock Issues

If you encounter a state lock error:

```bash
terraform force-unlock <LOCK_ID>
```

### Backend Configuration Changes

If you modify the backend configuration:

```bash
terraform init -reconfigure
```

### Module Updates

After updating module code:

```bash
terraform get -update
terraform plan
```


