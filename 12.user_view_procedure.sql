-- 사용자관리
-- 사용자 목록 조회
select * from mysql.user;

/* -- user에 대한 설명
    localhost 
        - 내 PC, 내 IP를 의미함
        - 내 PC에서만 접속할 수 있다. 라는 것을 의미함. -> 원격접속을 하려는 linux 명령어 : ssh
    %
        - 원격을 포함한 anyware접속 의미
*/

-- 사용자 생성
create user 'test1'@'localhost' identified by '4321';

-- 사용자에게 SELECT 권한 부여
grant select on board.author to 'test1'@'localhost';
-- 사용자에게 SELECT 권한 회수
revoke select on board.author from 'test1'@'localhost';
-- 사용자 권한 확인
show grants for 'test1'@'localhost';
-- 환경설정을 변경 후 확정
flush privileges;

-- test1으로 로그인 후 확인
select * from board.author;

-- 사용자 계정 삭제
drop user 'test1'@'localhost';



-- ---------------------------------------------------------------------------------------



-- view
-- view 생성
create view author_for_marketing_team as
select name, age, role from author;

-- view에 select 권한부여!
grant select on board.author_for_marketing_team to 'test1'@'localhost';

-- view 변경(대체)
create or replace view board.author_for_marketing_team as
    select name, email, age, role from author;

-- view 삭제
DROP VIEW author_for_marketing_team;



-- ---------------------------------------------------------------------------------------



-- 프로시저 생성
DELIMITER //

CREATE PROCEDURE test_procedure()
BEGIN
    SELECT 'HELLO WORLD';
END

// DELIMITER ;


-- 프로시저 호출
call test_procedure();


-- 프로시저 삭제
DROP PROCEDURE test_procedure();


-- 게시글목록조회 프로시저 생성
DELIMITER //

CREATE PROCEDURE 게시글목록조회()
BEGIN
    SELECT * FROM post;
END

// DELIMITER ;
call 게시글목록조회();


-- 게시글단건조회 프로시저 생성
DELIMITER //

CREATE PROCEDURE 게시글단건조회(in 저자ID int, in 제목 varchar(255))
BEGIN
    SELECT * FROM post where id = 저자ID or title=제목;
END

// DELIMITER ;
call 게시글단건조회(3);


-- 게시글작성 프뢰저 생성
    -- 제목, contents, 저자ID
DELIMITER //

CREATE PROCEDURE 게시글작성(in 내용 varchar(3000), in 제목 varchar(255), in 저자ID int)
BEGIN
    INSERT INTO post(title, contents, author_id) VALUES(제목,내용,저자ID);
END

// DELIMITER ;
call 게시글작성('테스트','내용이당',1);


-- 변수 사용하기 및 활용하여 검색하기
DELIMITER //

CREATE PROCEDURE 글쓰기2(in contentsInput varchar(3000), in titleInput varchar(255), in emailInput varchar(255))
BEGIN
    declare authorId int;
    select id into authorId from author where email = emailInput;
    insert into post(title, contents, author_id) values(titleInput, contentsInput, authorId);
END

// DELIMITER ;


-- sql에서 문자열 합치는 concat('hello', 'world');
-- 글상세조회 : input 값이 postId
-- title, contents, '홍길동' + '님'
DELIMITER //

CREATE PROCEDURE 글상세조회2(in inputPostid int)
BEGIN
    declare authorId int;
    declare authorName varchar(255);
    -- set authorName = concat(authorName," 님");

    select author_id into authorId from post where id = inputPostid;
    select name into authorName from author where id = authorId;

    select title, contents, concat(authorName," 님") from post where id = inputPostid;
END

// DELIMITER ;


-- 등급조회
-- 글을 100개 이상 쓴 사용자는 고수입니다.
    -- 10개 이상, 100개 미만이면 중수입니다.
    -- 그 외에는 초보입니다.
-- input값 : email값.
DELIMITER //

CREATE PROCEDURE 등급조회(in emailInput varchar(255))
BEGIN
    declare authorId int;
    declare count int;
    select id into authorId from author where email=emailInput;
    select count(*) into count from post where author_id = authorId;

    IF count >= 100 THEN
	    select "고수입니다.";
    ELSEIF count > 10 THEN
	    select "중수입니다.";
    ELSE
        select "초보입니다.";
    END IF;
END

// DELIMITER ;


-- 반복문을 통한 post 대량 생성 > 매크로 프로그램
-- 사용자가 입력한 반복 횟수에 따라 글이 도배된다! title은 "안녕하세요"로 도배
DELIMITER //

CREATE PROCEDURE 글도배(in count int)
BEGIN
    declare i int default 0; -- 기본값 0으로 지정하기
    
    WHILE i < count DO
	    insert into post(title) values("안녕하세요");
        set i = i+1;
    END WHILE;
    
END

// DELIMITER ;



-- 프로시저 생성문 조회
show create procedure 글도배;

-- 프로시저 권한 부여
grant excute on board.글도배 to 'test1'@'localhost';


