# docker-rathena

```bash
git -c http.sslVerify=false clone https://github.com/rathena/rathena.git rathena
docker-compose up -d --build
```

Első alkalommal:

```bash
docker exec -it ragnarok /bin/bash
sh /install.sh
```

Server inditás:
```
cd /etc/rathena
./athena-start start
```
### Remote SQL ###
localhost 3306 root/root