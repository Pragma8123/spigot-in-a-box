FROM java as build-env
WORKDIR /spigot
RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -Xmx1G -jar BuildTools.jar

FROM java
ENV MEM_MIN 512M
ENV MEM_MAX 1G
WORKDIR /minecraft
COPY --from=build-env /spigot/spigot* /usr/local/spigot/spigot.jar
VOLUME /minecraft
EXPOSE 25565
CMD echo "eula=true" > eula.txt && java -Xmx${MEM_MAX} -Xms${MEM_MIN} -jar /usr/local/spigot/spigot.jar nogui
