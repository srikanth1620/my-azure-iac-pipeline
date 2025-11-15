# Use official Node.js LTS image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy app source
COPY . .

# Expose port
EXPOSE 3000

# Start app
CMD ["node", "app.js"]

Interview Questions
can I override cmd if so how ?  Entrypoint?
what each cmd does?
When Java gets installed?
