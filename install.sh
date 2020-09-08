#!/bin/bash

set -e

apt-get update && \
    apt-get install -y --no-install-recommends git build-essential zlib1g-dev libpcre3-dev default-libmysqlclient-dev default-mysql-server

git -c http.sslVerify=false clone https://github.com/rathena/rathena.git /rathena

cd /rathena && ./configure --enable-packetver=20200401 --enable-prere=yes

echo "[client]\nuser=root\npassword=root" > mysql_config

service mysql start

mysql --defaults-extra-file=mysql_config -e "CREATE DATABASE ragnarok;"
mysql --defaults-extra-file=mysql_config -e "CREATE USER ragnarok@localhost IDENTIFIED BY 'ragnarok';"
mysql --defaults-extra-file=mysql_config -e "GRANT ALL PRIVILEGES on ragnarok.* TO ragnarok@localhost;"

mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/main.sql && \
mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/logs.sql && \
mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/item_db.sql && \
mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/item_db2.sql && \
mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/item_db_re.sql && \
mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/item_db2_re.sql && \
mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/item_cash_db.sql && \
mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/item_cash_db2.sql && \
mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/mob_db.sql && \
mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/mob_db2.sql && \
mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/mob_db_re.sql && \
mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/mob_db2_re.sql && \
mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/mob_skill_db.sql && \
mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/mob_skill_db2.sql && \
mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/mob_skill_db_re.sql && \
mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/mob_skill_db2_re.sql && \
mysql --defaults-extra-file=mysql_config ragnarok < /rathena/sql-files/roulette_default_data.sql && \
mysql --defaults-extra-file=mysql_config ragnarok -e "INSERT INTO \`ragnarok\`.\`login\` (\`account_id\`, \`userid\`, \`user_pass\`, \`sex\`, \`email\`, \`group_id\`, \`state\`, \`unban_time\`, \`expiration_time\`, \`logincount\`, \`lastlogin\`, \`last_ip\`, \`birthdate\`, \`character_slots\`, \`pincode\`, \`pincode_change\`, \`vip_time\`, \`old_group\`, \`web_auth_token\`, \`web_auth_token_enabled\`) VALUES ('2000000', 'ratyi', 'ratyi', 'M', 'a@a.com', '99', '0', '0', '0', '68', '2020-09-06 17:50:58', '31.46.86.229', NULL, '15', '', '0', '0', '0', NULL, '0');"

make server
