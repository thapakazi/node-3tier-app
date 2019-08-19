FROM node:alpine

RUN adduser deploy -D
USER deploy

WORKDIR /home/deploy
COPY . /home/deploy

RUN npm install
ENTRYPOINT ["npm"]
CMD ["start"]
