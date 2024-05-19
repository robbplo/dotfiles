function ddb
  mysql -h 127.0.0.1 -u root -e "drop database $argv"
end
