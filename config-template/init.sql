-- create databases
CREATE DATABASE IF NOT EXISTS `matomo`;
CREATE DATABASE IF NOT EXISTS `gitea`;
CREATE DATABASE IF NOT EXISTS `moodle`;

-- create matomo user
CREATE USER 'matomodb'@'%' IDENTIFIED BY 'matomo-pass';
GRANT ALL PRIVILEGES ON *.* TO 'matomodb'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'matomodb'@'%';

-- create gitea user
CREATE USER 'gitea'@'%' IDENTIFIED BY 'gitea-pass';
GRANT ALL PRIVILEGES ON *.* TO 'gitea'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'gitea'@'%';

-- create moodle user
CREATE USER 'moodle'@'%' IDENTIFIED BY 'moodle-pass';
GRANT ALL PRIVILEGES ON *.* TO 'moodle'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'moodle'@'%';

FLUSH PRIVILEGES;