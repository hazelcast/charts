# Hazelcast Jet Enterprise

The Hazelcast Jet Enterprise provides critical management features for scaling in-memory event stream processing across your IT landscape, including Management Center, Security Suite, Lossless Recovery, Rolling Job upgrades, and Enterprise PaaS Deployment Environments.

Hazelcast Jet Enterprise is designed to run in any cloud with Discovery Service Provider Interfaces for AWS, Azure, Apache jclouds, Consul, etcd, Eureka, Heroku, Kubernetes, and Zookeeper. It provides native integrations for IaaS environments AWS and Azure Marketplaces as well as PaaS environments Pivotal® Cloud Foundry and Red Hat OpenShift Container Platform. Hazelcast Jet Enterprise also includes deployment integrations for Docker and Kubernetes.

Visit [Hazelcast Jet Enterprise](https://hazelcast.com/products/jet/enterprise/) to learn more
about the architecture, road-map and use cases.

## Quick Start

```bash
$ helm repo add hazelcast https://hazelcast.github.io/charts/
$ helm repo update
$ helm install hazelcast/hazelcast-jet-enterprise
```

## Introduction

This chart bootstraps a [Hazelcast Jet Enterprise](https://github.com/hazelcast/hazelcast-jet-docker) and [Hazelcast Jet Management Center](https://github.com/hazelcast/hazelcast-jet-management-center-docker) deployments on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.9+

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release hazelcast/hazelcast-jet-enterprise
```

The command deploys Hazelcast Jet Enterprise on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the Hazelcast chart and their default values.

| Parameter                                  | Description                                                                                                    | Default                                              |
|--------------------------------------------|----------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| `image.repository`                         | Hazelcast Jet Image name                                                                                       | `hazelcast/hazelcast-jet-enterprise`                 |
| `image.tag`                                | Hazelcast Jet Image tag                                                                                        | `{VERSION}`                                          |
| `image.pullPolicy`                         | Image pull policy                                                                                              | `IfNotPresent`                                       |
| `image.pullSecrets`                        | Specify docker-registry secret names as an array                                                               | `nil`                                                |
| `cluster.memberCount`                      | Number of Hazelcast Jet members                                                                                | 2                                                    |
| `jet.licenseKey`                           | License Key for Hazelcast Jet Enterprise                                                                       | `nil`                                                |
| `jet.licenseKeySecretName`                 | Kubernetes Secret Name, where Hazelcast Jet Enterprise Key is stored (can be used instead of licenseKey)       | `nil`                                                |
| `jet.rest`                                 | Enable REST endpoints for Hazelcast Jet member                                                                 | `true`                                               |
| `jet.javaOpts`                             | Additional JAVA_OPTS properties for Hazelcast Jet member                                                       | `nil`                                                |
| `jet.yaml.hazelcast-jet` and `jet.yaml.hazelcast`                   | Hazelcast Jet and IMDG YAML configurations (`hazelcast-jet.yaml` and `hazelcast.yaml` embedded into `values.yaml`)                                                                                | `{DEFAULT_JET_YAML}` and `{DEFAULT_HAZELCAST_YAML}`                  |
| `jet.configurationFiles`                   | Hazelcast configuration files                                                                                  | `nil`                           |
| `nodeSelector`                             | Hazelcast Node labels for pod assignment                                                                       | `nil`                                                |
| `gracefulShutdown.enabled`                 | Turn on and off Graceful Shutdown                                                                              | `true`                                               |
| `gracefulShutdown.maxWaitSeconds`          | Maximum time to wait for the Hazelcast Jet POD to shut down                                                    | `600`                                                |
| `livenessProbe.enabled`                    | Turn on and off liveness probe                                                                                 | `true`                                               |
| `livenessProbe.initialDelaySeconds`        | Delay before liveness probe is initiated                                                                       | `30`                                                 |
| `livenessProbe.periodSeconds`              | How often to perform the probe                                                                                 | `10`                                                 |
| `livenessProbe.timeoutSeconds`             | When the probe times out                                                                                       | `5`                                                  |
| `livenessProbe.successThreshold`           | Minimum consecutive successes for the probe to be considered successful after having failed                    | `1`                                                  |
| `livenessProbe.failureThreshold`           | Minimum consecutive failures for the probe to be considered failed after having succeeded.                     | `3`                                                  |
| `readinessProbe.enabled`                   | Turn on and off readiness probe                                                                                | `true`                                               |
| `readinessProbe.initialDelaySeconds`       | Delay before readiness probe is initiated                                                                      | `30`                                                 |
| `readinessProbe.periodSeconds`             | How often to perform the probe                                                                                 | `10`                                                 |
| `readinessProbe.timeoutSeconds`            | When the probe times out                                                                                       | `1`                                                  |
| `readinessProbe.successThreshold`          | Minimum consecutive successes for the probe to be considered successful after having failed                    | `1`                                                  |
| `readinessProbe.failureThreshold`          | Minimum consecutive failures for the probe to be considered failed after having succeeded.                     | `3`                                                  |
| `resources`                                | CPU/Memory resource requests/limits                                                                            | `nil`                                                |
| `service.type`                             | Kubernetes service type ('ClusterIP', 'LoadBalancer', or 'NodePort')                                           | `ClusterIP`                                          |
| `service.port`                             | Kubernetes service port                                                                                        | `5701`                                               |
| `rbac.create`                              | Enable installing RBAC Role authorization                                                                      | `true`                                               |
| `serviceAccount.create`                    | Enable installing Service Account                                                                              | `true`                                               |
| `serviceAccount.name`                      | Name of Service Account, if not set, the name is generated using the fullname template                         | `nil`                                                |
| `securityContext.enabled`                  | Enables Security Context for Hazelcast Jet and Hazelcast Jet Management Center                                 | `true`                                               |
| `securityContext.runAsUser`                | User ID used to run the Hazelcast Jet and Hazelcast Jet Management Center containers                           | `1001`                                               |
| `securityContext.runAsGroup`               | Primary Group ID used to run all processes in the Hazelcast Jet and Hazelcast Jet Management Center containers | `1001`                                               |
| `securityContext.fsGroup`                  | Group ID associated with the Hazelcast Jet and Hazelcast Jet Management Center container                       | `1001`                                               |
| `metrics.enabled`                          | Turn on and off JMX Prometheus metrics available at `/metrics`                                                 | `false`                                              |
| `metrics.service.type`                     | Type of the metrics service                                                                                    | `ClusterIP`                                          |
| `metrics.service.port`                     | Port of the `/metrics` endpoint and the metrics service                                                        | `8080`                                               |
| `metrics.service.annotations`              | Annotations for the Prometheus discovery                                                                       |                                                      |
| `managementcenter.enabled`                        | Turn on and off Hazelcast Jet Management Center application                                             | `true`                                               |
| `managementcenter.image.repository`               | Hazelcast Jet Management Center Image name                                                              | `hazelcast/hazelcast-jet-management-center`                        |
| `managementcenter.image.tag`                      | Hazelcast Jet Management Center Image tag (NOTE: must be the same or one minor release greater than Hazelcast image version) | `{VERSION}`                                  |
| `managementcenter.image.pullPolicy`               | Image pull policy                                                                                              | `IfNotPresent`                                       |
| `managementcenter.image.pullSecrets`              | Specify docker-registry secret names as an array                                                               | `nil`                                                |
| `managementcenter.javaOpts`                       | Additional JAVA_OPTS properties for Hazelcast Jet Management Center                                            | `nil`                                                |
| `managementcenter.licenseKey`                     | License Key for Hazelcast Jet Management Center                                                                | `nil`                                                |
| `managementcenter.licenseKeySecretName`           | Kubernetes Secret Name, where Jet Management Center License Key is stored (can be used instead of licenseKey)  | `nil`                                                |
| `managementcenter.nodeSelector`                   | Hazelcast Jet Management Center node labels for pod assignment                                                 | `nil`                                                |
| `managementcenter.resources`                      | CPU/Memory resource requests/limits                                                                            | `nil`                                                |
| `managementcenter.service.type`                   | Kubernetes service type ('ClusterIP', 'LoadBalancer', or 'NodePort')                                           | `ClusterIP`                                          |
| `managementcenter.service.port`                   | Kubernetes service port                                                                                        | `8081`                                               |
| `managementcenter.livenessProbe.enabled`          | Turn on and off liveness probe                                                                                 | `true`                                               |
| `managementcenter.livenessProbe.initialDelaySeconds` | Delay before liveness probe is initiated                                                                    | `30`                                                 |
| `managementcenter.livenessProbe.periodSeconds`    | How often to perform the probe                                                                                 | `10`                                                 |
| `managementcenter.livenessProbe.timeoutSeconds`   | When the probe times out                                                                                       | `5`                                                  |
| `managementcenter.livenessProbe.successThreshold` | Minimum consecutive successes for the probe to be considered successful after having failed                    | `1`                                                  |
| `managementcenter.livenessProbe.failureThreshold` | Minimum consecutive failures for the probe to be considered failed after having succeeded.                     | `3`                                                  |
| `managementcenter.readinessProbe.enabled`         | Turn on and off readiness probe                                                                                | `true`                                               |
| `managementcenter.readinessProbe.initialDelaySeconds` | Delay before readiness probe is initiated                                                                  | `30`                                                 |
| `managementcenter.readinessProbe.periodSeconds`   | How often to perform the probe                                                                                 | `10`                                                 |
| `managementcenter.readinessProbe.timeoutSeconds`  | When the probe times out                                                                                       | `1`                                                  |
| `managementcenter.readinessProbe.successThreshold`| Minimum consecutive successes for the probe to be considered successful after having failed                    | `1`                                                  |
| `managementcenter.readinessProbe.failureThreshold`| Minimum consecutive failures for the probe to be considered failed after having succeeded.                     | `3`                                                  |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
  --set cluster.memberCount=3,serviceAccount.create=false \
    hazelcast/hazelcast-jet-enterprise
```

The above command sets number of Hazelcast Jet members to 3 and disables REST endpoints.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml hazelcast/hazelcast-jet-enterprise
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Custom Hazelcast IMDG and Jet configuration

Custom Hazelcast IMDG and Hazelcast Jet configuration can be specified inside `values.yaml`, as the `jet.yaml.hazelcast` and `jet.yaml.hazelcast-jet` properties.

```yaml
jet:
  yaml:
    hazelcast:
      network:
        join:
          multicast:
            enabled: false
          kubernetes:
            enabled: true
            service-name: ${serviceName}
            namespace: ${namespace}
            resolve-not-ready-addresses: true
      management-center:
        enabled: ${hazelcast.mancenter.enabled}
        url: ${hazelcast.mancenter.url}
    hazelcast-jet:
      instance:
        flow-control-period: 100
        backup-count: 1
        scale-up-delay-millis: 10000
        lossless-restart-enabled: false
      edge-defaults:
        queue-size: 1024
        packet-size-limit: 16384
        receive-window-multiplier: 3
      metrics:
        enabled: true
        jmx-enabled: true
        retention-seconds: 120
        collection-interval-seconds: 5
        metrics-for-data-structures: false


```

Alternatively, above parameters can be modified directly via `helm` commands. For example,

```bash
$ helm install --name my-jet-release \
  --set jet.yaml.hazelcast-jet.instance.backup-count=2,jet.yaml.hazelcast.network.kubernetes.service-name=jet-service \
    hazelcast/hazelcast-jet
```
