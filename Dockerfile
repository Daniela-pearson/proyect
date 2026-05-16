# Etapa 1: compilar el proyecto
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build
WORKDIR /build
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa 2: imagen final liviana
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /build/target/checkautos-1.0.0.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]