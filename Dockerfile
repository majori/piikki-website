FROM node:carbon-alpine

WORKDIR /usr/src/app
COPY package*.json ./

RUN apk --no-cache add --virtual native-deps util-linux

RUN npm install

COPY . .
RUN npm run build

RUN npm prune --production
RUN npm cache clean --force
RUN apk del native-deps

EXPOSE 8080
CMD [ "npm", "start" ]
