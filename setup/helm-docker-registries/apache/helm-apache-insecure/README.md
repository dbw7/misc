# These two scripts set up an Helm repository containing rancher and apache with "user:pass" authentication

# Deps:
```
apache2
apache2-utils
helm
```

First script
This sets up the dirs 
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/setup/helm-docker-registries/apache/helm-apache-insecure/apache-insecure.sh)"
```

Second script
This adds rancher and apache and indexes the repo
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/setup/helm-docker-registries/apache/helm-apache-insecure/populate-apache-helm-insecure.sh)"
```

## Purge
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/setup/helm-docker-registries/apache/helm-apache-insecure/purge-helm-apache-insecure-ubuntu.sh)"
```

when all of this works, you should be able to do:
```
curl -u http://YOUR-IP:8092/index.yaml
```
And see an output that starts with something similar:
```yaml
apiVersion: v1
entries:
  apache:
  - annotations:
      category: Infrastructure
      images: |
        - name: apache
          image: docker.io/bitnami/apache:2.4.58-debian-12-r17
        - name: apache-exporter
          image: docker.io/bitnami/apache-exporter:1.0.6-debian-12-r7
        - name: git
          image: docker.io/bitnami/git:2.43.2-debian-12-r1
      licenses: Apache-2.0...
```

## Follow up commands
```
helm repo add local-repo http://YOUR-IP:8092
helm pull local-repo/rancher
helm pull local-repo/apache
```
