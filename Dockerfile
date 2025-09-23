# --- Build stage ---
FROM node:20-alpine AS builder

# Install dos2unix to fix CRLF -> LF
RUN apk add --no-cache dos2unix

WORKDIR /app

# Copy package files first for caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Normalize line endings
RUN find . -type f -exec dos2unix {} +

# Build the app
RUN npm run build


# --- Production stage ---
FROM node:20-alpine AS production

WORKDIR /app

# Copy only the built assets
COPY --from=builder /app/dist ./dist

# Install a lightweight static server
RUN npm install -g serve

# Expose app port
EXPOSE 3000

# Start the app
CMD ["serve", "-s", "dist", "-l", "3000"]
