mysqladmin -u root -psunway123#  --default-character-set=utf8  create dbs_dev

# Do not remove this line, or else you db will be initialized when you restart the container.
echo "DB initialized only once!" > /etc/mysql/conf.d/initdb.sh
