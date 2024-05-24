# local에서 sql 덤프파일 생성
# mysqldump -u root -p --default-character-set=utf8mb4 board > dumpfile.sql
mysqldump -u root -p board -r dumpfile.sql #한글깨짐 문제

# 리눅스에 mariadb 설치
sudo apt-get install mariadb-server

# mariadb 서버 시작
sudo systemctl start mariadb

# mariadb 접속테스트 및 접속
sudo mariadb -u root -p

# database 생성
create database board;

# git 설치
sudo apt install git;

# git clone
git clone https://github.com/JUNG-EUN1997/mariadb_syntax.git;

# clone 여부 확인
cd mariadb_syntax/
ls

# dump 넣기 - clone 위치에!!
sudo mysql -u root -p board < dumpfile.sql


