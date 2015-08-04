	# Set MySQL root password
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'

# Install packages
apt-get update
apt-get -y install mysql-server-5.5 php5-mysql libsqlite3-dev apache2 php5 php5-dev build-essential php-pear php5-xmlrpc php5-curl ruby1.9.1-dev build-essential php5-gd

# Set timezone
echo "Europe/Madrid" | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

# Setup database
echo "DROP DATABASE IF EXISTS test" | mysql -uroot -proot
echo "CREATE USER 'devdb'@'localhost' IDENTIFIED BY 'devdb'" | mysql -uroot -proot
echo "CREATE DATABASE devdb" | mysql -uroot -proot
echo "GRANT ALL ON devdb.* TO 'devdb'@'localhost'" | mysql -uroot -proot
echo "FLUSH PRIVILEGES" | mysql -uroot -proot

# Apache changes
echo "ServerName localhost" >> /etc/apache2/apache2.conf
a2enmod rewrite
cat /var/custom_config_files/apache2/default | tee /etc/apache2/sites-available/000-default.conf

# Install Mailcatcher
echo "Installing mailcatcher"
gem install mailcatcher --no-ri --no-rdoc
mailcatcher --http-ip=192.168.56.101

# Configure PHP
sed -i '/;sendmail_path =/c sendmail_path = "/usr/local/bin/catchmail"' /etc/php5/apache2/php.ini
sed -i '/display_errors = Off/c display_errors = On' /etc/php5/apache2/php.ini
#sed -i '/error_reporting = E_ALL | E_STRICT/c error_reporting = E_ALL & ~E_DEPRECATED' /etc/php5/apache2/php.ini
sed -i '/upload_max_filesize = 2M/c upload_max_filesize = 50M' /etc/php5/apache2/php.ini

sed -i '/max_execution_time = 30/c max_execution_time = 360' /etc/php5/apache2/php.ini
sed -i '/max_input_time = 60/c max_input_time = 120' /etc/php5/apache2/php.ini

#:wq!sed -i '/html_errors = Off/c html_errors = On' /etc/php5/apache2/php.ini

sudo sed -i 's/APACHE_RUN_USER=.*/APACHE_RUN_USER=vagrant/g' /etc/apache2/envvars
sudo sed -i 's/APACHE_RUN_GROUP=.*/APACHE_RUN_GROUP=www-data/g' /etc/apache2/envvars

# @begin X-Debug
mkdir /var/log/xdebug
chown www-data:www-data /var/log/xdebug
sudo pecl install xdebug

if [ ! -h /var/www ];  then
	echo '' >> /etc/php5/apache2/php.ini
	echo ';;;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php5/apache2/php.ini
	echo '; Added to enable Xdebug ;' >> /etc/php5/apache2/php.ini
	echo ';;;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php5/apache2/php.ini
	echo '' >> /etc/php5/apache2/php.ini
	echo 'zend_extension="'$(find / -name 'xdebug.so' 2> /dev/null)'"' >> /etc/php5/apache2/php.ini
	echo 'xdebug.default_enable = 1' >> /etc/php5/apache2/php.ini
	echo 'xdebug.idekey = "vagrant"' >> /etc/php5/apache2/php.ini
	echo 'xdebug.remote_enable = 1' >> /etc/php5/apache2/php.ini
	echo 'xdebug.remote_autostart = 0' >> /etc/php5/apache2/php.ini
	echo 'xdebug.remote_port = 9000' >> /etc/php5/apache2/php.ini
	echo 'xdebug.remote_handler=dbgp' >> /etc/php5/apache2/php.ini
	echo 'xdebug.remote_log="/var/log/xdebug/xdebug.log"' >> /etc/php5/apache2/php.ini
	echo 'xdebug.remote_host=10.0.2.2 ; IDE-Environments IP, from vagrant box.' >> /etc/php5/apache2/php.ini
fi
# @end X-Debug

# Make sure things are up and running as they should be
mailcatcher --http-ip=192.168.56.101
service apache2 restart