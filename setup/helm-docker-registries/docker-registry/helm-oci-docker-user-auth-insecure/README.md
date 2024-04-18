### First script (Ubuntu/SUSE)
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/setup/helm-docker-registries/docker-registry/helm-oci-docker-user-auth-insecure/helm-oci-docker-user-auth.sh)"
```
### Second script (Ubuntu/SUSE)
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/setup/helm-docker-registries/docker-registry/helm-oci-docker-user-auth-insecure/populate-helm-oci-docker-user-auth.sh)"
```
### Purge, this uninstalls apache2 (Ubuntu)
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/setup/helm-docker-registries/docker-registry/helm-oci-docker-user-auth-insecure/purge-helm-oci-docker-user-auth.sh)"
```

Good to know
```
helm registry login http://YOUR-IP:5000 --insecure
```

Usage
```
curl -u "user:root" http://YOUR-IP:5000/v2/_catalog"

helm pull oci://YOUR-IP:5000/charts/rancher --plain-http
helm pull oci://YOUR-IP:5000/charts/apache --plain-http
```

