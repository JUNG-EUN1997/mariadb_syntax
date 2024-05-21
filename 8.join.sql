-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드(데이터)만 반환, on 조건을 통해 교집합 찾기
select * from post inner join author on author.id = post.author_id;
select * from author a inner join post p on a.id = p.author_id;


-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
select p.id, p.title, p.contents, a.email from post p inner join author a on p.author_id = a.id;

-- outer join >> left join
-- 모든 글목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력
select p.id, p.title, p.contents, a.email from post p left outer join author a on p.author_id = a.id;
select p.id, p.title, p.contents, a.email from post p left join author a on p.author_id = a.id; -- outer 문구 생략 가능


-- join된 상황에서의 where 조건 : on 뒤에 where 조건
-- 1) 글쓴이가 있는 글 중, 글의 title과 저자의 email 출력, 단. 나이는 25세 이상만 출력
select p.id, p.title, a.email, a.age 
from post p inner join author a 
on p.author_id = a.id 
and a.age >=25 
order by p.id;

-- 2) 모든 글 목록 중, 글의 title과 저자가 있다면 email 출력. 
-- 2024-05-01 이후에 만들어진 글만 출력
-- 이 경우에는, 글쓴이의 ID가 PK나 FK이기 때문에 ON JOIN 조건에 적합한 것!!!
-- TITLE은 유동적으로 변할 수 있고 PK나 FK도 아니기 때문에 ON 조건에 적합하지 않음!!
select p.id, p.author_id, p.title, p.create_time, a.email 
from post p left join author a 
on p.title is not null
and p.author_id = a.id -- 권장사항 X , on에는 조건만 명확히 진행, where절에 필터링 조건을 추가하는 것으로.
where p.create_time >= '2024-05-01'
order by p.id;

select p.id, p.author_id, p.title, p.create_time, a.email 
from post p left join author a 
on p.author_id = a.id
where p.title is not null
and p.create_time >= '2024-05-01'
order by p.id;

-- 조건에 맞는 도서와 저자 리스트 출력하기
SELECT B.BOOK_ID, A.AUTHOR_NAME, DATE_FORMAT(B.PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE
FROM BOOK B INNER JOIN AUTHOR A -- 혹은 LEFT JOIN 으로 해도 된다!! (이번 문제는)
ON B.AUTHOR_ID = A.AUTHOR_ID WHERE B.CATEGORY = '경제' ORDER BY B.PUBLISHED_DATE ASC;


-- union : 중복제외한 두 테이블의 select를 결합
-- ⭐"컬럼의 개수"와 "타입"이 같아야함에 유의 ⭐
-- union all : 중복포함
select 컬럼1, 컬럼2 from table1 union select 컬럼1, 컬럼2 from table2;

-- author테이블의 name, email 그리고 post테이블의 title, contents union
select name, email from author union select title, contents post;




-- 서브쿼리
-- : SELECT문 안에 또 다른 SELECT문을 서브쿼리라 한다.
-- : 성능이 떨어지니 남발하는 것이 좋지는 않다. 라고 교과서에 나와있다~~
-- : 대체할 수 있다면 JOIN을 하는 것이 좋다!

-- 1) SELECT 절 안에 서브쿼리
SELECT email, (SELECT count(*) FROM post p WHERE p.author_id = a.id) as count from author a;

-- 2) FROM 절 안에 서브쿼리
-- : 이 부분은 사실 좀 어거지
select a.name from (select * from author) as a;


-- 3) WHERE 절 안에 서브쿼리
select a.* from author a inner join post p on a.id = p.author_id;
select * from author where id in (select author_id from post);

-- 없어진 기록 찾기
-- 1) JOIN으로 풀기
SELECT AO.ANIMAL_ID, AO.NAME FROM ANIMAL_OUTS AO
LEFT JOIN ANIMAL_INS AI ON AI.ANIMAL_ID = AO.ANIMAL_ID 
WHERE AI.ANIMAL_ID IS NULL ORDER BY AI.ANIMAL_ID ASC;
-- 2) 서브쿼리로 풀기
SELECT ANIMAL_ID, NAME FROM ANIMAL_OUTS
WHERE ANIMAL_ID NOT IN(SELECT ANIMAL_ID FROM ANIMAL_INS)


