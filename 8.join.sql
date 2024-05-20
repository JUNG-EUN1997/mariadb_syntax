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
select p.id, p.author_id, p.title, p.create_time, a.email 
from post p left join author a 
on p.title is not null
and p.author_id = a.id
where p.create_time >= '2024-05-01'
order by p.id;

