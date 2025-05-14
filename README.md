# Overview

This documentation outlines the steps taken to set up a minimal self-managed K3s cluster on Google Cloud Platform (GCP) using Terraform and Ansible. It includes requirements, setup procedures, and notes on troubleshooting and future considerations.

# Versions

    K3s: v1.32.4+k3s1
    Terraform: v1.11.3
    Ansible: 2.18.3, Jinja: 3.1.6
    Python: 3.13.2
    Google Cloud SDK 464.0.0


# Requirements
- [install gcloud cli](https://cloud.google.com/sdk/docs/install)  
- Authenticate with GCP:
```
gcloud auth login
gcloud auth application-default login`  
gcloud init
````

-  Generate SSH Key: 
```
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_k3s
```

# Terraform Setup
1. __Install Terraform__:  
```
brew install terraform
```

2. __Create a GCS Bucket for State Management__
- Bucket Name: __23f48053572b634d-terraform-remote-backend__
- Ensure public access is denied, the bucket is located in europe-west10 (Berlin), and versioning is enabled for state locking.

3. __Initialize and Apply Terraform Configuration__
```
cd terraform
terraform init
terraform apply
```
4. __Deploy K3s using Ansible__
```
cd ../ansible
ansible-playbook -i hosts.ini install_k3s.yml
```
# Phase 1 - K3s, Google Cloud, Terraform, K8s
## Goals
- Setup minimal self-managed k3s cluster on GCP via Terraform
- Setup k3s cluster locally
- Deploy microservice application to both
- Have multiple environments, e.g. dev, staging, prod
- Use services such as helm, terraform workspaces, github actions
- Compare self-managed services to GCP services
- Setup basic monitoring
- Check out service mesh

## Step 1 - connect via command line and create simple resource
1. [Install gcloud CLI](https://cloud.google.com/sdk/docs/install)  
2. Configure GCloud SDK
```
gcloud config list
gcloud auth login
gcloud auth configure-docker
```

3. Create a compute instance
```
gcloud compute instances create test-1
    --machine-type=f1-micro 
    --image-family=debian-11 
    --image-project=debian-cloud
```

## Step 2: Create test resources via tf
- Authenticate for application default credentials  
```
gcloud auth application-default login
```
- Run Terraform  
```
cd terraform && terraform plan && terraform apply -auto-approve
```

## Step 3: research minimal k8s setup on gcp and create via tf
- Utilize three e2-small instances: one master and two worker nodes  
- Deploy K3s using Ansible:
    - K3s will be installed to `/usr/local/bin/k3s`
    - Uninstall script located at `/usr/local/bin/k3s-agent-uninstall.sh`
    - Ensure the service runs as `k3s-agent.service`
- [resolve ssh key issue by using OS Login](https://alex.dzyoba.com/blog/gcp-ansible-service-account/)



## Step 4 - deploy microservice to k8s

## Step 5 - diversive setup, create staging and prod in cloud, dev on local k3s cluster

# Phase 2 - AWS
_Details for AWS integration can be added here as needed._

# Todo
- Evaluate different programmatic authentication methods for TF->GCP
- Replace ADC with credentials
- Use "Secure Tokens" with Google Secrets Manager, to manage k3s tokens for the workers
- decide on setting "type" explictly or implictly, reducing redundance
- evaluate which values to store as variables
- evaluate, if i need subnets
- setup google OS login for centralized access management via roles and iam permsissions

# Known Issues and Technical Debt
- Disabled host-key-checking with ansible, so new hosts don't create a fingerprint missmatch error. It should rather be updated when new hosts are created instead of ignored

# Journal  
## May 14  
- Use Service Account for Ansible
    - 
- added oslogin to main.tf
    - had to import it, because it was created manually before: `terraform import google_compute_project_metadata_item.enable_os_login enable-oslogin`
- hosts.ini is still not created properly, master is set to `null`, although ip is correctly printed as output

## May 13
- Trying to deploy k3s manually, then with k3sup
- Error deploying agent to nodes:  
    E0513 07:32:39.189784  116409 memcache.go:265]  
        "Unhandled Error" err="couldn't get current server API group list:   
        Get \"http://localhost:8080/api?timeout=32s\":   
        dial tcp [::1]:8080: connect: connection refused"  
    The connection to the server localhost:8080 was refused - did you specify the right host or port?  
    - sudo systemctl status k3s  
        Unit k3s.service could not be found.  
    -> k3s is not installed properly / not starting  
-  Error: Error trying to delete bucket 23f48053572b634c-terraform-remote-backend containing objects without `force_destroy` set to true  
    - I created to GCS bucket to store the terraform state file via terraform, now it's trying to delete it which shouldn't happen  
    - removing the bucket and deploying it manually, to not be managed by terraform  
    - did not destroy it via terraform, but manually, now it needs to be removed from state file:
        - `terraform state list` > `terraform state rm <resource>`
- tf will randomly create a `print y` loop, when giving the yes input to accept an apply
    -> this is the command /usr/bin/yes that will loop y if no other input is given
- Error running command '../update_hosts.sh': exit status 5. Output: jq: error (at <stdin>:1): Cannot iterate over
│ null (null)  
    - when creating resources from zero, this will happen. A second apply will run succesfully. Is this debt__?__
- Redeploying results in an ansible error, due to the host key being old


## May 12
- Add GCS bucket to manage terraform state file remotely
- chicen-egg issue: create bucket with local backend, then migrate backend. How do i resolve this now on a different machine? Is this debt__?__

## May 8
- deploy ssh key: `ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_k3s`
- use it with terraform
- i am assigning dns records to my instances, so i dont have to update my hosts.ini everytime 
i restart them. This is just shifting the issue: i need to run terraform now every time
after restarting, to update the records, which will then also take some time to propagate.
I could have a cloud function to do this dynamically.
- `ansible-playbook -i hosts.ini install_k3s.yml `
- ***NameError:NameError("name 'hostvars' is not defined")
    - this was a matter of correctly referencing variables within hostvars
- switching machines creates the need for a remote state file

## May 7
- compare K8s alternatives like k0s, k3s, kind, minikube
- compare helm and kustomize
- created nodes for k3s, but no ssh access

## May 6
- GCloud setup easy
- creating resource easy
- templated tf code via earthly
- need to import cli-created resource ... can't resolve `Error: Cannot determine zone: set in this resource, or set provider-level zone.`, skipping this issue for now and removing manually
