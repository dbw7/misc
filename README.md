# A compilation of random things I either want to automate or quickly have access to

# Be careful of executing these in environments you care about, make sure you know what each script does completely.
 
## HTTP Helm repo with user authentication using Apache
## [Larger Readme](./setup/helm-apache-user-auth-insecure/README.md)
### First script (Ubuntu/SUSE)
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/setup/helm-apache-user-auth-insecure/apache-user-auth.sh)"
```
### Second script (Ubuntu/SUSE)
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/setup/helm-apache-user-auth-insecure/populate-apache-helm.sh)"
```
### Purge, this uninstalls apache2 (Ubuntu)
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/setup/helm-apache-user-auth-insecure/purge-helm-apache-user-auth-ubuntu.sh)"
```

## OCI Helm repo with user authentication using docker registry
### Init
```bash
mkdir auth
htpasswd -Bcb auth/htpasswd user root
```
```bash
docker run -d \
  -p 5000:5000 \
  --name registry \
  -v "$(pwd)"/auth:/auth \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -e "REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd" \
  registry:2.7
```
### Use
```bash
helm registry login IP:5000 --insecure

```
### Cleanup
```
docker stop registry
docker rm registry
```