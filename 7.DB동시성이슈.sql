-- dirty read 실습
-- 워크벤치에서 auto_commit 해제 후 update 실행 -> commit이 안된 상태.
-- 터미널에서 select 했을 때 위 변경사항이 변경되었는지 확인


-- phantom read 동시성 이슈 실습
-- 워크벤치에서 sleep 10초를 두고, 2번의 select 진행.
-- 10초 사이에 터미널에서 insert 진행 -> 2번째의 select 값이 첫번째 select값과 동일한지 확인
start transaction;
select count(*) from author;
do sleep(15);
select count(*) from author;
commit;

insert into author(name, email) values('kim444','kimm444@naver.com');


-- lost update 이슈를 해결하기위한 공유락(shared lock)
-- 워크벤치에서 아래 코드실행
start transaction;
select post_count from author where id=1 lock in share mode; -- 공유락(shared lock)
do sleep(15);
select post_count from author where id=1 lock in share mode; -- 해당 select문이 끝날 때 까지 아래 터미널 문의 update가 실행되면 안된다.
commit;
select post_count from author where id=1;


-- 터미널에서 진행
select post_count from author where id=1 lock in share mode;
update author set post_count=0 where id=1;


-- 배타적 잠금(exclusive lock) : select for update
-- select부터 lock
start transaction;
select post_count from author where id=1 for update; -- 공유락(shared lock)
do sleep(15);
select post_count from author where id=1 for update; -- 해당 select문이 끝날 때 까지 아래 터미널 문의 update가 실행되면 안된다.
commit;
select post_count from author where id=1;


-- 터미널에서 진행
select post_count from author where id=1 for update;
update author set post_count=100 where id=1;

