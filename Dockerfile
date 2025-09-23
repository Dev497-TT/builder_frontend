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

# Expose port 3000 (matching vite preview port)
EXPOSE 3000

# Start your app with vite preview on port 3000
CMD ["npm", "run", "start"]


