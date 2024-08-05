# 08 App Deployment

This part of the course is about deploying the application to AWS. I will only add some notes here.

- Dockerfiles are meant to be used in a development environment.
- We need to make some changes to the Dockerfile to be production-ready.
- We need our image in an image registry like Docker Hub so that it is available to be deployed in the cloud.
- In AWS, we can use EC2 to deploy our application, but it is like having our own "machine" and we need to make a lot of configurations, fine-tuning, and take on all the responsibilities like security, for example, to maintain it.
- There is a service named AWS ECS (Amazon Elastic Container Service) that we can use to deploy our application in a simpler way and avoid all the small details.
- When we set a named volume in ECS we need to create a Amazon Elastic File System (EFS) and then point it to that named volume that is being configured in ECS.
    - Using a same EFS instance for a MongoDB it causes a problem where when a container is removed and a new one is being started there is a conflict that both containers are using the same "/data" folder. The correction was not covered in lessons because it is a specific problem related to MongoDB exclusivly.