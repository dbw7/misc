### First script (Ubuntu/SUSE)
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/setup/helm-docker-registries/helm-oci-docker-user-auth-self-signed/helm-oci-docker-user-auth-ss.sh)"
```
### Second script (Ubuntu/SUSE)
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/setup/helm-docker-registries/helm-oci-docker-user-auth-self-signed/populate-helm-oci-docker-user-auth-ss.sh)"
```
### Purge, this uninstalls apache2 (Ubuntu)
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/setup/helm-docker-registries/helm-oci-docker-user-auth-self-signed/purge-helm-oci-docker-user-auth-ss.sh)"
```

Usage
```
curl -k -u "user:root" https://YOUR-IP:5000/v2/_catalog"

helm pull oci://192.168.1.185:5000/rancher/rancher --insecure-skip-tls-verify
helm pull oci://192.168.1.185:5000/apache/apache --insecure-skip-tls-verify
```
Good to know
```
helm registry login https://YOUR-IP:5000 --insecure
```