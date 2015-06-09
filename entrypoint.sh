#!/bin/bash

set -e

# set odoo database host, port, user and password
CONF=/openerp-server.conf
echo "addons_path = $ADDON" >> $CONF
echo "db_host = $DB_PORT_5432_TCP_ADDR " >> $CONF 
echo "db_port = $DB_PORT_5432_TCP_PORT " >> $CONF
echo "db_user = $DB_ENV_POSTGRES_USER " >> $CONF
echo "db_password = $DB_ENV_POSTGRES_PASSWORD" >> $CONF

#su openerp
exec "$@"



