#/bin/bash

#install path for apr, apr-util, pcre, httpd
default_install_path='/usr/local'
apr_path="${default_install_path}/apr"
apr_util_path="${default_install_path}/apr-util"
pcre_path="${default_install_path}/pcre"
httpd_path="${default_install_path}/httpd"
mysql_path="${default_install_path}/mysql"
libxml2_path="${default_install_path}/libxml2"
php_path="${default_install_path}/php"

#download links for apr, apr-util, pcre, httpd
links[0]='http://supergsego.com/apache//apr/apr-1.5.1.tar.gz'
links[1]='http://supergsego.com/apache//apr/apr-util-1.5.4.tar.gz'
links[2]='ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.36.tar.gz'
links[3]='http://apache.osuosl.org//httpd/httpd-2.4.10.tar.gz'
links[4]='http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.21.tar.gz'
links[5]='ftp://xmlsoft.org/libxml2/libxml2-2.9.2.tar.gz'
links[6]='http://cn2.php.net/distributions/php-5.6.2.tar.gz'

for link in ${links[@]}; do
    echo "Downloading ${link##*/} ..."
    wget ${link} > /dev/null 2>&1
    filename=${link##*/} > /dev/null 2>&1
    tar -zxvf ${filename} > /dev/null 2>&1
    echo "Extract ${filename}: done"
done
echo -ne "\n----------file prepare: done----------\n"

#install apr
prev_dir=${PWD}
apr_dir=${links[0]##*/}
apr_dir=${apr_dir%%.tar*}
cd ${apr_dir}
./configure --prefix=${apr_path}
make
make install
cd ${prev_dir}
echo -ne "\n----------install apr: done----------\n"

#install apr-util
prev_dir=${PWD}
apr_util_dir=${links[1]##*/}
apr_util_dir=${apr_util_dir%%.tar*}
cd ${apr_util_dir}
./configure --prefix=${apr_util_path} --with-apr=${apr_path}
make
make install
cd ${prev_dir}
echo -ne "\n----------install apr-util: done----------\n"

#install pcre
prev_dir=${PWD}
pcre_dir=${links[2]##*/}
pcre_dir=${pcre_dir%%.tar*}
cd ${pcre_dir}
./configure --prefix=${pcre_path}
make
make install
cd ${prev_dir}
echo -ne "\n----------install pcre: done----------\n"

#install httpd
httpd_dir=${PWD}
httpd_dir=${links[3]##*/}
httpd_dir=${httpd_dir%%.tar*}
cd ${httpd_dir}
./configure --prefix=${httpd_path} --with-apr=${apr_path} --with-apr-util=${apr_util_path} --with-pcre=${pcre_path} \
    --enable-modules=all --enable-mods-shared=all
make
make install
cd ${prev_dir}
echo -ne "\n----------install httpd: done----------\n"

#install libncurses5-dev first
apt-get install libncurses5-dev
echo -ne "\n----------install libncurses5-dev: done----------\n"

install cmake
apt-get install cmake
echo -ne "\n----------install cmake: done----------\n"

#install myssql
prev_dir=${PWD}
mysql_dir=${links[4]##*/}
mysql_dir=${mysql_dir%%.tar*}
cd ${mysql_dir}
cmake . -DCMAKE_INSTALL_PREFIX=${mysql_path} -DMYSQL_DATADIR=${mysql_path}/data -DDEFAULT_CHARSET=utf8 \
    -DDEFAULT_COLLATION=utf8_general_ci -DEXTRA_CHARSETS=all -DENABLED_LOCAL_INFILE=1
make
make install
cd ${prev_dir}
echo -ne "\n----------install mysql: done----------\n"

#install python-dev
apt-get install python-dev

#install libxml2
prev_dir=${PWD}
libxml2_dir=${links[5]##*/}
libxml2_dir=${libxml2_dir%%.tar*}
cd ${libxml2_dir}
./configure --prefix=${libxml2_path}
make
make install
cd ${prev_dir}
echo -ne "\n----------install libxml2: done----------\n"

#install php
prev_dir=${PWD}
php_dir=${links[6]##*/}
php_dir=${php_dir%%.tar*}
cd ${php_dir}
./configure --prefix=${php_path} --with-apxs2=${httpd_path}/bin/apxs --with-libxml-dir=${libxml2_path} \
    --with-mysqli=${mysql_path}/bin/mysql_config --with-mysql=${mysql_path}
make
make install
cd ${prev_dir}
echo -ne "\n----------install php: done----------\n"

for link in ${links[@]}; do
    dir_name=${link##*/}
    dir_name=${dir_name%%.tar*}
    rm dir_name -rf
done

exit
