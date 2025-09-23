# Use official Node.js 18 runtime (alpine variant for smaller image)
FROM node:18-alpine

# Set working directory inside container
WORKDIR /app

# Copy package.json and package-lock.json first for caching
COPY package*.json ./

# Install dependencies (production only)
RUN npm install --production

# Copy the rest of the source code
COPY . .

# If you have a build step, uncomment this line:
# RUN npm run build

# Expose the port your app listens on (adjust if different)
EXPOSE 3000

# Set environment variable (optional)
ENV NODE_ENV=production

# Start the app
CMD ["npm", "start"]
