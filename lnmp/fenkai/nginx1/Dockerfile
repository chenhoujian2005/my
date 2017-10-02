# Base image to use, this must be set as the first line
FROM centos7

# Maintainer: docker_user <docker_user at email.com> (@docker_user)
MAINTAINER chenjian jianchen@alauda.io

# 暴露的端口
EXPOSE 80

# 移到文件到容器
COPY ["soft/nginx-1.9.9.tar.gz", "/usr/local/src/"]

# 操作yum源
RUN yum install -y wget
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
RUN cd /etc/yum.repos.d/;wget http://mirrors.163.com/.help/CentOS7-Base-163.repo
RUN yum clean all
RUN yum makecache

# 下载依赖包
RUN yum install -y gcc gcc-c++ autoconf libxml libxml2-devel libcurl libcurl-devel libpng libpng-devel freetype freetype-devel gd gd-devel libjpeg libjpeg-devel openssl libvpx libvpx-devel libmcrypt libmcrypt-devel ncurses ncurses-devel wget openssl openssl-devel pcre pcre-devel vim cmake bzip2

# 解压文件
RUN cd /usr/local/src/;tar zxf nginx-1.9.9.tar.gz

# 操作nginx编译
RUN cd /usr/local/src/nginx-1.9.9;./configure --prefix=/usr/local/nginx-1.9.9 --with-pcre --with-http_ssl_module --with-http_stub_status_module && make && make install && echo "daemon off;" >> /usr/local/nginx-1.9.9/conf/nginx.conf 


# 设置存储卷，指定需要持久化存储的目录，注意以下是容器内的目录
VOLUME ["/usr/local/nginx-1.9.9/html", "/usr/local/nginx-1.9.9/conf","/usr/local/nginx-1.9.9/logs"]


# 容器运行时的指令
CMD /usr/local/nginx-1.9.9/sbin/nginx # 运行nginx
