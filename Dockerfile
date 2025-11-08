# Use official lightweight Java runtime
FROM eclipse-temurin:17-jdk

# Set working directory inside container
WORKDIR /app

# Copy the built jar from Maven target folder
COPY target/vkspringboot-0.0.1-SNAPSHOT.jar app.jar

# Expose default Spring Boot port
EXPOSE 8080

# Run the jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
