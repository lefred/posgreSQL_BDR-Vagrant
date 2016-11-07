#! /bin/bash
# /opt/pgsqlchk 
# This script checks if a postgres server is healthy running on localhost. It will
# return:
#
# "HTTP/1.x 200 OK\r" (if postgres is running smoothly)
#
# - OR -
#
# "HTTP/1.x 500 Internal Server Error\r" (else)
#
# The purpose of this script is make haproxy capable of monitoring postgres with BDR properly
#
#
#
 
PGSQL_HOST="localhost"
PGSQL_PORT="5432"
PGSQL_DATABASE="fred"
PGSQL_USERNAME="postgres"
#export PGPASSWORD="pg321"

WRITER=$1
  
TMP_FILE="/tmp/pgsqlchk.out"
ERR_FILE="/tmp/pgsqlchk.err"
 
function return_ok {
          # Postgres is fine, return http 200
          /bin/echo -e "HTTP/1.1 200 OK\r\n"
          /bin/echo -e "Content-Type: Content-Type: text/plain\r\n"
          /bin/echo -e "\r\n"
          /bin/echo -e "Postgres is running.\r\n"
          /bin/echo -e "\r\n"
          exit 0
}

function return_notok {
     # Postgres is down, return http 503
     /bin/echo -e "HTTP/1.1 503 Service Unavailable\r\n"
     /bin/echo -e "Content-Type: Content-Type: text/plain\r\n"
     /bin/echo -e "\r\n"
     /bin/echo -e "Postgres is not running or having issue.\r\n"
     /bin/echo -e "\r\n"
     exit 1
}


#
# We perform a simple query that should return a few results :-p
#
psql -h $PGSQL_HOST -p $PGSQL_PORT -U $PGSQL_USERNAME \
     $PGSQL_DATABASE -c "show port;" > $TMP_FILE 2> $ERR_FILE
  
#
# Check the output. If it is not empty then everything is fine and we return
# something. Else, we just do not return anything.
#
if [ "$(/bin/cat $TMP_FILE)" != "" ]
then
     psql -h $PGSQL_HOST -p $PGSQL_PORT -U $PGSQL_USERNAME \
     $PGSQL_DATABASE -c "SELECT node_name, node_status, node_read_only FROM bdr.bdr_nodes;" > $TMP_FILE 2> $ERR_FILE
     line=$(grep $(hostname -s) $TMP_FILE 2>/dev/null)
     if [ $? -eq 0 ]
     then
          status=$(echo $line | cut -d'|' -f2 | tr -d '[:space:]')
          read_only=$(echo $line | cut -d'|' -f3 | tr -d '[:space:]')
          if [ "$status" == "r" ]
          then
		  if [ "$WRITER" == "1" ] && [ "$read_only" == "f" ]
		  then
		     return_ok
		  elif [ "$WRITER" == "1" ]
		  then
		     return_notok
		  else
		     return_ok
                  fi
          fi
     fi
     return_notok
else
     return_notok
fi
