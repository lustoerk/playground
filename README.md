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
`gcloud config list`   
`gcloud auth login`  
`gcloud auth configure-docker`  

```
gcloud compute instances create test-1
    --machine-type=f1-micro 
    --image-family=debian-11 
    --image-project=debian-cloud
```

## Step 2 - create test resources via tf

`gcloud auth application-default login`
see /terraform

## Step 3 - research minimal k8s setup on gcp and create via tf
- 3 ec2-small nodes, 1 master, 2 worker
- using k3s


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

# Journal
## Thu, 8. May 
- deploy ssh key: ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_k3s
- use it with terraform
- i am assigning dns records to my instances, so i dont have to update my hosts.ini everytime 
i restart them. This is just shifting the issue: i need to run terraform now every time
after restarting, to update the records, which will then also take some time to propagate.
I could have a cloud function to do this dynamically.

## Wed, 7. May
- compare K8s alternatives like k0s, k3s, kind, minikube
- compare helm and kustomize
- created nodes for k3s, but no ssh access

## Tue, 6. May
- GCloud setup easy
- creating resource easy
- templated tf code via earthly
- need to import cli-created resource ... can't resolve `Error: Cannot determine zone: set in this resource, or set provider-level zone.`, skipping this issue for now and removing manually
