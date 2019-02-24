FROM maven:3.6-jdk-8 AS build  
LABEL maintainer="Parjanya Mudunuri <parj@live.co.uk>"
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app  
ENV MAVEN_OPTS=-Dmaven.artifact.threads=30
RUN mvn -f /usr/src/app/pom.xml clean package

FROM gcr.io/distroless/java  
COPY --from=build /usr/src/app/target/samplespringbootapp-1.0-SNAPSHOT.jar /usr/app/samplespringbootapp-1.0-SNAPSHOT.jar  
EXPOSE 8080  
ENTRYPOINT ["java","-jar","/usr/app/samplespringbootapp-1.0-SNAPSHOT.jar"]  