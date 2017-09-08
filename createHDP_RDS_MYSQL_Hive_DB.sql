-- Set values for hive-host before running.
CREATE USER 'hive'@'%' IDENTIFIED BY 'hive';
GRANT ALL PRIVILEGES ON `%`.* TO 'hive'@'%' IDENTIFIED BY 'hive';
CREATE USER 'hive'@'localhost' IDENTIFIED BY 'hive';
GRANT ALL PRIVILEGES ON `%`.* TO 'hive'@'localhost' IDENTIFIED BY 'hive';
CREATE USER 'hive'@'hive-host' IDENTIFIED BY 'hive';
GRANT ALL PRIVILEGES ON `%`.* TO 'hive'@'hive-host' IDENTIFIED BY 'hive';
FLUSH PRIVILEGES;
CREATE DATABASE hive;

