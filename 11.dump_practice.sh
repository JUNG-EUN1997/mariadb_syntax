# local에서 sql 덤프파일 생성
# mysqldump -u root -p --default-character-set=utf8mb4 board > dumpfile.sql
mysqldump -u root -p board -r dumpfile.sql #한글깨짐 문제