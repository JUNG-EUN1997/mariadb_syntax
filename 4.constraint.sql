-- not null 조건 추가
alter table 테이블명 modify column 컬럼명 타입 not null;


-- auto_increment
alter table author modify column id bigint auto_increment; -- 실무에서는 서비스가 커질 것을 대비하기 때문에, bigint로 id를 설정하기도 함
alter table post modify column id bigint auto_increment;
-- 이 때, 참조하는 외래키인 경우 속성변경이 불가할 수 있다.


-- author.id에 제약조건 추가 시, fk로 인해 문제 발생 시,
-- fk 먼저 제거 이후에 author.id에 제약조건 추가
select * from information_schema.key_column_usage where table_name = 'post';
-- 삭제
alter table post drop foreign key post_ibfk_1;
-- 삭제된 제약조건 외래키 지정
alter table post add constraint post_author_fk foreign key(author_id) references author (id);


-- uuid : 거의 중복되지 않는 난수값
alter table post add column user_id char(36) default(UUID());
insert into post(title) values('immmmmmm titleeeeeeeee yeeee');


-- unique 제약조건
alter table author modify column email varchar(255) unique;


-- on delete cascade 테스트 -> 부모테이블의 아이디 수정 시 수정되지 않음
select * from information_schema.key_column_usage where table_name = 'post';
-- 삭제
alter table post drop foreign key post_author_fk;
-- 
ALTER TABLE post 
ADD CONSTRAINT post_author_fk 
FOREIGN KEY (author_id) REFERENCES author(id) 
ON DELETE CASCADE ON UPDATE CASCADE;


-- (실습) delete는 set null, update cascade
select * from information_schema.key_column_usage where table_name = 'post';
-- 삭제
alter table post drop foreign key post_author_fk;
-- 
ALTER TABLE post 
ADD CONSTRAINT post_author_fk 
FOREIGN KEY (author_id) REFERENCES author(id) 
ON DELETE set null ON UPDATE CASCADE;
