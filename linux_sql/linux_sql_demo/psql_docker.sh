#!/bin/sh

# Capture CLI arguments
cmd=$1
db_username=$2
db_password=$3

# Start docker
# Make sure you understand the double pipe operator
sudo systemctl status docker || systemctl start docker  # Add "start" to start the Docker service

# Execute the psql_docker.sh script with db_username and db_password as arguments
./scripts/psql_docker.sh create $db_username $db_password  # Use variables

# Check container status (try the following cmds on terminal)
docker container inspect jrvs-psql
container_status=$?

# User switch case to handle create|stop|start options
case $cmd in
  create)
    # Check if the container is already created
    if [ $container_status -eq 0 ]; then
        echo 'Container already exists'
        exit 1
    fi

    # Check # of CLI arguments
    if [ $# -ne 3 ]; then
        echo 'Create requires username and password'
        exit 1
    fi

    # Create container volume
    docker volume create pgdata

    # Start the container
    docker run --name jrvs-psql -e POSTGRES_PASSWORD=$db_password -d -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres:9.6-alpine

    # Check the exit status of the last command
    if [ $? -ne 0 ]; then
        echo 'Failed to start the container'
        exit 1
    else
        echo 'Container started successfully'
    fi
    ;;

  start|stop)
    # Check instance status; exit 1 if the container has not been created
    if [ $container_status -ne 0 ]; then
        echo 'Container not found. Use "create" command to create it.'
        exit 1
    fi

    # Start or stop the container based on the command
    if [ "$cmd" = "start" ]; then
        docker container start jrvs-psql
        echo 'Container started successfully'
    elif [ "$cmd" = "stop" ]; then
        docker container stop jrvs-psql
        echo 'Container stopped successfully'
    fi
    ;;

  *)
    echo 'Illegal command'
    echo 'Commands: start|stop|create'
    exit 1
    ;;
esac
