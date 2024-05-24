create table user (
    id int not null primary key auto_increment,
    user_level int,
    email varchar(255),
    password varchar(255),
    name varchar(255),
    phone varchar(13),
    birth date,
    gender varchar(1),
    address varchar(500),
    address_code varchar(6),
    is_check_optional_term varchar(1),
    memo varchar(5000),
    status varchar(1),
    resign_site_date datetime,
    is_login_sns datetime,  -- 대체가능여부 체크
    login_sns_last_type varchar(255), -- 대체가능여부 체크

    -- seller 전용 컬럼 시작
    e_id varchar(10),
    e_name varchar(255),
    e_address varchar(500),
    e_address_code varchar(6),
    e_email varchar(255),
    e_mail_order_sales_num varchar(15),
    -- seller 전용 컬럼 종료

    level_id int,
    cat_id int,
    e_cat_id int,

    last_access_date datetime,
    updated_date datetime default current_timestamp,
    created_date datetime default current_timestamp
);
-- level_id fk alert 추가 필요
-- cat_id fk alert 추가 필요 >> 사용자 입장의 흥미 카테고리
-- e_cat_id 추가 필요 >> 판매자의 카테고리


create table sns_login (
    id int not null primary key auto_increment,
    token varchar(500),
    user_id int not null,
    updated_date datetime default current_timestamp,
    created_date datetime default current_timestamp,

    CONSTRAINT sns_login_fk_1 FOREIGN KEY (user_id) REFERENCES user (id) ON UPDATE CASCADE
);

create table user_level (
    id int not null primary key auto_increment,
    level int not null unique,
    memo varchar(3000),
    updated_date datetime default current_timestamp,
    created_date datetime default current_timestamp
);

create table category (
    id int not null primary key auto_increment,
    name varchar(500)
    step int
);

create table product (
    id int not null primary key auto_increment,
    inventory_count int not null default 0,
    price int not null default 0,
    view int not null default 0,

    user_seller_id int not null,
    product_d_id int not null,
    category_id int,
    updated_date datetime default current_timestamp,
    created_date datetime default current_timestamp,

    CONSTRAINT user_seller_id_fk_1 FOREIGN KEY (user_seller_id) REFERENCES user (id) ON UPDATE CASCADE
    -- CONSTRAINT product_d_fk_1 FOREIGN KEY (product_d_id) REFERENCES product_detail (id) ON UPDATE CASCADE
    CONSTRAINT category_fk_1 FOREIGN KEY (category_id) REFERENCES category (id) ON DELETE set null ON UPDATE CASCADE
);

create table product_detail (
    id int not null primary key auto_increment,
    contents varchar(5000) default '',

    product_id int not null,
    updated_date datetime default current_timestamp,
    created_date datetime default current_timestamp,

    CONSTRAINT product_fk_1 FOREIGN KEY (product_id) REFERENCES product (id) ON UPDATE CASCADE
);


create table `order` (
    id int not null primary key auto_increment,
    order_uq_id varchar(500),
    invoice_num int, -- order detail이 없어서, 종합 order가 묶어서 배송보낼 때!

    user_order_id int not null,
    updated_date datetime default current_timestamp,
    created_date datetime default current_timestamp,

    CONSTRAINT order_fk_1 FOREIGN KEY (user_order_id) REFERENCES user (id) ON UPDATE CASCADE
);

create table order_detail (
    id int not null primary key auto_increment,
    price int not null default 0,
    invoice_num int,

    product_id int not null,
    order_id int not null ,
    updated_date datetime default current_timestamp,
    created_date datetime default current_timestamp,

    CONSTRAINT order_d_fk_1 FOREIGN KEY (product_id) REFERENCES product (id) ON UPDATE CASCADE,
    CONSTRAINT order_d_fk_2 FOREIGN KEY (order_id) REFERENCES `order` (id) ON UPDATE CASCADE
);


-- user 테이블 수정 필요
    -- level_id fk alert 추가 필요
    -- interest_cat_id fk alert 추가 필요 >> 사용자 입장의 흥미 카테고리
    -- e_cat_id 추가 필요 >> 판매자의 카테고리

alter table user add constraint user_level_fk_1 foreign key(level_id) references user_level (id) ON DELETE set null ON UPDATE CASCADE;
alter table user add constraint user_category_fk_1 foreign key(cat_id) references category (id) ON DELETE set null ON UPDATE CASCADE;
alter table user add constraint user_category_fk_2 foreign key(e_cat_id) references category (id) ON DELETE set null ON UPDATE CASCADE;


-- product 테이블 수정 필요
    -- CONSTRAINT product_d_fk_1 FOREIGN KEY (product_d_id) REFERENCES product_detail (id) ON UPDATE CASCADE
alter table product add constraint product_d_fk_1 foreign key(product_d_id) references product_detail (id) ON UPDATE CASCADE;


-- ---------------------------------------------------------------------------

create table complaint (
    id int not null primary key auto_increment,
    type int not null, -- 배송, 상품불량, 기타 등
    status int not null, -- 해결여부
    
    product_id int not null,
    order_detail_id int not null,
    admin_user_id int not null,
    
    updated_date datetime default current_timestamp,
    created_date datetime default current_timestamp,
    
    CONSTRAINT complaint_fk_1 FOREIGN KEY (product_id) REFERENCES product (id) ON UPDATE CASCADE,
    CONSTRAINT complaint_fk_2 FOREIGN KEY (order_detail_id) REFERENCES order_detail (id) ON UPDATE CASCADE,
    CONSTRAINT complaint_fk_3 FOREIGN KEY (admin_user_id) REFERENCES user (id) ON UPDATE CASCADE
);