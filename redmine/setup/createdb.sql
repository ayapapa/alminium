CREATE DATABASE alminium DEFAULT CHARACTER SET utf8;
GRANT ALL PRIVILEGES ON alminium.* TO 'alminium'@'localhost' IDENTIFIED BY 'alminium';
GRANT ALL PRIVILEGES ON alminium.* TO 'alminium'@'%' IDENTIFIED BY 'alminium';
GRANT PROCESS ON *.* TO 'alminium'@'localhost' IDENTIFIED BY 'alminium';
GRANT PROCESS ON *.* TO 'alminium'@'%' IDENTIFIED BY 'alminium';
