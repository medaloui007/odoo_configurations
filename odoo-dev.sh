#!/bin/bash
# to run the script "sudo /bin/sh odoo_dev.sh"
################################################################################
# Script for preparing Odoo developing platform on Ubuntu 14.04, 15.04 and 16.04 (could be used for other version too)

#-------------------------------------------------------------------------------
# This script will make ur computer ready for developing on ODOO from 8 to 11
#-------------------------------------------------------------------------------
# Make a new file:
# sudo nano odoo_developing.sh
# Place this content in it and then make the file executable:
# sudo chmod +x odoo_developing.sh
# git clone --depth 1 --branch 10.0 https://www.gitlab.com/mah007/odoo .
# Execute the script to install Odoo:
# ./odoo-developing
################################################################################
 
##fixed parameters
#odoo instead of odoo use ur user name .EG OE_USER="mahmoud"
OE_USER="medaloui"
#The default port where this Odoo instance will run under (provided you use the command -c in the terminal)
#Set to true if you want to install it, false if you don't need it or have it already installed.
INSTALL_WKHTMLTOPDF="True"

# Set this to True if you want to install Odoo 9 10 11 Enterprise! ( you can use enterprise normaly too ;) )
IS_ENTERPRISE="True"

##
###  WKHTMLTOPDF download links
## === Ubuntu Trusty x64 & x32 === (for other distributions please replace these two links,
## in order to have correct version of wkhtmltox installed, for a danger note refer to 
## https://www.odoo.com/documentation/8.0/setup/install.html#deb ):
WKHTMLTOX_X64=https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.xenial_amd64.deb
WKHTMLTOX_X32=https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.xenial_i386.deb
#--------------------------------------------------
# Update Server
#--------------------------------------------------
echo -e "\n---- Update Server ----"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install default-jre -y
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get install default-jdk -y
sudo apt-get update
sudo apt-get install oracle-java8-installer -y
sudo add-apt-repository ppa:mystic-mirage/pycharm
sudo apt-get update

#--------------------------------------------------
# Install PostgreSQL Server
#--------------------------------------------------
echo -e "\n---- Install PostgreSQL Server ----"
sudo apt-get install postgresql postgresql-server-dev-* -y

echo -e "\n---- Creating the ODOO PostgreSQL User  ----"
sudo su - postgres -c "createuser -s $OE_USER" 2> /dev/null || true

#--------------------------------------------------
# Install Dependencies
#--------------------------------------------------
echo -e "\n---- Install tool packages ----"
sudo apt-get install wget subversion git bzr bzrtools python-pip python3-pip gdebi-core pysassc -y 
	
echo -e "\n---- Install python packages ----"
sudo apt-get install python-dateutil python-feedparser python-ldap python-libxslt1 python-lxml python-mako python-openid python-psycopg2 python-pybabel python-pychart python-pydot python-pyparsing python-reportlab python-simplejson python-tz python-vatnumber python-vobject python-webdav python-werkzeug python-xlwt python-yaml python-zsi python-docutils python-psutil python-mock python-unittest2 python-jinja2 python-pypdf python-decorator python-requests python-passlib python-pil python-gpgme python-launchpadlib build-essential python-all-dev python-setuptools python-imaging python-suds python-xlsxwriter python-wheel -y
	
echo -e "\n---- Install python libraries ----"
sudo pip install gdata psycogreen
# This is for compatibility with Ubuntu 16.04. Will work on 14.04, 15.04 and 16.04
sudo -H pip install suds

echo -e "\n--- Install other required packages"
sudo apt-get install node-clean-css -y
sudo apt-get install node-less -y
sudo apt-get install python-gevent -y

#--------------------------------------------------
# Install Wkhtmltopdf if needed
#--------------------------------------------------
if [ $INSTALL_WKHTMLTOPDF = "True" ]; then
  echo -e "\n---- Install wkhtml and place shortcuts on correct place for ODOO 9 ----"
  #pick up correct one from x64 & x32 versions:
  if [ "`getconf LONG_BIT`" == "64" ];then
      _url=$WKHTMLTOX_X64
  else
      _url=$WKHTMLTOX_X32
  fi
  sudo wget $_url
  sudo gdebi --n `basename $_url`
  sudo ln -s /usr/local/bin/wkhtmltopdf /usr/bin
  sudo ln -s /usr/local/bin/wkhtmltoimage /usr/bin
else
  echo "Wkhtmltopdf isn't installed due to the choice of the user!"
fi
	



if [ $IS_ENTERPRISE = "True" ]; then
    # Odoo Enterprise install!
	
    echo -e "\n---- Installing Enterprise specific libraries ----"
    sudo apt-get install nodejs npm -y
    sudo npm install -g less
    sudo npm install -g less-plugin-clean-css
    sudo npm install -g rtlcss
else 
    echo -e "\n---- every thing is ready ----"
    
fi	
  sudo ln -s /usr/bin/nodejs /usr/bin/node
  
sudo apt-get install -y libsasl2-dev python-dev libldap2-dev libssl-dev python3-dev
sudo easy_install greenlet
sudo easy_install gevent
sudo apt-get install -y libxml2-dev libxslt1-dev zlib1g-dev python3-pip python3-wheel python3-setuptools
sudo -H pip3 install phonenumbers
sudo -H pip install -r https://raw.githubusercontent.com/odoo/odoo/10.0/requirements.txt
sudo apt install -y python3-asn1crypto 
sudo apt install -y python3-babel python3-bs4 python3-cffi-backend python3-cryptography python3-dateutil python3-docutils python3-feedparser python3-funcsigs python3-gevent python3-greenlet python3-html2text python3-html5lib python3-jinja2 python3-lxml python3-mako python3-markupsafe python3-mock python3-ofxparse python3-openssl python3-passlib python3-pbr python3-pil python3-psutil python3-psycopg2 python3-pydot python3-pygments python3-pyparsing python3-pypdf2 python3-renderpm python3-reportlab python3-reportlab-accel python3-roman python3-serial python3-stdnum python3-suds python3-tz python3-usb python3-vatnumber python3-werkzeug python3-xlsxwriter python3-yaml
sudo -H pip3 install -r https://raw.githubusercontent.com/odoo/odoo/11.0/requirements.txt


echo "-----------------------------------------------------------"
echo "Done! The Odoo developing platform is ready:"

echo "you can now install pycharm community of professional"

echo "using sudo apt-get install pycharm or pycharm-community"

echo "Restart restart ur computer and start developing and have fun ;)"
echo "-----------------------------------------------------------"
