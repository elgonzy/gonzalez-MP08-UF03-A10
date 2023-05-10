FROM ubuntu:latest

# Create user adri with password 12345
RUN useradd -m adri && \
    echo 'adri:12345' | chpasswd

# Install LAMP
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 mysql-server php libapache2-mod-php php-mysql

# Configure Apache to handle PHP files
RUN echo "AddType application/x-httpd-php .php" >> /etc/apache2/apache2.conf

# Install vsftpd
RUN apt-get install -y vsftpd

# Configure vsftpd
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

# Add user to vsftpd userlist
RUN echo "adri" >> /etc/vsftpd.userlist

# Create secure_chroot_dir and set ownership to root
RUN mkdir -p /var/run/vsftpd/empty && chown root.root /var/run/vsftpd/empty

# Create ftp directory and set ownership to adri
RUN mkdir /home/adri/ftp && chown adri.adri /home/adri/ftp

# Expose FTP ports
EXPOSE 21 30000-30009

# Start Apache and MySQL
CMD service apache2 start && service mysql start && /usr/sbin/vsftpd