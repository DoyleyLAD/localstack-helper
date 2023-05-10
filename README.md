# localstack-helper

## Descriptiom
Run Localstack using docker and helps script to create and delete AWS Resources.

## Prerequisites
Install Docker Desktop
Install AWS CLI

## Run Docker with LocalStack

Option 1 :

Run the following command in the directory that contains the docker-compose.yaml file. The command will run LocalStack in the background based of this projects docker-compose.yaml file. 

Run Command : 
```bash
docker-compose up -d
```

Option 2 ; 

Run the following command to run LocalStack via `docker run`

Run Command : 
```bash
docker run --rm -it -p 4566:4566 -p 4571:4571 localstack/localstack
```

## Test LocalStack

Command will return nothing, you should see no errors.

Run Command :
 ```bash
 AWS_ACCESS_KEY_ID=localstack AWS_SECRET_ACCESS_KEY=locslstack aws --endpoint-url=http://localhost:4566 s3 ls
 ```

## Use resource-manager.sh