-- 집계함수
select count(*) from author;
select sum(price) from post;
select round(avg(price), 0) from post;

-- group by와 집계함수
select author_id from post group by author_id;
select author_id, count(*) from post group by author_id;
select author_id, count(*), sum(price), round(avg(price), 0)  from post group by author_id;
select author_id, count(*), sum(price), round(avg(price), 0), min(price), max(price)  from post group by author_id;

-- 저자 email, 해당저자가 작성한 글 수를 출력
select a.id, if(p.id is null, 0, count(*)) from author a left join post p 
on a.id = p.author_id group by author_id order by a.id;

-- where와 group by
-- 연도별 post 글 출력, 연도가 null인 데이터는 제외
select DATE_FORMAT(create_time,'%Y') as year, count(*) from post  -- select문에서 사용한 별칭을
where create_time is not null group by year; -- group by에서도 이어서 사용 가능!

-- 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기
SELECT CAR_TYPE, COUNT(CAR_TYPE) AS CARS FROM CAR_RENTAL_COMPANY_CAR 
WHERE OPTIONS LIKE '%통풍시트%' OR OPTIONS LIKE '%열선시트%' OR OPTIONS LIKE '%가죽시트%'
GROUP BY CAR_TYPE ORDER BY CAR_TYPE;

-- 입양 시각 구하기(1)
SELECT cast(date_format(DATETIME,"%H") as unsigned) AS HOUR, COUNT(*) AS COUNT FROM ANIMAL_OUTS
WHERE date_format(DATETIME,"%H") >= 9 AND date_format(DATETIME,"%H") < 20
GROUP BY HOUR ORDER BY HOUR;


-- HAVING : group by를 통해 나온 통계에 대한 조건
select count(*) from post group by author_id;
-- 글을 2개이상 쓴 사람에 대한 통계정보
select author_id, count(*) as count from post -- 여기서 where을 넣으면 group by에 대한 값이 아닌, 전체 데이터에 대한 값.
group by author_id having count>=2;

-- (실습) 포스팅price가 2000원 이상인 글을 작성자별로 몇 건인지와, 
--        평균 price를 구하되 3000원 이상인 데이터를 대상으로만 통계 출력
select id, price, author_id from post group by author_id having price >= 2000;

select author_id, count(*), avg(price) as avg_prive from post 
where price >= 2000 group by author_id having avg_prive>=3000 order by author_id;


-- 동명 동물 수 찾기
SELECT NAME, COUNT(*) AS COUNT FROM ANIMAL_INS GROUP BY NAME
HAVING COUNT >= 2 AND NAME IS NOT NULL
ORDER BY NAME ASC;


-- (실습) 2건 이상의 글을 쓴 사람의 ID와 EMAIL을 구하고, 
--        나이는 25세 이상인 사람만 통계에 사용하며 가장 나이가 많은 사람 1명의 통계만 출력하시오
select p.author_id, a.email, a.age, count(*) as post_cnt from post p 
inner join author a on p.author_id = a.id where a.age >= 25 
group by author_id having MAX(a.age) and post_cnt >= 2 order by a.age desc limit 1;

select a.id, a.age, count(*) as count from author a inner join post p
on p.author_id = a.id 
where a.age >= 25 
group by a.id having count>=2 order by max(a.age) desc limit 1; -- 이게 MAC에 datagrip에서는 max가없으면 실행이안된당..


-- 다중열 group by
select author_id, title, count(*) from post -- count(*) 은 각각 1,2차로 그룹되어있는 총 개수를 의미함!
group by author_id, title -- author_id로 1차묶고 그 내부에서 title로 2차묶기!

-- 재구매가 일어난 상품과 회원 리스트 구하기
SELECT USER_ID, PRODUCT_ID 
FROM ONLINE_SALE GROUP BY USER_ID, PRODUCT_ID
HAVING COUNT(*) >= 2
ORDER BY USER_ID ASC, PRODUCT_ID DESC;



