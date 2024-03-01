# These two scripts set up an Helm repository containing rancher and apache with "user:pass" authentication

# Deps:
```
apache2
apache2-utils
helm
```

## The default user and pass is `"user:root"`

First script
This sets up the dirs and apache with user auth
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/helm-apache-user-auth/apache-user-auth.sh)"
```

Second script
This adds rancher and apache and indexes the repo
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/helm-apache-user-auth/populate-apache-helm.sh)"
```

when all of this works, you should be able to do:
```
curl -u "user:root" http://192.168.1.185:8092/index.yaml
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

## Purge
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/helm-apache-user-auth/purge-helm-apache-user-auth-ubuntu.sh)"
```