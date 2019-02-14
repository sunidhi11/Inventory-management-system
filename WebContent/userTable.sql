/**********************************************/

create table users
(
	user_id   varchar2(14) primary key,
	user_name varchar2(14) ,
	email     varchar2(14) ,	
	contact   number(14)   ,
	gender    varchar2(14) ,
	address   varchar2(30) ,
	password  varchar2(14) 
);

insert into users
(user_id,user_name,email,contact,gender,address,password)
values ('d_1','dhiraj kumar','dhiraj@g.com',9993250131,'male','DL-7,Agyeya Nagar','dhiraj@1');

###########################################

create table counters
(
	id          number(14), 
	user_count  number(14),
	item_count  number(14),
	order_count number(14)		
);

insert into counters
(id,user_count,item_count,order_count)
values (1,1,0,0);

update counters
set item_count = 1
where id = 1;

############################################

create table items
(
	item_id    varchar2(14) primary key,
	brand      varchar2(14) ,
	category   varchar2(14) ,	
	model_name varchar2(14) ,
	price      number(14) ,
	image      blob 	
);

insert into items
(item_id,brand,category,model_name,price,image)
values ('d_1','dhiraj kumar','dhiraj@g.com',9993250131,'male','DL-7,Agyeya Nagar','dhiraj@1');

#############################################
create table carts
(
	cart_id  varchar2(14) primary key,
	item_id  varchar2(14) ,
	add_date date ,
	add_time timestamp 	 
);


############################################
create table orders
(
	order_id   varchar2(14) primary key,
	user_id    varchar2(14),
	item_id    varchar2(14),		
	order_date date,
	order_time timestamp 	 
);
