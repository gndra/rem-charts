FROM node:14-alpine

RUN apk add --no-cache bash && apk add --no-cache curl

WORKDIR /app
COPY . .

RUN npm ci

CMD [ "node", "server.js" ]
