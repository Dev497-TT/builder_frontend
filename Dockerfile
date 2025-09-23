FROM node:18-alpine

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install all dependencies (including dev)
RUN npm install

# Copy rest of the source code
COPY . .

# Build the project
RUN npm run build

# Remove dev dependencies to slim image (optional)
RUN npm prune --production

# Expose port
EXPOSE 3000

ENV NODE_ENV=production

# Start your app (adjust if your app serves from build output)
CMD ["npm", "start"]
