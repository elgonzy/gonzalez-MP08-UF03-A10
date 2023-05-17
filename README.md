# gonzalez-MP08-UF03-A10
# LAMP Server Setup Guide

## Step 1: Install Apache

First, update your package manager to ensure you have the latest version of all packages:
sudo apt-get update


Then, install Apache using the `apt-get` command:
sudo apt-get install apache2

This will install the Apache web server and all required dependencies.

After installation, you can edit the Apache configuration file located at `/etc/apache2/apache2.conf` to customize your server settings. For example, you can change the `ServerName` directive to set the server's hostname.

Once you have made your changes, restart the Apache service to apply them:
sudo service apache2 restart


## Step 2: Install MariaDB
MariaDB is a popular open-source database management system. To install it, use the following command:
sudo apt-get install mariadb-server


After installation, it's recommended to run the `mysql_secure_installation` script to secure your installation. This script will prompt you to set a password for the root user, remove anonymous users, disallow remote root login, and remove the test database:
sudo mysql_secure_installation


You can also edit the MariaDB configuration file located at `/etc/mysql/mariadb.conf.d/50-server.cnf` to customize your database settings. For example, you can change the `bind-address` directive to set the IP address that MariaDB listens on.

Once you have made your changes, restart the MariaDB service to apply them:
sudo service mysql restart


## Step 3: Install PHP
PHP is a popular server-side scripting language. To install PHP and required modules, use the following command:
sudo apt-get install php libapache2-mod-php php-mysql

This will install PHP and the `libapache2-mod-php` module, which allows Apache to serve PHP files. The `php-mysql` module is also installed to allow PHP to interact with MariaDB.

After installation, you can edit the PHP configuration file located at `/etc/php/7.4/apache2/php.ini` (the version number may vary) to customize your PHP settings. For example, you can change the `upload_max_filesize` directive to set the maximum size of uploaded files.

Once you have made your changes, restart the Apache service to apply them:
sudo service apache2 restart


## Step 4: Install phpMyAdmin
phpMyAdmin is a web-based interface for managing MariaDB databases. To install it, use the following command:
sudo apt-get install phpmyadmin


During the installation process, you will be prompted to select the web server to configure. Select "apache2" and continue with the installation.

## Step 5: Install FTP
FTP (File Transfer Protocol) is a protocol used for transferring files between computers. To set up an FTP server on your LAMP server, you can use `vsftpd` (Very Secure FTP Daemon). To install it, use the following command:
sudo apt-get install vsftpd


After installation, edit the configuration file located at `/etc/vsftpd.conf` to customize your FTP server settings. For example, you can uncomment the `write_enable=YES` line to allow users to upload files.

Once you have made your changes, restart the `vsftpd` service to apply them:
sudo service vsftpd restart


## Step 6: Restart Apache
Finally, restart the Apache web server to apply all changes:
sudo service apache2 restart


Your LAMP server with MariaDB, phpMyAdmin, PHP, and FTP is now set up and ready to use!
