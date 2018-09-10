FROM mysql/mysql-server:latest
MAINTAINER rawdlite@gmail.com
ADD my.cnf /etc/my.cnf 
ADD init_rompr_db.sh /docker-entrypoint-initdb.d/init_rompr_db.sh
RUN chmod 755 /docker-entrypoint-initdb.d/init_rompr_db.sh
