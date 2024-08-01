# Build Stage
FROM ubuntu:latest AS build

# Install dependencies and tools required for the build
RUN apt update && apt install -y \
    wget \
    unzip

# Set working directory
WORKDIR /app

# Download and unzip the website files
RUN wget https://www.tooplate.com/zip-templates/2133_moso_interior.zip
RUN unzip 2133_moso_interior.zip

# Runtime Stage
FROM ubuntu:latest

# Install Apache
RUN apt update && apt install -y apache2

# Set working directory for Apache
WORKDIR /var/www/html

# Copy website files from the build stage to the final image
COPY --from=build /app/2133_moso_interior/ .

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

