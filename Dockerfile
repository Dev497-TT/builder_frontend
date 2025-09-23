# Use Node official image
FROM node:20-alpine AS builder

# Install dos2unix to fix CRLF -> LF
RUN apk add --no-cache dos2unix

# Set workdir
WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./

# Install deps
RUN npm install

# Copy the rest of the code
COPY . .

# Convert Windows CRLF line endings to LF in all files
RUN find . -type f -exec dos2unix {} +

# Build the app
RUN npm run build

# --- Production stage ---
FROM node:20-alpine AS production

WORKDIR /app

COPY --from=builder /app/dist ./dist
COPY package*.json ./

# Install only production deps
RUN npm install --omit=dev

CMD ["npm", "run", "preview"]
