## Objectives
Deploy a secure and highly redundant API in AWS using lambda / API Gateway / Cognito.

## Principles

### Organization
- demoapp-go-gin: demo docker lambda funtion
- modules: handle the resources templates to guarantee "Company" consistency ( naming / tags ) and security
- commonInfrastructure: handle the landing zone
- applications: handle the applications

Applications and Infrastructure are split because they do not follow the same Lifecycle and responsabilities.

### conventions
- naming: (has to be "future" proof) company-env-label
- tagging: (can be changed at anytimes)
  - team
  - environment

### security
- every resources are encrypted by default with new KMS keys
- create new IAM roles for most of the resources 

### environments
- environments are managed by terraform workspaces with short label : dev / pre / prd

### evolutions
- split the repositories (not only the directories)

