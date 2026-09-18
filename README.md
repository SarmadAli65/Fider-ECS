# Fider-ECS
Deployment of a real app on AWS using Docker, Terraform and CI/CD

## Local Development
- First we need to create an image that would be used in the docker-compose file using the docker file
```docker build -t fider . ```
- Then run the following commands to build and run the other services

``` 
docker compose up -d 
```
