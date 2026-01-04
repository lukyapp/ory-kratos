Pre-deploy Command :

```bash
kratos -c /etc/kratos/kratos.yml migrate sql -e --yes
```

Start Command :

```bash
kratos -c /etc/kratos/kratos.yml serve
```

Generate 32 hex characters:
```bash
openssl rand -hex 16
```

Test Kratos on browser :
https://DOMAIN/self-service/login/browser 

Cookie fix for prod: 
```yml
session:
  cookie:
#    DEV
#    secure: false
#    same_site: Lax
#    PROD
#    domain: example.com
#    same_site: Lax
#    OR
#    secure: true
#    same_site: None
```
