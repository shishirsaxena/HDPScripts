--Ranger
GRANT ALL PRIVILEGES ON `%`.* TO 'ranger'@'localhost' IDENTIFIED BY 'ranger';
GRANT ALL PRIVILEGES ON `%`.* TO 'ranger'@'%' IDENTIFIED BY 'ranger';
GRANT ALL PRIVILEGES ON `%`.* TO 'ranger'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `%`.* TO 'ranger'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

GRANT ALL PRIVILEGES ON `%`.* TO 'rangerdba'@'localhost' IDENTIFIED BY 'rangerdba';
GRANT ALL PRIVILEGES ON `%`.* TO 'rangerdba'@'%' IDENTIFIED BY 'rangerdba';
GRANT ALL PRIVILEGES ON `%`.* TO 'rangerdba'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `%`.* TO 'rangerdba'@'%' WITH GRANT OPTION;

