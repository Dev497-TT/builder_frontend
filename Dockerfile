# --- Build stage ---
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files first for caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# === Pass API base URL ===
ARG VITE_API_BASE_URL=/api
ENV VITE_API_BASE_URL=$VITE_API_BASE_URL

# Build the app with the correct API base URL
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
