# docker-multistage-build

[![Build](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)


## Description

A multistage Dockerfile consists of two container base images(FROM), to build the original image. This one is mostly when there is some build work is there before we deploying an application. First from image uses to build the compilated output and second to use the output to generate another workable container.

This process is usually comes with the containers

## Pre-Requests
- Need to install docker and vim

### Docker installation 

```sh
yum install docker -y 
systemctl start docker
systemctl enable docker
```

### Create the docker build file
```
 ~]# vi Dockerfile
FROM alpine:3.15 as compiler
ENV  HOME /var/app
RUN  mkdir $HOME
WORKDIR $HOME
RUN  apk add --update nodejs-current npm
COPY ./app.js .
RUN  npm install -g pkg
RUN  pkg app.js -o japp

FROM alpine:3.15
ENV  HOME /var/app
RUN  mkdir $HOME
ENV PATH $PATH:$HOME
WORKDIR $HOME
COPY --from=compiler /var/app/japp .
CMD ["japp"]

#sample app file,
#vi app.js
const http = require('http');

const server = http.createServer((request, response) => {
        response.write('This is a NodeJs APP\n');
        response.end();
});

server.listen(80, () => {
        console.log('Server is running...');
});![image](https://user-images.githubusercontent.com/97512751/156261898-f4e0c2a6-6234-40a6-baa6-bf3035af18bc.png)

```
> building the docker image,
```
docker build -t nodeapp:latest .
```
> Once built, we can deploy it, 
```
 ~]# docker run -d -p 80:80 nodeapp
```
## Conclusion
A new container will pop up and will deploy sample nodejs app at 80 port of the host machine. 

#### ⚙️ Connect with Me

<p align="center">
<a href="mailto:sudheer.ck@outlook.com"><img src="https://img.shields.io/badge/Microsoft_Outlook-0078D4?style=for-the-badge&logo=microsoft-outlook&logoColor=white"/></a>
