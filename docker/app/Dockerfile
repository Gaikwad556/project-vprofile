FROM openjdk:11 AS app
RUN apt update && apt install maven -y
RUN git clone  https://github.com/Gaikwad556/vprofile-project.git
RUN cd vprofile-project && mvn install

FROM tomcat:9-jre11
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=app target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]