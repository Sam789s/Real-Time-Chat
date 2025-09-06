# Stage 1: Build with Maven + Java 24
FROM maven:3.9.9-eclipse-temurin-24 AS build
WORKDIR /app
COPY target .
RUN mvn clean package -DskipTests

# Stage 2: Run with Java 24 only
FROM openjdk:24-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]


