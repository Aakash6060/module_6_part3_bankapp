#!/bin/bash
set -e

echo "=== STEP 1: Checking prerequisites ==="

# Check Docker
if ! command -v docker &> /dev/null
then
    echo "ERROR: Docker is not installed."
    exit 1
fi
echo "Docker found."

# Check Docker Compose
if ! command -v docker-compose &> /dev/null
then
    echo "ERROR: Docker Compose is not installed."
    exit 1
fi
echo "Docker Compose found."

# Required ports
PORTS=(3000 5000)

for PORT in "${PORTS[@]}"; do
  if lsof -i:"$PORT" &> /dev/null; then
      echo "ERROR: Port $PORT is already in use."
      exit 1
  else
      echo "Port $PORT is free."
  fi
done

echo "=== STEP 2: Validating deployment directory ==="

# Move into this project folder
cd /mnt/c/Users/aakas/OneDrive\ -\ Red\ River\ College\ Polytech/Desktop/rrc_polytech/Term_4/Developing_in_a_DevOps_Environment/Assignment_6/Module_6_Part1 || {
    echo "ERROR: Deployment folder not found."
    exit 1
}

# Validate docker-compose.yml exists
if [ ! -f "docker-compose.yml" ]; then
    echo "ERROR: docker-compose.yml is missing."
    exit 1
fi

echo "docker-compose.yml found."
echo "=== STEP 3: Building & deploying with Docker Compose ==="

docker-compose build
docker-compose up -d

echo "Containers deployed successfully."

echo "=== Listing Docker images ==="
docker images
