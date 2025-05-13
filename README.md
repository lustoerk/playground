# Requirements
- [install gcloud cli](https://cloud.google.com/sdk/docs/install)  
- `gcloud auth login`  
- `gcloud auth application-default login`  
- `gcloud init`  
- `ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_k3s`

## Terraform setup
- brew install terraform
- create GCS Bucket to store state file
    - 23f48053572b634d-terraform-remote-backend
    - public access denied, local to europe-west10 (berlin) and versioned for allowing state locking
- `cd terraform && terraform init && terraform apply`  
- `cd ../ansible && ansible-playbook -i hosts.ini --install_k3s.yml`

# Phase 1 - K3s, Google Cloud, Terraform, K8s
Goals: 
- Setup minimal self-managed k3s cluster on GCP via Terraform
- Setup k3s cluster locally
- Deploy microservice application to both
- Have multiple environments, e.g. dev, staging, prod
- Use services such as helm, terraform workspaces, github actions
- Compare self-managed services to GCP services
- Setup basic monitoring
- Check out service mesh

## Step 1 - connect via command line and create simple resource
- [install gcloud cli](https://cloud.google.com/sdk/docs/install)  
- `gcloud config list`   
- `gcloud auth login`  
- `gcloud auth configure-docker`  

Create an instance
```
gcloud compute instances create test-1
    --machine-type=f1-micro 
    --image-family=debian-11 
    --image-project=debian-cloud
```

## Step 2 - create test resources via tf

- `gcloud auth application-default login`  
- see /terraform  

## Step 3 - research minimal k8s setup on gcp and create via tf
- 3 ec2-small nodes, 1 master, 2 worker
- deploy k3s using ansible


## Step 4 - deploy microservice to k8s

## Step 5 - diversive setup, create staging and prod in cloud, dev on local k3s cluster

# Phase 2 - AWS


# Todo
- Evaluate different programmatic authentication methods for TF->GCP
- Replace ADC with credentials

# Nice to have
- Use "Secure Tokens" with Google Secrets Manager, to manage k3s tokens for the workers
- decide on setting "type" explictly or implictly, reducing redundance
- evaluate which values to store as variables
- evaluate, if i need subnets
- setup google OS login for centralized access management via roles and iam permsissions


# Debt

# Journal  
## Tue, 13. May  
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
- Error running command '../update_hosts.sh': exit status 5. Output: jq: error (at <stdin>:1): Cannot iterate over
│ null (null)  
    - when creating resources from zero, this will happen. A second apply will run succesfully. Is this debt__?__
- Redeploying results in an ansible error, due to the host key being old


## Mo, 12. May
- Add GCS bucket to manage terraform state file remotely
- chicen-egg issue: create bucket with local backend, then migrate backend. How do i resolve this now on a different machine? Is this debt__?__

## Thu, 8. May 
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

## Wed, 7. May
- compare K8s alternatives like k0s, k3s, kind, minikube
- compare helm and kustomize
- created nodes for k3s, but no ssh access

## Tue, 6. May
- GCloud setup easy
- creating resource easy
- templated tf code via earthly
- need to import cli-created resource ... can't resolve `Error: Cannot determine zone: set in this resource, or set provider-level zone.`, skipping this issue for now and removing manually
