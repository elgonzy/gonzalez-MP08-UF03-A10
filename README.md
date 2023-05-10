# gonzalez-MP08-UF03-A10
## Dockerfile Guide

This Dockerfile creates an Ubuntu-based image with LAMP (Linux, Apache, MySQL, PHP) and vsftpd installed.

## Base Image

``
FROM ubuntu:latest
``

This line specifies that the base image is the latest version of Ubuntu.

## Create User

``
RUN useradd -m adri && \
    echo 'adri:12345' | chpasswd
``

This command creates a new user named `adri` with the password `12345`.


## Install LAMP
``
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 mysql-server php libapache2-mod-php php-mysql
``

This command installs the LAMP stack by updating the package list and installing Apache, MySQL, PHP and their dependencies.

## Configure Apache

``
RUN echo "AddType application/x-httpd-php .php" >> /etc/apache2/apache2.conf
``

This command configures Apache to handle PHP files by adding the necessary configuration to the `apache2.conf` file.

## Install vsftpd

``
RUN apt-get install -y vsftpd
``

This command installs vsftpd, a popular FTP server.

``
## Configure vsftpd
``
RUN sed -i 's/#write_enable=YES/write_enable=YES/' /etc/vsftpd.conf && \
    sed -i 's/#chroot_local_user=YES/chroot_local_user=YES/' /etc/vsftpd.conf && \
    sed -i '$a\pasv_min_port=30000' /etc/vsftpd.conf && \
    sed -i '$a\pasv_max_port=30009' /etc/vsftpd.conf && \
    sed -i '$a\user_sub_token=$USER' /etc/vsftpd.conf && \
    sed -i '$a\local_root=/home/$USER/ftp' /etc/vsftpd.conf && \
    sed -i '$a\userlist_enable=YES' /etc/vsftpd.conf && \
    sed -i '$a\userlist_file=/etc/vsftpd.userlist' /etc/vsftpd.conf && \
    sed -i '$a\userlist_deny=NO' /etc/vsftpd.conf && \
    sed -i '$a\allow_writeable_chroot=YES' /etc/vsftpd.conf
``

These commands configure vsftpd by enabling write access, chrooting local users, setting passive port range and other options.

## Add User to vsftpd Userlist

``
RUN echo "adri" >> /etc/vsftpd.userlist
``

This command adds the user `adri` to the vsftpd userlist.

## Create Secure Chroot Directory

``
RUN mkdir -p /var/run/vsftpd/empty && chown root.root /var/run/vsftpd/empty
``

This command creates the `secure_chroot_dir` directory and sets its ownership to `root`.

## Create FTP Directory

``
RUN mkdir /home/adri/ftp && chown adri.adri /home/adri/ftp
``

This command creates an FTP directory for the user `adri` and sets its ownership to `adri`.

## Expose FTP Ports

``
EXPOSE 21 30000-30009
``

This command exposes the FTP ports 21 and 30000-30009.

## Start Services

``
CMD service apache2 start && service mysql start && /usr/sbin/vsftpd .
``

This command starts Apache, MySQL and vsftpd when the container is run.