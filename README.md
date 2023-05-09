# gonzalez-MP08-UF03-A10
## Dockerfile Guide

This Dockerfile creates an Ubuntu-based image that includes LAMP (Linux, Apache, MySQL, PHP) and vsftpd (Very Secure FTP Daemon).

`` FROM ubuntu:latest``

This command specifies the base image for the Docker image. In this case, the base image is the latest version of Ubuntu.

`` RUN useradd -m adri && echo 'adri:12345' | chpasswd``

This command creates a new user named `adri` with the password `12345`. The `useradd` command is used to create the new user with the `-m` option to create a home directory for the user. The `echo` and `chpasswd` commands are used to set the password for the new user.

`` RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 mysql-server php libapache2-mod-php php-mysql``

This command installs the LAMP stack (Linux, Apache, MySQL, PHP) on the Ubuntu base image. The `apt-get update` command is used to update the package index. The `DEBIAN_FRONTEND=noninteractive` environment variable is used to prevent `apt-get` from prompting for user input during installation. The `apt-get install` command is used to install the `apache2`, `mysql-server`, `php`, `libapache2-mod-php`, and `php-mysql` packages.


``RUN echo "AddType application/x-httpd-php .php" >> /etc/apache2/apache2.conf``

The RUN echo "AddType application/x-httpd-php .php" >> /etc/apache2/apache2.conf command in the Dockerfile appends the line AddType application/x-httpd-php .php to the Apache configuration file located at /etc/apache2/apache2.conf.

`` RUN apt-get install -y vsftpd``

This command installs the vsftpd (Very Secure FTP Daemon) package on the Ubuntu base image using the `apt-get install` command.

`` RUN sed -i 's/#write_enable=YES/write_enable=YES/' /etc/vsftpd.conf && sed -i 's/#chroot_local_user=YES/chroot_local_user=YES/' /etc/vsftpd.conf && sed -i '$a\pasv_min_port=30000' /etc/vsftpd.conf && sed -i '$a\pasv_max_port=30009' /etc/vsftpd.conf``

This command configures vsftpd by updating its configuration file `/etc/vsftpd.conf`. The `sed` command is used to perform several changes to the file:

- The first `sed` command enables write access for FTP users by uncommenting the `write_enable=YES` line.
- The second `sed` command enables chrooting of local users by uncommenting the `chroot_local_user=YES` line.
- The third and fourth `sed` commands add two new lines to the end of the file to specify the minimum and maximum ports for passive FTP connections.

`` EXPOSE 21 30000-30009``

This command exposes ports 21 and 30000-30009 for FTP connections. Port 21 is used for control connections and ports 30000-30009 are used for passive data connections.

`` CMD service apache2 start && service mysql start && /usr/sbin/vsftpd``

This command starts Apache, MySQL, and vsftpd when the container is run. The `service` command is used to start Apache and MySQL using their respective init scripts. The `/usr/sbin/vsftpd` command is used to start vsftpd in standalone mode.