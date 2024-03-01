# A compilation of random things I either want to automate or quickly have access to

# Be careful of executing these in environments you care about, make sure you know what each script does completely.
 
## HTTP Helm repo with user authentication using Apache
## [Larger Readme](./setup/helm-apache-user-auth/helm-apache-user-auth.md)
### First script
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/helm-apache-user-auth/apache-user-auth.sh)"
```
### Second script
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbw7/misc/main/helm-apache-user-auth/populate-apache-helm.sh)"
```