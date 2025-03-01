# GitHubActionsDemo1.0
This project will demonstrate a simple github actions worflow.
1. Simple Get Rest Api
2. Docker build and push to docker hub github actions

# Steps to build and run docker image
Creating a Docker image for a Spring Boot application that uses Gradle involves writing a `Dockerfile` that defines the necessary steps to build and run the application inside a Docker container. Here's a step-by-step guide to creating a Dockerfile for your Spring Boot Gradle-based application:

### Step-by-Step Guide

1. **Ensure Gradle Wrapper is Available:**
   Ensure your project includes the Gradle wrapper scripts (`gradlew` and `gradlew.bat`) and the `gradle` directory with the wrapper JAR files.

2. **Create a Dockerfile:**
   In the root directory of your Spring Boot application, create a file named `Dockerfile` with the following content:

### Dockerfile

```dockerfile
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
```

### Explanation of the Dockerfile

1. **Base Image for Building:**
   ```dockerfile
   FROM gradle:7.6-jdk17 AS build
   ```
    - This uses an official Gradle image with JDK 17 to build the application.

2. **Set Working Directory:**
   ```dockerfile
   WORKDIR /app
   ```
    - This sets `/app` as the working directory inside the container.

3. **Copy Gradle Wrapper and Configuration Files:**
   ```dockerfile
   COPY gradlew ./
   COPY gradle ./gradle
   ```
    - These lines copy the Gradle wrapper script and configuration files into the container.

4. **Copy Application Files:**
   ```dockerfile
   COPY . .
   ```
    - This copies all the files from the current directory into the container.

5. **Grant Execute Permission to Gradle Wrapper:**
   ```dockerfile
   RUN chmod +x gradlew
   ```
    - This grants execute permission to the Gradle wrapper script.

6. **Build the Application:**
   ```dockerfile
   RUN ./gradlew build --no-daemon
   ```
    - This runs the Gradle build command to compile and package the application.

7. **Base Image for Running:**
   ```dockerfile
   FROM openjdk:17-jdk-slim
   ```
    - This uses a slim version of the OpenJDK 17 image to run the application.

8. **Set Working Directory:**
   ```dockerfile
   WORKDIR /app
   ```

9. **Copy the JAR File:**
   ```dockerfile
   COPY --from=build /app/build/libs/*.jar app.jar
   ```
    - This copies the JAR file built in the previous stage into the container.

10. **Expose the Application Port:**
    ```dockerfile
    EXPOSE 8080
    ```
    - This exposes port 8080, which is the default port for Spring Boot applications.

11. **Run the Application:**
    ```dockerfile
    ENTRYPOINT ["java", "-jar", "app.jar"]
    ```
    - This defines the command to run the application using the `java -jar` command.

### Building and Running the Docker Image

1. **Build the Docker Image:**
   ```sh
   docker build -t githubactionsdemo1.0 .
   ```
    - This command builds the Docker image and tags it as `githubactionsdemo1.0`.

2. **Run the Docker Container:**
   ```sh
   docker run -p 8080:8080 githubactionsdemo1.0
   ```
    - This command runs the Docker container, mapping port 8080 on the host to port 8080 in the container.

### Summary

- The `Dockerfile` defines a multi-stage build to first build the application using a Gradle image and then run it using a slim OpenJDK image.
- The `COPY --from=build` command ensures only the necessary artifacts (the JAR file) are included in the final image, making it smaller and more secure.
- The `EXPOSE` and `ENTRYPOINT` instructions configure the container to run your Spring Boot application properly.

By following these steps, you can create a Docker image for your Spring Boot Gradle-based application and run it in a Docker container.
