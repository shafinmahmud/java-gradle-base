# @author shafin
# @since 23/7/2018
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

# Default config
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
	gnupg software-properties-common curl vim net-tools make

RUN add-apt-repository ppa:webupd8team/java \
	&& add-apt-repository ppa:cwchien/gradle \
	&& echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# Oracle Java
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	&& oracle-java8-installer oracle-java8-set-default \
	&& ln -s /usr/lib/jvm/java-8-oracle/jre /usr/lib/jvm/default-java

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Gradle, Maven
RUN apt-get install -y gradle maven

# Cleanup apt
RUN	apt-get -y autoclean \
	&& apt-get -y autoremove \
	&& rm -rf /var/lib/apt/lists/*