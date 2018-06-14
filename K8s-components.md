# Headless Services 
```
- The definition of headless service is similar to the standard service, but it doesn't have the clusterIP. Simply adding clusterIP: none in yaml definition will create a headless service. 
- Headless services is created to reach directly to a  pod in k8s , Assume there is a application running on k8s having replication controller 3 , when u create a service it act as a load balancer through which user can reach to the service , but the fact is that we dont know which pod giving you response when u reach to services, but incase of headless services you can reach to particular pod 
- Assue we have a application ealsticsearch erunning With headless service, the Pod elasticsearch-0 could use ealsticsearch-1.ealsticsearch-server to talk to elasticsearch-1 directly.The form is <StatefulSet-Name>-<Ordinal-Index>.<ServiceName>.
