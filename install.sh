#!/bin/bash

cd /etc/rathena && ./configure --enable-packetver=20200401 --enable-prere=yes

echo "Mysql basic setup"
mysql_install_db
supervisorctl restart mysql

echo "Mysql import"
mysqladmin --no-defaults --port=3306 --user=root password 'root'
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root';"
mysql -u root -proot -e "CREATE USER ragnarok@localhost IDENTIFIED BY 'ragnarok';"
mysql -u root -proot -e "GRANT ALL PRIVILEGES on ragnarok.* TO ragnarok@localhost;"
mysql -u root -proot -e "FLUSH PRIVILEGES;"
mysql -u root -proot -e "CREATE DATABASE ragnarok;"
mysql -u root -proot ragnarok < /etc/rathena/sql-files/main.sql && \
mysql -u root -proot ragnarok < /etc/rathena/sql-files/logs.sql && \
mysql -u root -proot ragnarok < /etc/rathena/sql-files/item_db.sql && \
mysql -u root -proot ragnarok < /etc/rathena/sql-files/item_db2.sql && \
mysql -u root -proot ragnarok < /etc/rathena/sql-files/item_db_re.sql && \
mysql -u root -proot ragnarok < /etc/rathena/sql-files/item_db2_re.sql && \
mysql -u root -proot ragnarok < /etc/rathena/sql-files/item_cash_db.sql && \
mysql -u root -proot ragnarok < /etc/rathena/sql-files/item_cash_db2.sql && \
mysql -u root -proot ragnarok < /etc/rathena/sql-files/mob_db.sql && \
mysql -u root -proot ragnarok < /etc/rathena/sql-files/mob_db2.sql && \
mysql -u root -proot ragnarok < /etc/rathena/sql-files/mob_db_re.sql && \
mysql -u root -proot ragnarok < /etc/rathena/sql-files/mob_db2_re.sql && \
mysql -u root -proot ragnarok < /etc/rathena/sql-files/mob_skill_db.sql && \
mysql -u root -proot ragnarok < /etc/rathena/sql-files/mob_skill_db2.sql && \
mysql -u root -proot ragnarok < /etc/rathena/sql-files/mob_skill_db_re.sql && \
mysql -u root -proot ragnarok < /etc/rathena/sql-files/mob_skill_db2_re.sql && \
mysql -u root -proot ragnarok < /etc/rathena/sql-files/roulette_default_data.sql && \
mysql -u root -proot ragnarok -e "INSERT INTO \`ragnarok\`.\`login\` (\`account_id\`, \`userid\`, \`user_pass\`, \`sex\`, \`email\`, \`group_id\`, \`state\`, \`unban_time\`, \`expiration_time\`, \`logincount\`, \`lastlogin\`, \`last_ip\`, \`birthdate\`, \`character_slots\`, \`pincode\`, \`pincode_change\`, \`vip_time\`, \`old_group\`, \`web_auth_token\`, \`web_auth_token_enabled\`) VALUES ('2000000', 'ratyi', 'ratyi', 'M', 'a@a.com', '99', '0', '0', '0', '68', '2020-09-06 17:50:58', '31.46.86.229', NULL, '15', '', '0', '0', '0', NULL, '0');"

echo "Mysql import done"

make server
