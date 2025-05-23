FROM gradle:7.6-jdk17 AS BUILD
WORKDIR /app
COPY . .
RUN chmod +x ./gradlew
RUN ./gradlew bootJar
FROM openjdk:17 AS RUNTIME
WORKDIR /app
COPY --from=BUILD /app/build/libs/*.jar app.jar
ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "/app/app.jar"]