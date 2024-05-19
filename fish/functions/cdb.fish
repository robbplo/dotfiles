function cdb 
  mysql -h 127.0.0.1 -u root -e "create database $argv"
end
