FROM node:14

WORKDIR /app

COPY package.json /app

RUN npm install

COPY . /app

ARG DEFAULT_PORT=80

ENV PORT=$DEFAULT_PORT

EXPOSE ${PORT}

# We use npm start to start the application
CMD [ "npm", "start" ]