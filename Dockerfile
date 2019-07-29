FROM node:10

WORKDIR /usr/src/app

COPY ./ ./

RUN npm install

EXPOSE 9990
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
