use miniWebsite

=============================================================
create table item
(
	id int identity(1,1) primary key,
	name varchar(50) not null,
	price decimal(10,2) not null,
	date_added datetime default GETDATE()
);
==============================================================

create table userAccount
(
	id int identity(1,1) primary key,
	first_name varchar(50) not null,
	last_name varchar(50),
	email varchar(50) not null,
	password varchar(200) not null,
	isManager bit not null default 0
)

===============================================================
create table inventory
(
	id int identity(1,1) primary key,
	item int not null,
	quantity int not null,
	foreign key(item) references item(id),
	check (quantity >= 0)
) 
=================================================================
create table itemOrder
(
	id int identity(1,1) primary key,
	userAccount int not null,
	item int not null,
	quantity int not null,
	orderDate datetime default GETDATE(),
	deliveryAddress varchar(200) not null,
	isProcessed bit not null default 0,
	foreign key(userAccount) references userAccount(id),
	foreign key(item) references item(id),
	check (quantity > 0)
)
=======================================================================

