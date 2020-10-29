--SQL server 2019 schemas
drop table Taco_Order_Tacos;
drop table Taco_Ingredients;
drop table Taco_Order;
drop table  Taco;
drop table Ingredient ;





create table Ingredient (
  id bigint identity(1,1) primary key,
  name varchar(25) not null,
  type varchar(10) not null
);


create table  Taco (
  id bigint identity(1,1) primary key,
  name varchar(50) not null,
  created_At timestamp not null
);

create table Taco_Ingredients (
  taco bigint not null primary key,
  ingredient bigint not null
);

alter table Taco_Ingredients
    add foreign key (taco) references Taco(id);
alter table Taco_Ingredients
    add foreign key (ingredient) references Ingredient(id);

create table Taco_Order (
	id bigint identity(1,1) primary key,
	delivery_name varchar(50) not null,
	delivery_state varchar(50) not null,
	delivery_city varchar(50) not null,
	delivery_street varchar(2) not null,
	delivery_zip varchar(10) not null,
	cc_number varchar(16) not null,
	cc_Expiration varchar(5) not null,
	ccCVV varchar(3) not null,
	user_id bigint,
    placed_at timestamp not null
);


create table Taco_Order_Tacos (
	tacoOrder bigint not null primary key,
	taco bigint not null
);

alter table Taco_Order_Tacos
    add foreign key (tacoOrder) references Taco_Order(id);
alter table Taco_Order_Tacos
    add foreign key (taco) references Taco(id);



--
-- Name: countries; Type: TABLE; Schema: public; Owner: -
--
drop  TABLE gambit_trace;
drop TABLE  gambit_results ;
drop TABLE games;
drop TABLE events;
drop TABLE leagues;
drop TABLE countries;



CREATE TABLE countries (
    nodeid BIGINT NOT NULL,
	name character varying(100),
    countrycode character varying(10),   
    priority integer
);


CREATE TABLE leagues (
    nodeid BIGINT NOT NULL,
    name character varying(200),
    priority integer,
    parentnodeid bigint
);


CREATE TABLE events (
    nodeid bigint NOT NULL,
    name character varying(200),
    startdate timestamp,
    priority integer,
    locked bit,
    statisticsid character varying(12),
    parentnodeid bigint
);


CREATE TABLE games (
  nodeid       bigint                 NOT NULL, 
  name         character varying(200)     NULL, 
  priority     integer                    NULL, 
  locked       bit                    NULL, 
  parentnodeid bigint                     NULL
);


CREATE TABLE  gambit_results (
  nodeid       bigint                      NOT NULL, 
  name         character varying(200)          NULL, 
  create_time   datetime2(6)     NULL, 
  odd          numeric(5,3)                    NULL, 
  priority     integer                         NULL, 
  locked       bit                         NULL, 
  parentnodeid bigint                          NULL
);


CREATE TABLE gambit_trace (
  nodeid       bigint                     NOT NULL, 
  create_time  datetime2(6)     NULL, 
  odd          numeric(5,3)                    NULL, 
  parentnodeid bigint                          NULL
);

ALTER TABLE countries
    ADD CONSTRAINT countries_pk PRIMARY KEY (nodeid);

ALTER TABLE leagues
    ADD CONSTRAINT leagues_pk PRIMARY KEY (nodeid);

ALTER TABLE leagues
    ADD CONSTRAINT leagues_parentnodeid_fkey FOREIGN KEY (parentnodeid) REFERENCES countries(nodeid);
	

ALTER TABLE events
    ADD CONSTRAINT events_pkey PRIMARY KEY (nodeid);

ALTER TABLE events
    ADD CONSTRAINT events_parentnodeid_fkey FOREIGN KEY (parentnodeid) REFERENCES leagues(nodeid);
	
ALTER TABLE games ADD
  CONSTRAINT game_pkey PRIMARY KEY ( nodeid );

ALTER TABLE games ADD
  CONSTRAINT game_parentnodeid_fkey FOREIGN KEY ( parentnodeid )
    REFERENCES events ( nodeid );	
	
ALTER TABLE gambit_results ADD
  CONSTRAINT gmt_reslts_pk PRIMARY KEY ( nodeid );

ALTER TABLE gambit_results ADD
  CONSTRAINT gambit_results_parentnodeid_fkey FOREIGN KEY ( parentnodeid )
    REFERENCES games ( nodeid );
	
ALTER TABLE gambit_trace ADD
  CONSTRAINT gambit_pkey PRIMARY KEY ( nodeid );

ALTER TABLE gambit_trace ADD
  CONSTRAINT gambit_parentnodeid_fkey FOREIGN KEY ( parentnodeid )
    REFERENCES gambit_results ( nodeid );
