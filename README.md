# docker-rathena

bash ```
docker build -t naffej/rathena .
docker run -ti -p 3306:3306 -p 6900:6900 -p 5121:5121 -p 6121:6121 naffej/rathena bash
```

bash ```
/install.sh
cd /rathena
./athena-start start
```
