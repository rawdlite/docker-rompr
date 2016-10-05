#!/bin/bash


mysql -uroot -e "CREATE USER 'rompr'@'localhost' IDENTIFIED BY 'romprdbpass'"
mysql -uroot -e "CREATE DATABASE romprdb"
mysql -uroot -e "GRANT ALL ON romprdb.* TO 'rompr'@'localhost'"


echo "=> Done!"
