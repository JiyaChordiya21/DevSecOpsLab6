# Use official Node.js LTS version as parent image
FROM node:18

# Set working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first (for caching)
COPY myapp/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY myapp/ .

# Expose the port your app runs on
EXPOSE 8888

# Set environment variable
ENV NODE_ENV=production

# Start the application
CMD ["node", "app.js"]
