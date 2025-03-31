FROM maven:3.8-openjdk-11 as builder

WORKDIR /app
COPY . .
RUN mvn clean package

FROM openjdk:11-jre-slim

WORKDIR /app
COPY --from=builder /app/target/JMusicBot-Snapshot-All.jar ./JMusicBot.jar
COPY config.txt .

CMD ["java", "-jar", "JMusicBot.jar"] 