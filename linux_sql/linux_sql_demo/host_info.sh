#!/bin/bash
 psql_host=$1
 psql_port=$2
 db_name=$3
 psql_user=$4
 psql_password=$5

 # Check the number of arguments
 if [ "$#" -ne 5 ]; then
     echo "Usage: $0 <psql_host> <psql_port> <db_name> <psql_user> <psql_password>"
     exit 1
 fi

 # Parse host hardware specifications using Bash commands
 hostname=$(hostname -f)
 cpu=$(lscpu | awk -F: '/^Model name/{print $2}' | xargs)
 memory=$(free -m | awk '/Mem/{print $2}' | xargs)
 disk=$(df -h / | awk 'NR==2{print $2}' | xargs)

 # Construct the INSERT statement
 insert_stmt="INSERT INTO host_info (hostname, cpu, memory, disk) VALUES ('$hostname', '$cpu', '$memory', '$disk');"

 # Set up the environment variable for the psql command
 export PGPASSWORD=$psql_password

 # Execute the INSERT statement through the psql CLI tool
 psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"
 exit $?
