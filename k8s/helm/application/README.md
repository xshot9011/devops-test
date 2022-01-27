# The chart info

- Contains
    - services
    - deployments
    - ingress with sepecific annoatation

## Deploy graphite

### Setting up Kubernetes ingress host

- file `graphite-dev-values.yaml`

```yaml
ingress:
  annotations:
    kubernetes.io/ingress.class: nginx
  host: <host_name_of_aws_loadbalancer>
  path: /
  serviceType: ClusterIP
```

### Deploy

```
helm upgrade --install graphite . -f graphite-dev-values.yaml
```

## Deploy api

### Setting up Kubernetes DNS to send metric to graphite

- file `api-dev-values.yaml`

```yaml
extraEnv:
  ENVIRONMENT: <environment>
  STATSD_PORT: <running_udp_port>
  STATSD_URL: <graphite_release_name.graphite_namespace.svc.cluster.local>
```

### Deploy

```bash
helm upgrade --install api . -f api-dev-values.yaml
```

## Verify connection

Go to `stats.timers.test.core.delay.count` in dashboard on the right of screen
