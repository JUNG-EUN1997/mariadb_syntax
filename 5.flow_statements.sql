-- 흐름제어 : case문 -> IF문을 추가하고자 함
-- 문법
SELECT 컬럼1, 컬럼2, 컬럼3,
    CASE 컬럼4
        WHEN 비교값1 THEN 결과값1
        WHEN 비교값2 THEN 결과값2
        ELSE 결과값3
    END
FROM 테이블명;

-- 예시) post 테이블에서 1번유저는 first author, 2번 user는 second author
SELECT id, title, contents,
    CASE author_id
        WHEN 1 THEN 'first author'
        WHEN 2 THEN 'second author'
        ELSE 'others'
    END as 'author_id'
FROM post;

-- 예시) author_id가 있으면 그대로, 없으면 익명사용자 로 출력되도록 post테이블 조회
SELECT id, title, contents,
    CASE
        WHEN author_id is null THEN '익명사용자'
        ELSE author_id
    END as 'author_id'
FROM post;

-- 위 구문을 IFNULL문으로 변형하기
SELECT id, title, contents, 
    IFNULL(author_id, '익명사용자') AS 'author_id' 
FROM post;

-- 위 구문을 IF문으로 변형하기
SELECT  id, title, contents, 
	IF(author_id is null, '익명사용자', author_id) 
AS 'author_id' FROM post;

-- 조건에 부합하는 중고거래 상태 조회하기 (프로그래머스)
SELECT BOARD_ID, WRITER_ID, TITLE, PRICE, 
    CASE STATUS
        WHEN 'SALE' THEN '판매중' -- WHEN STATUS = 'SALE' THEN '판매중' 이런식으로 위에 STATUS를 빼고 WHEN 뒤에 작성해도 된다!
        WHEN 'RESERVED' THEN '예약중'
        WHEN 'DONE' THEN '거래완료'
        ELSE STATUS
    END as 'STATUS'
FROM USED_GOODS_BOARD 
WHERE CREATED_DATE = DATE('2022-10-05') 
ORDER BY BOARD_ID DESC;

-- 12세 이하인 여자 환자 목록 출력하기 (프로그래머스)
SELECT PT_NAME, PT_NO, GEND_CD, AGE, IFNULL(TLNO,'NONE') 
FROM PATIENT
WHERE GEND_CD = 'W' AND AGE <= 12
ORDER BY AGE DESC, PT_NAME ASC;

