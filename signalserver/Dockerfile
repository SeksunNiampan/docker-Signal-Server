# FROM holbertonschool/base-ubuntu-1404
FROM ubuntu:14.04
LABEL maintainer="57160608@go.buu.ac.th"

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update
RUN apt-get install wget -y

# --> Install java 1.8 <--
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get -y upgrade
RUN apt-get -y update
RUN apt-get install openjdk-8-jdk openjdk-8-jre -y
RUN echo "JAVA_HOME=\"/usr/lib/jvm/java-8-openjdk-amd64\"" >>  /etc/environment
RUN ["/bin/bash", "-c", "source /etc/environment"]
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >>  ~/.bashrc
RUN echo "export PATH=\$JAVA_HOME/bin:\$PATH" >>  ~/.bashrc
RUN ["/bin/bash", "-c", "source ~/.bashrc"]
RUN update-ca-certificates -f
RUN apt-get install --reinstall ca-certificates-java

# --> Install maven 3.5 <--
RUN apt-get install maven -y
RUN cd /usr/local && wget http://www-eu.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
RUN cd /usr/local && tar xzf apache-maven-3.5.2-bin.tar.gz \ 
    && ln -s apache-maven-3.5.2 apache-maven
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/profile.d/apache-maven.sh
RUN echo "export M2_HOME=/usr/local/apache-maven" >> /etc/profile.d/apache-maven.sh
RUN echo "export MAVEN_HOME=/usr/local/apache-maven" >> /etc/profile.d/apache-maven.sh
RUN echo "export PATH=\${M2_HOME}/bin:\${PATH}" >> /etc/profile.d/apache-maven.sh
RUN source /etc/profile.d/apache-maven.sh && mvn -version
RUN java -version

COPY ./ssl /ssl

# --> Install Signal Server <--
COPY ./Signal-Server /Signal-Server
RUN source /etc/profile.d/apache-maven.sh && cd /Signal-Server && mvn install -DskipTests

# --> Run server <--
EXPOSE 8080
EXPOSE 8081

CMD ["/bin/bash", "-c", "java -jar /Signal-Server/target/TextSecureServer-1.70.jar server /Signal-Server/config/Signal.yml"]