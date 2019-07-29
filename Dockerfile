FROM node:10

WORKDIR /usr/src/app

RUN yarn global add gulp-cli

COPY ./ ./

RUN yarn install

EXPOSE 9990
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
