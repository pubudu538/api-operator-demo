## API Operator for Kubernetes Demo Artifacts

### Prerequisits

- CI/CD Server (Jenkins)
- Version control system (GitHub)
- API Operator v1.1.0 distribution
- API Controller v3.1.0 (CLI distribution)
- API Manager installed

### Configure Jenkins

Copy the bash scripts in jenkins-resources/ to a location in Jenkins.

Make sure they can be accessed by the Jenkins user.

### Configure build job - Multibranch pipeline

Go to Jenkins *New Item -> Multibranch Pipeline -> Create*

- Configure the GitHub repository that the APIs should be fetched from.

### GitHub repository

Create a GitHub repository to maintain the APIs.
Create seperate branches for the APIs that you want to deploy.
- products-api
- onlinestore-api

Go to the repository settings and create a GitHub webhook for *push* events by pointing to the Jenkins server.

Cope the *Jenkinsfile* in jenkins-resources/Jenkinsfile and place it under every branch that you are creating for APIs.

Note: In each branch, you have to change the following varibles.
    -   APINAME: branch name 
    -   REPO: The repository APIs are being fetched (org/repo format)
    -   you may find placeholders to mention the paths to bash scripts we places in Jenkins machine in previous step.
    -   Make sure to give correct paths to those bashfiles within the *Jenkinsfile*



  

 