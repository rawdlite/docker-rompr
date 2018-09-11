#!/bin/bash

PASS=${MYSQL_ROMPR_PASS:-'romprdbpass'}
_word=$( [ ${MYSQL_ROMPR_PASS} ] && echo "preset" || echo "default" )
echo "=> Creating MySQL admin user with ${_word} password"

mysql -uroot -e "CREATE USER 'rompr'@'%' IDENTIFIED  BY '$PASS'"
mysql -uroot -e "CREATE DATABASE romprdb"
mysql -uroot -e "GRANT ALL ON romprdb.* TO 'rompr'@'%'"

echo "=> Done!"
echo "========================================================================"
echo "You can now connect to this MySQL Server using:"
echo ""
echo "    mysql -urompr -p$PASS -h<host> -P<port>"
echo ""
echo "Please remember to set the above password in rompr setup"
echo "MySQL user 'root' has no password but only allows local connections"
echo "========================================================================"
