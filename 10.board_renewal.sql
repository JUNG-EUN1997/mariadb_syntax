CREATE TABLE author (
    id bigint auto_increment,
    email varchar(255) not null,
    name varchar(255) DEFAULT NULL,
    password varchar(255),
    address_id bigint,
    create_time datetime default current_timestamp,
    
    primary key(id),
    unique(email)
);

create table post(
    id bigint auto_increment,
    title varchar(255) not null,
    primary key(id)
);

create table author_address(
    id bigint auto_increment,
    city varchar(255),
    street varchar(255),
    author_id bigint not null,

    primary key(id),
    primary key(author_id),
    unique(author_id),

    foreign key(author_id) references author(id) on delete cascade
);

create table author_post(
    id bigint auto_increment primary key,
    author_id bigint not null,
    post_id bigint not null,

    foreign key(author_id) references author(id) on delete cascade,
    foreign key(post_id) references post(id) on delete cascade
);




/*

-- 정보보기
show full columns from author;

-- 회원 정보 테이블
CREATE TABLE author (
    id bigint NOT NULL PRIMARY KEY auto_increment,
    name varchar(255) DEFAULT NULL,
    password varchar(255),
    address_id bigint,
    create_time datetime default current_timestamp,
    -- CONSTRAINT author_address_fk FOREIGN KEY (address_id) REFERENCES author_address (id) -- 순서상 사용불가
);
-- 나머지 table 완성 후 alert 사용 필요
alter table author add constraint author_address_fk foreign key(address_id) references author_address (id);


-- 회원 주소 테이블
CREATE TABLE author_address (
    id bigint NOT NULL PRIMARY KEY auto_increment,
    city varchar(255) DEFAULT NULL,
    street varchar(255) DEFAULT NULL,
    author_id bigint,
    create_time datetime default current_timestamp,

    CONSTRAINT address_author_fk FOREIGN KEY (author_id) REFERENCES author (id)
);
-- alter table author_address add constraint address_author_fk foreign key(author_id) references author (id);


-- 게시글 테이블
CREATE TABLE post (
    id bigint NOT NULL PRIMARY KEY auto_increment,
    title varchar(255) NOT NULL,
    contents varchar(3000) DEFAULT '',
    create_time datetime default current_timestamp
);

-- 회원 게시판 글쓰기 정보 테이블
CREATE TABLE author_post (
    id bigint NOT NULL PRIMARY KEY auto_increment,
    author_id bigint,
    post_id bigint,
    create_time datetime default current_timestamp,

    CONSTRAINT author_fk FOREIGN KEY (author_id) REFERENCES author (id), -- 유저 외래키
    CONSTRAINT post_fk FOREIGN KEY (post_id) REFERENCES post (id) -- 게시판 외래키

);
-- alter table author_post add constraint author_fk foreign key(author_id) references author (id);




*/


