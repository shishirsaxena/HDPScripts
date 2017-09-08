-- Set values for ambari-host before running.

CREATE USER 'ambari'@'%' IDENTIFIED BY 'ambari';
GRANT ALL PRIVILEGES ON '%'.* TO 'ambari'@'%';
CREATE USER 'ambari'@'localhost' IDENTIFIED BY 'ambari';
GRANT ALL PRIVILEGES ON `%`.* TO 'ambari'@'localhost';
CREATE USER 'ambari'@'ambari-host' IDENTIFIED BY 'ambari';
GRANT ALL PRIVILEGES ON `%`.* TO 'ambari'@'ambari-host';
FLUSH PRIVILEGES;
create database ambari;
use ambari;

