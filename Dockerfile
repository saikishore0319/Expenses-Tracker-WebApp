#stage 1 : Build the java application runtime (JAR) using maven
FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /app

COPY . .

RUN mvn clean install -DskipTests=true

RUN ls -l /app/target

#stage 2 : execute the JAR file form the above stage

FROM openjdk:17-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/expenseapp.jar

EXPOSE 8080

CMD ["java","-jar", "expenseapp.jar"]
