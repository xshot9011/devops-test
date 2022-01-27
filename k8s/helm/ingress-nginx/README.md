# Chart Information

[link](https://github.com/kubernetes/ingress-nginx/tree/main/charts/ingress-nginx)

VERSION 4.0.1

## Installation 

- add chart

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```

- install 

```bash
helm upgrade --install <release_name> ingress-nginx/ingress-nginx -f <values_file.yaml> -n <namespace> --version <VERSION>
```

### Example usage

```bash
helm upgrade --install nginx-ingress ingress-nginx/ingress-nginx -f values-dev.yaml -n kube-system --version 4.0.1
```