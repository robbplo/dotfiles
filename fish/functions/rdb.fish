function rdb 
  mysql -u root -e "drop database $argv"
  mysql -u root -e "create database $argv"
end
