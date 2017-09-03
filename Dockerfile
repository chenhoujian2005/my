FROM index.alauda.cn/library/ubuntu:16.04
COPY sources.list /etc/apt/sources.list
# Install Java.
RUN \
  apt-get update && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  apt-get install -y python-software-properties software-properties-common && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer libc6 libcurl3-gnutls zlib1g curl maven && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* 


# Define working directory.
WORKDIR /data

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Define default command.
CMD ["bash"]
