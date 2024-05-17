-- tinyint는 -128~127까지 표현
-- author테이블에 age 컬럼 추가
alter table author add column age tinyint;


-- insert시에 age : 200 ->125 넣어보기
insert into author(id, name, email, age) values(1,'사슴', 'dddd@naver.com',200); -- 여기서는 에러 발생 range
insert into author(id, name, email, age) values(1,'사슴', 'dddd@naver.com',120);

-- unsinged시에 255까지 표현범위 확대
alter table author modify column age tinyint unsigned;
insert into author(id, name, email, age) values(1,'사슴', 'dddd@naver.com',200); -- 표현범위 확대로 정상 실행

-- decimal 실습
alter table post add column price decimal(10, 3); 
describe post;

-- decimal 소수점 초과 값 입력 후 짤림 확인
insert into post(id, title, price) values(7, 'hello java', 3.123123);

-- update: price를 1234.1 
update post set price = 1234.1 where id = 7;

-- blob 바이너리데이터 실습

-- athuor테이블에 profile_image 컬럼을 blob형식으로 추가
alter table author modify column profile_image longblob;
insert into author(id, email, profile_image) value (8, 'abcd6@naver.com', LOAD_FILE('C:\\docuri_yap.jpg'));


-- enum : 삽입될 수 있는 데이터 종류를 한정하는 데이터 타입
-- role 컬럼
alter table author add column role enum('user','admin') not null;
-- not null이고, default 값을 설정하지 않고, enum이 설정되어 있다면, enum의 1번째 값이 기본값으로 설정된다.

-- >> 기본값이 'user'로 설정되어있는 경우
alter table author modify column role enum('user','admin') not null default 'user';

-- enum 컬럼 테스트
-- user1을 insert
insert into author(id, email, role) value(9,'9@mail.com','user1');

-- user 또는 admin을 insert
insert into author(id, email, role) value(10,'9@mail.com','admin');


-- date 타입
-- author테이블에 birth_day 컬럼을 date로 추가
-- 날짜 타입의 insert는 문자열 형식으로 insert
alter table author add column birth_day date;
insert into author(id, email, birth_day) value(11,'11@mail.com','1997-05-21');


-- datethime
-- author, post 둘 다 datetime으로 create_time 컬럼 추가
alter table author add column create_time datetime;
alter table author modify column create_time datetime default current_timestamp;
insert into author(id, email, create_time) value(12,'12@mail.com','2024-05-17 12:22:21');

alter table post add column create_time datetime;
alter table post modify column create_time datetime default current_timestamp;

insert into post(id, title, create_time) value(4,'hehe','2024-05-17 09:14:21');

-- 비교연산자
select * from post where id >= and id <=4; -- and 또는 &&
select * from post where id between 2 and 4;
select * from post where id <2 or id > 4; -- or 또는 ||
select * from post where not(id <2 or id > 4); -- not 또는 !


-- NULL여부 확인
select * from post where contents is null;
select * from post where contents is not null;


-- in(리스트형태), not in(리스트형태)
select * from post where id in(1,2,3);
select * from post where id not in(1,2,3);


-- like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select * from post where title like '%o'  -- o로 끝나는 title 검색
select * from post where title like 'h%'  -- h로 시작하는 title 검색
select * from post where title like '%e%' -- e가 포함하는 title 검색


-- ifnull(a,b) : 만약에 a가 null이면 b 반환
select *, ifnull(author_id,"익명") as writer from post;


-- 경기도에 위치한 식품창고 목록 출력하기
SELECT WAREHOUSE_ID, WAREHOUSE_NAME, ADDRESS, ifnull(FREEZER_YN,'N') from FOOD_WAREHOUSE WHERE WAREHOUSE_NAME LIKE "%_경기%";


-- RGEXP : 정규표현식을 활용한 조회
select * from author where name RGEXP '[a-z]';
select * from author where name RGEXP '[가-힣]';


-- 날짜 변환 : 숫자 -> 날짜, 문자 -> 날짜
-- CAST와 CONVERT
SELECT CAST(20200101 AS DATE);
SELECT CAST('20200101' AS DATE);
SELECT CONVERT(20200101 AS DATE);
SELECT CONVERT(20200101 AS DATE);


-- datetime 조회방법
select * from  author where create_time like '2024-05%';
SELECT * FROM author WHERE create_time >= DATE(2024-01-01);
SELECT * FROM author WHERE create_time <= '2024-12-31' and create_time >= '1999-01-01';
SELECT * FROM author WHERE create_time between'2024-12-31' and '1999-01-01';


-- date_format
select * from author where date_format(create_time, '%Y-%m') from post;
-- date_format 활용 2024 데이터 조회
select * from author where date_format(create_time, '%Y') ='2024';


-- 현재 시간 알려주기
select now();

-- 흉부외과 또는 일반외과 의사 목록 출력하기
SELECT DR_NAME, DR_ID, MCDP_CD, date_format(HIRE_YMD, '%Y-%m-%d') as HIRE_YMD 
FROM DOCTOR WHERE MCDP_CD="CS" OR MCDP_CD = "GS" 
ORDER BY HIRE_YMD DESC, DR_NAME ASC


