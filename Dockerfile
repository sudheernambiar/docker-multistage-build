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
