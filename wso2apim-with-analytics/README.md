## Install WSO2 API Manager with Analytics in Kubernetes

#### Installation Prerequisites

* [Helm](https://helm.sh/docs/intro/install/) v3.1.0 or above

This is used to deploy the NFS Provisioner and this used for persistent volumes.

##### Setup persistent volumes

```
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm install nfs-provisioner stable/nfs-server-provisioner
```

<br>

#### Deploy Artifacts

```
>> kubectl apply -f artifacts/1_wso2-namespace.yaml -f artifacts/2_mysql/ -f artifacts/3_configmaps/

Wait for few seconds until Mysql pod is ready

>> kubectl apply -f artifacts/4_pvcs.yaml -f artifacts/5_custom-pattern.yaml
```

<br>

#### Access API Manager

To access the API Manager, add a host mapping entry to the /etc/hosts file. As we have exposed the API portal service in Node Port type, you can use the IP address of any Kubernetes node.

```
<Any K8s Node IP>  wso2apim wso2apim-analytics
```

- For Docker for Mac use "127.0.0.1" for the K8s node IP
- For Minikube, use minikube ip command to get the K8s node IP
- For GKE
    ```
    (kubectl get nodes -o jsonpath='{ $.items[*].status.addresses[?(@.type=="ExternalIP")].address }')
    ```
    - This will give the external IPs of the nodes available in the cluster. Pick any IP to include in /etc/hosts file.
  
- **API Publisher** : https://wso2apim:32001/publisher 
- **API Devportal** : https://wso2apim:32001/devportal 
- **API Analytics Dashboard**   : https://wso2apim-analytics:32201/analytics-dashboard 

<br>

#### Delete Artifacts

```
>> kubectl apply -f artifacts/ -R
```
