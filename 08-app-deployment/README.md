# 08 App Deployment

This part of course is about deploying the application to AWS. I will only add some notes here.

- Dockerfile are meant to be used in a development envrionment
- We need to do some changes in Dockerfile to be production ready.
- We need our image in a image registry like Docker hub so that it is avaiable to be deployed in cloud
- In AWS we can use EC2 to deploy our application but it is like we have our own "machine" and we need to make a lot of configurations, fine tuning and bring all the resposabilities like security for example to mantaining that.
- There is a service named AWS ECS (Amazon Elastic Container Service) that we can use to deploy our application in a simpler way and avoid all small details