# Use an official Gradle image to build the application
FROM gradle:7.6-jdk17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Gradle wrapper and Gradle configuration files
COPY gradlew ./
COPY gradle ./gradle

# Copy the rest of the project files
COPY . .

# Grant execute permission to the Gradle wrapper
RUN chmod +x gradlew

# Build the application using the Gradle wrapper
RUN ./gradlew build --no-daemon

# Use an official OpenJDK image to run the application
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose the port the application runs on
EXPOSE 8080

# Define the command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
