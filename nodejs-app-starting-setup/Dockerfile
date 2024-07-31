# This is a Dockerfile to create a Docker image for a Node.js application
FROM node

# Create app directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install the dependencies
RUN npm install

# Which port to be exposed outside the container
EXPOSE 80

# Should be the last command
CMD ["node", "server.js"]