# This is a Dockerfile to create a Docker image for a Node.js application
FROM node

# Create app directory
WORKDIR /app

# Copy package.json file to the container at /app before running npm install, so we only install the dependencies when the package.json file changes
COPY package.json /app

# Install the dependencies
RUN npm install

# Copy the current directory contents into the container at /app
COPY . /app

# Which port to be exposed outside the container
EXPOSE 80

# Should be the last command
CMD ["node", "server.js"]