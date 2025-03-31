FROM maven:3.8-openjdk-11 as builder

WORKDIR /app
COPY . .
RUN mvn clean package

FROM openjdk:11-jre-slim

WORKDIR /app
COPY --from=builder /app/target/JMusicBot-Snapshot-All.jar ./JMusicBot.jar

# Create Playlists directory
RUN mkdir -p Playlists

# Set environment variables with defaults
ENV TOKEN=""
ENV OWNER_ID=""

# Create config file
RUN echo '/// START OF JMUSICBOT CONFIG ///' > config.txt && \
    echo "token = ${TOKEN}" >> config.txt && \
    echo "owner = ${OWNER_ID}" >> config.txt && \
    echo 'prefix = "!"' >> config.txt && \
    echo 'altprefix = ">"' >> config.txt && \
    echo "help = help" >> config.txt && \
    echo "status = ONLINE" >> config.txt && \
    echo 'game = "MUSIC"' >> config.txt && \
    echo "songinstatus = true" >> config.txt && \
    echo "stayinchannel = false" >> config.txt && \
    echo "maxtime = 0" >> config.txt && \
    echo "alonetimeuntilstop = 0" >> config.txt && \
    echo 'playlistsfolder = "Playlists"' >> config.txt && \
    echo "updatealerts = true" >> config.txt && \
    echo "npimages = true" >> config.txt && \
    echo '/// END OF JMUSICBOT CONFIG ///' >> config.txt

CMD ["java", "-jar", "JMusicBot.jar"] 