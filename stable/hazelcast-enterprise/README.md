# Hazelcast Enterprise

[Hazelcast Enterprise](https://hazelcast.com) is a distributed computation and storage platform for consistently low-latency querying, aggregation and stateful computation against event streams and traditional data sources. It allows you to quickly build resource-efficient, real-time applications. You can deploy it at any scale from small edge devices to a large cluster of cloud instances.

A cluster of Hazelcast nodes share both the data storage and computational load which can dynamically scale up and down. When you add new nodes to the cluster, the data is automatically rebalanced across the cluster and currently running computational tasks (known as jobs) snapshot their state and scale with processing guarantees.

## Quick Start

    $ helm repo add hazelcast https://hazelcast-charts.s3.amazonaws.com/
    $ helm repo update
    $ helm install my-release --set hazelcast.licenseKey=<license_key> hazelcast/hazelcast-enterprise

For users who already added `hazelcast` repo to their local helm client before; you need to run `helm repo add` command again to use latest charts from our new chart repo:

    $ helm repo list
    NAME            URL
    hazelcast       https://hazelcast.github.io/charts/
    ...

    $ helm repo add hazelcast https://hazelcast-charts.s3.amazonaws.com/

    $ helm repo list
    NAME            URL
    hazelcast       https://hazelcast-charts.s3.amazonaws.com/
    ...


## Introduction

This chart bootstraps a [Hazelcast Enterprise](https://github.com/hazelcast/hazelcast-docker/tree/master/hazelcast-enterprise) and [Management Center](https://github.com/hazelcast/management-center-docker) deployments on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

-   Kubernetes 1.14+

## Installing the Chart

To install the chart with the release name `my-release`:

    $ helm install my-release --set hazelcast.licenseKey=<license_key> hazelcast/hazelcast-enterprise

The command deploys Hazelcast on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

    $ helm delete my-release

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the Hazelcast chart and their default values.

|Parameter|Description|Default|
|--- |--- |--- |
|image.repository|Hazelcast Image name|hazelcast/hazelcast-enterprise-kubernetes|
|image.tag|Hazelcast Image tag|{VERSION}|
|image.pullPolicy|Image pull policy|IfNotPresent|
|image.pullSecrets|Specify docker-registry secret names as an array|nil|
|cluster.memberCount|Number of Hazelcast members|3|
|hazelcast.enabled|Turn on and off Hazelcast application|true|
|hazelcast.licenseKey|Hazelcast Enterprise License Key|nil|
|hazelcast.licenseKeySecretName|Kubernetes Secret Name, where Hazelcast Enterprise License Key is stored (can be used instead of licenseKey)|nil|
|hazelcast.updateClusterVersionAfterRollingUpgrade|Enable Hazelcast cluster auto version upgrade after the rolling upgrade procedure|true|
|hazelcast.javaOpts|Additional JAVA_OPTS properties for Hazelcast member|nil|
|hazelcast.loggingLevel|Level of Hazelcast logs (OFF, FATAL, ERROR, WARN, INFO, DEBUG, TRACE and ALL)|nil|
|hazelcast.existingConfigMap|ConfigMap which contains Hazelcast configuration file(s) that are used instead hazelcast.yaml embedded into values.yaml|nil|
|hazelcast.yaml|Hazelcast YAML Configuration (hazelcast.yaml embedded into values.yaml)|{DEFAULT_HAZELCAST_YAML}|
|hazelcast.configurationFiles|Hazelcast configuration files|nil|
|annotations| Hazelcast Statefulset annotations| nil
|affinity|Hazelcast Node affinity|nil|
|tolerations|Hazelcast Node tolerations|nil|
|nodeSelector|Hazelcast Node labels for pod assignment|nil|
|topologySpreadConstraints| Control how Pods are spread across the cluster | {} |
|hostPort|Port under which Hazelcast PODs are exposed on the host machines|nil|
|customPorts|Whole ports section to customize how Hazelcast container ports are defined|nil|
|labels|Extra labels to add to the statefulset| {} |
|podLabels|Extra labels to add to the pod container metadata| {} |
|priorityClassName|Custom priority class name|<undefined>|
|gracefulShutdown.enabled|Turn on and off Graceful Shutdown|true|
|gracefulShutdown.maxWaitSeconds|Maximum time to wait for the Hazelcast POD to shut down|600|
|livenessProbe.enabled|Turn on and off liveness probe|true|
|livenessProbe.initialDelaySeconds|Delay before liveness probe is initiated|30|
|livenessProbe.periodSeconds|How often to perform the probe|10|
|livenessProbe.timeoutSeconds|When the probe times out|5|
|livenessProbe.successThreshold|Minimum consecutive successes for the probe to be considered successful after having failed|1|
|livenessProbe.failureThreshold|Minimum consecutive failures for the probe to be considered failed after having succeeded.|3|
|livenessProbe.path|URL path that will be called to check liveness.|/hazelcast/health/node-state|
|livenessProbe.port|Port that will be used in liveness probe calls.|nil|
|livenessProbe.scheme|HTTPS or HTTP scheme.|HTTP|
|readinessProbe.enabled|Turn on and off readiness probe|true|
|readinessProbe.initialDelaySeconds|Delay before readiness probe is initiated|30|
|readinessProbe.periodSeconds|How often to perform the probe|10|
|readinessProbe.timeoutSeconds|When the probe times out|1|
|readinessProbe.successThreshold|Minimum consecutive successes for the probe to be considered successful after having failed|1|
|readinessProbe.failureThreshold|Minimum consecutive failures for the probe to be considered failed after having succeeded.|3|
|readinessProbe.path|URL path that will be called to check readiness.|/hazelcast/health/node-state|
|readinessProbe.port|Port that will be used in readiness probe calls.|nil|
|readinessProbe.scheme|HTTPS or HTTP scheme.|HTTP|
|resources.limits.cpu|CPU resource limit|default|
|resources.limits.memory|Memory resource limit|default|
|resources.requests.cpu|CPU resource requests|default|
|resources.requests.memory|Memory resource requests|default|
|podDisruptionBudget.maxUnavailable|Number of max unavailable pods| |
|podDisruptionBudget.minAvailable|Number of min available pods| |
|service.create|Enable installing Service|true|
|service.name|Name of Service, if not set, the name is generated using the fullname template|nil|
|service.type|Kubernetes service type (`ClusterIP`, `LoadBalancer`, or `NodePort`|ClusterIP|
|service.port|Kubernetes service port|5701|
|service.clusterIP|IP of the service, `None` makes the service headless|None|
|service.annotations|Extra annotations for the Hazelcast service| {} |
|service.labels|Extra labels for the Hazelcast service| {} |
|rbac.create|Enable installing RBAC Role authorization|true|
|rbac.useClusterRole|If `rbac.create` is true, this will create a cluster role. Set this to false to use role and role binding. But note that some discovery features will be unavailable.|true|
|serviceAccount.create|Enable installing Service Account|true|
|serviceAccount.automountToken|Whether the token associated with the service account should be automatically mounted|true|
|serviceAccount.name|Name of Service Account, if not set, the name is generated using the fullname template|nil|
|securityContext.enabled|Enables Security Context for Hazelcast and Management Center|true|
|securityContext.runAsUser|User ID used to run the Hazelcast and Management Center containers|65534|
|securityContext.runAsGroup|Primary Group ID used to run all processes in the Hazelcast Jet and Hazelcast Jet Management Center containers|65534|
|securityContext.fsGroup|Group ID associated with the Hazelcast and Management Center container|65534|
|securityContext.readOnlyRootFilesystem|Enables readOnlyRootFilesystem in the Hazelcast security context|true|
|hotRestart.enabled|Turn on and off Hazelcast Hot Restart feature (Hazelcast configuration must be also updated with the map/cache configuration)|false|
|hotRestart.existingClaim|Name of the existing Persistence Volume Claim, if not defined, a new is created|nil|
|hotRestart.accessModes|Access Modes of the new Persistent Volume Claim|ReadWriteOnce|
|hotRestart.size|Size of the new Persistent Volume Claim|8Gi|
|hotRestart.hostPath|Path of node machine used for persistent storage; if defined, it’s used instead of Persistent Volume Claim|nil|
|jet.enabled|Turn on and off Hazelcast Jet engine |true|
|metrics.enabled|Turn on and off JMX Prometheus metrics available at `/metrics`|false|
|metrics.service.type|Type of the metrics service|ClusterIP|
|metrics.service.port|Port of the `/metrics` endpoint and the metrics service|8080|
|metrics.service.loadBalancerIP| IP to be used to access metric service for `LoadBalancer` service type| nil|
|metrics.service.annotations|Annotations for the Prometheus discovery||
|metrics.service.serviceMonitor.enabled|Enable to create ServiceMonitor resource|false|
|metrics.service.serviceMonitor.namespace|The namespace in which the ServiceMonitor will be created||
|metrics.service.serviceMonitor.labels|Additional labels for the ServiceMonitor|{}|
|metrics.service.serviceMonitor.interval|The interval at which metrics should be scraped|30s|
|metrics.service.serviceMonitor.scrapeTimeout|The timeout after which the scrape is ended||
|metrics.service.serviceMonitor.relabellings|Metrics RelabelConfigs to apply to samples before scraping|[]|
|metrics.service.serviceMonitor.metricRelabelings|Metrics RelabelConfigs to apply to samples before ingestion|[]|
|metrics.service.serviceMonitor.honorLabels|Specify honorLabels parameter to add the scrape endpoint|false|
|metrics.prometheusRule.enabled|Enable to create PrometheusRule resource|false|
|metrics.prometheusRule.namespace|The namespace in which the PrometheusRule will be created||
|metrics.prometheusRule.labels|Additional labels for the PrometheusRule|{}|
|metrics.prometheusRule.rules|Array of rules to define in PrometheusRule|[]|
|secretsMountName|Secret name that is mounted as `/data/secrets/` (e.g. with keystore/trustore files)|nil|
|customVolume|Configuration for a volume mounted as `/data/custom` and exposed to classpath (e.g. to mount a volume with custom JARs)|nil|
|externalVolume|Configuration for a volume mounted as `/data/external` |nil|
|initContainers|List of init containers to add to the Hazelcast Statefulset's pod spec.|[]|
|sidecarContainers|List of sidecar containers to add to the Hazelcast Statefulset's pod spec.|[]|
|env|Additional Environment variables|[]|
|mancenter.enabled|Turn on and off Management Center application|true|
|mancenter.image.repository|Hazelcast Management Center Image name|hazelcast/management-center|
|mancenter.image.tag|Hazelcast Management Center Image tag (NOTE: must be the same or one minor release greater than Hazelcast image version)|{VERSION}|
|mancenter.image.pullPolicy|Image pull policy|IfNotPresent|
|mancenter.image.pullSecrets|Specify docker-registry secret names as an array|nil|
|mancenter.image.contextPath|the value for the MC_CONTEXT_PATH environment variable, thus overriding the default context path for Hazelcast Management Center|nil|
|mancenter.ssl|Enable SSL for Management Center|false|
|mancenter.devMode.enabled|Dev mode is for the Hazelcast clusters running on your local for development or evaluation purposes and it provides quick access to the Management Center without requiring any security credentials|false|
|mancenter.javaOpts|Additional JAVA_OPTS properties for Hazelcast Management Center|nil|
|mancenter.loggingLevel|Level of Management Center logs (OFF, FATAL, ERROR, WARN, INFO, DEBUG, TRACE and ALL)|nil|
|mancenter.licenseKey|License Key for Hazelcast Management Center, if not provided, can be filled in the web interface|nil|
|mancenter.licenseKeySecretName|Kubernetes Secret Name, where Management Center License Key is stored (can be used instead of licenseKey)|nil|
|mancenter.adminCredentialsSecretName|Kubernetes Secret Name for admin credentials. Secret has to contain `username` and `password` literals. please check Management Center documentation for password requirements|nil|
|mancenter.annotations|Management Center Statefulset annotations|nil|
|mancenter.affinity|Management Center Node affinity|nil|
|mancenter.tolerations|Management Center Node tolerations|nil|
|mancenter.nodeSelector|Hazelcast Management Center node labels for pod assignment|nil|
|mancenter.topologySpreadConstraints| Control how Pods are spread across the cluster | {} |
|mancenter.labels|Extra labels to add to the mancenter statefulset|{}|
|mancenter.podLabels|Extra labels to add to the mancenter pod container metadata|{}|
|mancenter.priorityClassName|Custom priority class name|<undefined>|
|mancenter.resources|CPU/Memory resource requests/limits|nil|
|mancenter.persistence.enabled|Enable Persistent Volume for Hazelcast Management|true|
|mancenter.persistence.existingClaim|Name of the existing Persistence Volume Claim, if not defined, a new is created|nil|
|mancenter.persistence.accessModes|Access Modes of the new Persistent Volume Claim|ReadWriteOnce|
|mancenter.persistence.size|Size of the new Persistent Volume Claim|8Gi|
|mancenter.persistence.storageClass| Storage class name used for Management Center|nil|
|mancenter.service.type|Kubernetes service type (`ClusterIP`, `LoadBalancer`, or `NodePort`)|LoadBalancer|
|mancenter.service.port|Kubernetes service port|5701|
|mancenter.service.loadBalancerIP| IP to be used to access management center for `LoadBalancer` service type| nil|
|mancenter.service.annotations|Extra annotations for the mancenter service| {} |
|mancenter.service.labels|Extra labels for the mancenter service| {} |
|mancenter.livenessProbe.enabled|Turn on and off liveness probe|true|
|mancenter.livenessProbe.initialDelaySeconds|Delay before liveness probe is initiated|30|
|mancenter.livenessProbe.periodSeconds|How often to perform the probe|10|
|mancenter.livenessProbe.timeoutSeconds|When the probe times out|5|
|mancenter.livenessProbe.successThreshold|Minimum consecutive successes for the probe to be considered successful after having failed|1|
|mancenter.livenessProbe.failureThreshold|Minimum consecutive failures for the probe to be considered failed after having succeeded.|3|
|mancenter.readinessProbe.enabled|Turn on and off readiness probe|true|
|mancenter.readinessProbe.initialDelaySeconds|Delay before readiness probe is initiated|30|
|mancenter.readinessProbe.periodSeconds|How often to perform the probe|10|
|mancenter.readinessProbe.timeoutSeconds|When the probe times out|1|
|mancenter.readinessProbe.successThreshold|Minimum consecutive successes for the probe to be considered successful after having failed|1|
|mancenter.readinessProbe.failureThreshold|Minimum consecutive failures for the probe to be considered failed after having succeeded.|3|
|mancenter.ingress.enabled|Enable ingress for the management center|false|
|mancenter.ingress.annotations|Any annotations for the ingress|{}|
|mancenter.ingress.hosts|List of hostnames for ingress, see values.yaml for example|[]|
|mancenter.ingress.tls|List of TLS configuration for ingress, see values.yaml for example|[]|
|mancenter.clusterConfig.create|Cluster config creation will create the connection to the Hazelcast cluster based on the hazelcast-client.yaml file embedded into values|true|
|externalAccess.enabled| Enable external access to hazelcast nodes| false|
|externalAccess.service.type| Kubernetes Service type for external access. It can be NodePort or LoadBalancer| LoadBalancer|
|externalAccess.service.loadBalancerIPs| Array of load balancer IPs for hazelcast nodes| []|
|externalAccess.service.loadBalancerSourceRanges| Address(es) that are allowed when service is LoadBalancer| []|
|externalAccess.service.nodePorts| Array of node ports used to configure hazelcast external listener when service type is NodePort  | []|


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

    $ helm install my-release \
      --set hazelcast.licenseKey=<license_key>,cluster.memberCount=3 \
        hazelcast/hazelcast-enterprise

The above command sets number of Hazelcast members to 3.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

    $ helm install my-release -f values.yaml hazelcast/hazelcast-enterprise

> **Tip**: You can use the default values.yaml with the `hazelcast.license`
> filled in

## Using DNS Lookup Discovery

By default, Hazelcast Helm Chart uses [Kubernetes API discovery](https://github.com/hazelcast/hazelcast-kubernetes#understanding-discovery-modes). If you prefer the [DNS Lookup discovery](https://github.com/hazelcast/hazelcast-kubernetes#dns-lookup), use the following configuration.

```yaml
hazelcast:
  yaml:
    hazelcast:
      network:
        join:
          kubernetes:
            service-dns: "${serviceName}.${namespace}.svc.cluster.local"
        rest-api:
          enabled: true
rbac:
  create: false
```

## Custom Hazelcast configuration

Custom Hazelcast configuration can be specified inside `values.yaml`, as
the `hazelcast.yaml` property.

    hazelcast:
      yaml:
        hazelcast:
          network:
            join:
              kubernetes:
                enabled: true
                service-name: ${serviceName}
                namespace: ${namespace}
            rest-api:
              enabled: true
          jet:
            enabled: ${hz.jet.enabled}

Note that some of the Hazelcast Enterprise features requires setting `securityContext.readOnlyRootFilesystem` parameter to `false`. This is the case for the Hot Restart feature or enabling security with OpenSSL. In such cases where `readOnlyRootFilesystem` needs to be set to `true` (i.e. a Pod Security Policy requirement), for Hot Restart to work the the JVM parameter `-Djava.io.tmpdir` should be set to a writable location (for example a [custom volume](#adding-custom-jar-files-to-the-imdgmanagement-center-classpath)).

## Configuring SSL

To enable SSL-protected communication between members and clients, you need first to generate `keystore`/`truststore` and import them as secrets into your Kubernetes environment.

    $ kubectl create secret generic keystore --from-file=./keystore --from-file=./truststore

Then, since Kubernetes liveness/readiness probes cannot use SSL, we need to prepare Hazelcast configuration with a separate non-secured port opened for health checks. Create a file `hazelcast.yaml`.

```
hazelcast:
  advanced-network:
    enabled: true
    join:
      kubernetes:
        enabled: true
        service-name: ${serviceName}
        service-port: 5702
        namespace: ${namespace}
    member-server-socket-endpoint-config:
      port:
        port: 5702
      ssl:
        enabled: true
    client-server-socket-endpoint-config:
      port:
        port: 5701
      ssl:
        enabled: true
    rest-server-socket-endpoint-config:
      port:
        port: 5703
      endpoint-groups:
        HEALTH_CHECK:
          enabled: true
```

Then, add this configuration as a ConfigMap.

    $ kubectl create configmap hazelcast-configuration --from-file=hazelcast.yaml

Finally, run your cluster with SSL enabled and keystore secrets mounted into your PODs.

    $ helm install my-release \
      --set hazelcast.licenseKey=<license_key> \
      --set secretsMountName=keystore \
      --set hazelcast.existingConfigMap=hazelcast-configuration \
      --set hazelcast.javaOpts='-Djavax.net.ssl.keyStore=/data/secrets/keystore -Djavax.net.ssl.keyStorePassword=<keystore_password> -Djavax.net.ssl.trustStore=/data/secrets/truststore -Djavax.net.ssl.trustStorePassword=<truststore_password>' \
      --set livenessProbe.port=5703 \
      --set readinessProbe.port=5703 \
      --set mancenter.secretsMountName=keystore \
      --set mancenter.yaml.hazelcast-client.network.ssl.enabled=true \
      --set mancenter.javaOpts='-Djavax.net.ssl.keyStore=/secrets/keystore -Djavax.net.ssl.keyStorePassword=<keystore_password> -Djavax.net.ssl.trustStore=/secrets/truststore -Djavax.net.ssl.trustStorePassword=<truststore_password>' \
        hazelcast/hazelcast-enterprise

For more information please check [Hazelcast Kubernetes SSL Guide](https://guides.hazelcast.org/kubernetes-ssl/).


## Adding custom JAR files to the IMDG/Management Center classpath

You can mount any volume which contains your JAR files to the pods created by helm chart using `customVolume` configuration.

When the `customVolume` set, it will mount provided volume to the pod on `/data/custom` path. This path is also appended to the classpath of running Java process.

For example, if you have existing [Local Persistent Volumes](https://kubernetes.io/blog/2019/04/04/kubernetes-1.14-local-persistent-volumes-ga/) and Persistent Volume Claims like below;

```yaml
  kind: StorageClass
  apiVersion: storage.k8s.io/v1
  metadata:
    name: local-storage
  provisioner: kubernetes.io/no-provisioner
  volumeBindingMode: WaitForFirstConsumer

  ---
  apiVersion: v1
  kind: PersistentVolume
  metadata:
    name: <hz-custom-local-pv / mc-custom-local-pv>
  spec:
    storageClassName: local-storage
    capacity:
      storage: 1Gi
    accessModes:
      - ReadWriteOnce
    local:
      path: </path/to/your/jars>
    nodeAffinity:
      required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - <YOUR_NODE_1>
          - <YOUR_NODE_2>
  ---

  apiVersion: v1
  kind: PersistentVolumeClaim
  metadata:
    name: < hz-custom-local-pv-claim / mc-custom-local-pv-claim>
  spec:
    storageClassName: local-storage
    accessModes:
      - ReadWriteOnce
    resources:
      requests:
        storage: 1Gi
```

You can configure your Helm chart to use it like below in your `values.yaml` file.

For IMDG:
```yaml
customVolume:
  persistentVolumeClaim:
    claimName: hz-custom-local-pv-claim
```

For Management Center:
```yaml
mancenter:
  ...
  customVolume:
    persistentVolumeClaim:
      claimName: mc-custom-local-pv-claim
```

## Enabling External Access to Cluster

Hazelcast Cluster Helm chart topology enables external access to any of the pods via any Hazelcast client. 
The external access is not enabled by default. It can be enabled during deployment or by upgrading after deployment. Scaling down or scaling up via upgrading automatically removes or adds external services for the members.

It can be enabled by changing configuration inside `values.yaml` in externalAccess section.

Also it can be enabled by specifying externalAccess.enabled parameter using the `--set` argument to `helm install`. For example,
    $ helm install my-release \
    --set hazelcast.licenseKey=<license_key>,externalAccess.enabled=true \
    hazelcast/hazelcast-enterprise

will create (by default) 3 LoadBalancer services one for each Hazelcast member since default value of member count for Hazelcast cluster is 3.

## Notable changes

### 2.8.0

Hazelcast REST Endpoints are no longer enabled by default and the parameter `hazelcast.rest` is no longer available. If you want to enable REST, please add the related `endpoint-groups` to the Hazelcast Configuration. For example:

    rest-api:
      enabled: true
      endpoint-groups:
        HEALTH_CHECK:
          enabled: true
        CLUSTER_READ:
          enabled: true
        CLUSTER_WRITE:
          enabled: true
