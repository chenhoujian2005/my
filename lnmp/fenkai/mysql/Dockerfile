# Base image to use, this must be set as the first line
FROM index.alauda.cn/library/centos:centos7.3.1611

# Maintainer: docker_user <docker_user at email.com> (@docker_user)
MAINTAINER chenjian jianchen@alauda.io

# 暴露的端口
EXPOSE 3306

# 移到文件到容器
COPY ["soft/mysql-5.6.28.tar.gz", "/usr/local/src/"]

# 操作yum源
RUN yum install -y wget
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
RUN cd /etc/yum.repos.d/;wget http://mirrors.163.com/.help/CentOS7-Base-163.repo
RUN yum clean all
RUN yum makecache

# 下载依赖包
RUN yum install -y gcc gcc-c++ autoconf libxml libxml2-devel libcurl libcurl-devel libpng libpng-devel freetype freetype-devel gd gd-devel libjpeg libjpeg-devel openssl libvpx libvpx-devel libmcrypt libmcrypt-devel ncurses ncurses-devel wget openssl openssl-devel pcre pcre-devel vim cmake bzip2

# 解压文件
RUN cd /usr/local/src/;tar zxf mysql-5.6.28.tar.gz

# 操作mysql
RUN mkdir -p /usr/local/www/data/mysql/data
RUN groupadd mysql
RUN useradd -g mysql mysql
RUN chown -R mysql:mysql /usr/local/www/data/mysql/data
RUN cd /usr/local/src/mysql-5.6.28;cmake -DMYSQL_USER=mysql -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/usr/local/www/data/mysql/data -DSYSCONFDIR=/etc -DMYSQL_USER=mysql -DMYSQL_UNIX_ADDR=/tmp/mysql/mysql.sock  -DDEFAULT_CHARSET=utf8  -DDEFAULT_COLLATION=utf8_general_ci -DEXTRA_CHARSETS=all -DWITH_EMBEDDED_SERVER=1 -DENABLED_LOCAL_INFILE=1 -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DMYSQL_TCP_PORT=3306 -DWITH_SSL:STRING=bundled -DWITH_ZLIB:STRING=bundled && make && make install

#操作mysql配置文件
COPY ["./soft/mysql/my.cnf", "/etc/my.cnf"]
COPY ["./soft/mysql/my.cnf.d/", "/etc/my.cnf.d/"]

# 初始化mysql
RUN /usr/local/mysql/scripts/mysql_install_db --basedir=/usr/local/mysql/ --datadir=/usr/local/www/data/mysql/data --defaults-extra-file=/etc/my.cnf --user=mysql --pid-file=/usr/local/www/data/mysql/data/mysql.pid
RUN mkdir -p /var/log/mariadb/ && chown -R mysql:mysql /var/log/mariadb/

# 设置挂载
VOLUME ["/usr/local/www"] 

# 容器运行时的指令
CMD /usr/local/mysql/support-files/mysql.server start 
