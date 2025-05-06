# Phase 1 - K3s, Google Cloud, Terraform, K8s
Goals: 
- setup minimal self-managed k8s cluster on k8s via tf
- setup k3s cluster locally
- deploy microservice application to both
- have multiple environments
- use services such as helm, terraform workspaces, github actions
- compare self-managed services to GCP services
- setup basic monitoring

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

## Step 4 - deploy microservice to k8s

## Step 5 - diversive setup, create staging and prod in cloud, dev on local k3s cluster

# Phase 2 - AWS


# Journal
## Tue, 6. May
- GCloud setup easy
- creating resource easy
- templated tf code via earthly
- need to import cli-created resource ...