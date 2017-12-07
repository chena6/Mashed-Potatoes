/************************************************************************
   Drop database if it exists
************************************************************************/
DROP USER mashed CASCADE;


/************************************************************************
   Create database
************************************************************************/
CREATE USER mashed
IDENTIFIED BY p4ssw0rd
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA 10M ON users;

GRANT connect to mashed;
GRANT resource to mashed;
GRANT create session TO mashed;
GRANT create table TO mashed;
GRANT create view TO mashed;
GRANT create sequence TO mashed;



conn mashed/p4ssw0rd

/******************************************************************************
	TABLE CREATION
******************************************************************************/

CREATE TABLE USERS 
(
  USER_ID INTEGER NOT NULL 
, EMAIL VARCHAR2(60) NOT NULL 
, USERNAME VARCHAR2(20) NOT NULL 
, PASSWORD VARCHAR2(20) NOT NULL 
, FIRSTNAME VARCHAR2(20) NOT NULL 
, LASTNAME VARCHAR2(20) NOT NULL 
, ROLE_ID VARCHAR2(20) NOT NULL
);

CREATE TABLE MOVIES 
(
  MOVIE_ID VARCHAR2(20) NOT NULL 
, TITLE VARCHAR2(100) NOT NULL 
, DIRECTOR NUMBER
, YEAR INTEGER 
, RATING NUMBER 
, RUNTIME VARCHAR2(20) 
, PLOT VARCHAR2(300) 
, POSTER VARCHAR2(200)
);

CREATE TABLE MOVIE_ACTOR 
(
  MOVIE_ID VARCHAR2(20) NOT NULL 
, ACTOR_ID INTEGER NOT NULL 
);

CREATE TABLE MOVIE_GENRE
(
  MOVIE_ID VARCHAR2(20) NOT NULL 
, GENRE_ID INTEGER NOT NULL 
);


CREATE TABLE ACTORS
(
    ACTOR_ID INTEGER NOT NULL
,   FIRSTNAME VARCHAR(20) NOT NULL
,   LASTNAME VARCHAR(20) NOT NULL
);

CREATE TABLE DIRECTORS 
(
  DIRECTOR_ID INTEGER NOT NULL 
, FIRSTNAME VARCHAR2(20) NOT NULL 
, LASTNAME VARCHAR2(20) NOT NULL 
);

CREATE TABLE REVIEWS 
(
  REVIEW_ID INTEGER NOT NULL
, USER_ID INTEGER NOT NULL
, MOVIE_ID VARCHAR2(20) NOT NULL
, REVIEW VARCHAR2(300) NOT NULL
);

CREATE TABLE USER_BACKLOG 
(
  USER_ID INTEGER NOT NULL 
, MOVIE_ID VARCHAR2(20) NOT NULL 
);

CREATE TABLE USER_WATCHED 
(
  USER_ID INTEGER NOT NULL 
, MOVIE_ID VARCHAR2(20) NOT NULL 
);

CREATE TABLE GENRES 
(
  GENRE_ID INTEGER NOT NULL 
, GENRE VARCHAR(20) NOT NULL 
);

CREATE TABLE COMMENTS 
(
  COMMENT_ID INTEGER NOT NULL 
, USER_ID INTEGER NOT NULL 
, MOVIE_iD INTEGER NOT NULL
, COMMENTS VARCHAR2(300) NOT NULL
);

CREATE TABLE RATINGS
(
  RATING_ID INTEGER NOT NULL
, RATING VARCHAR2(8) NOT NULL
);


/******************************************************************************
	PRIMARY KEYS
******************************************************************************/

alter table "USERS" add constraint USERS_PK primary key("USER_ID");
alter table "MOVIES" add constraint MOVIE_PK primary key("MOVIE_ID");
alter table "MOVIE_ACTOR" add constraint MOVIEACTOR_PK primary key("ACTOR_ID","MOVIE_ID");
alter table "ACTORS" add constraint ACTOR_PK primary key("ACTOR_ID"); 
alter table "MOVIE_GENRE" add constraint MOVIEGENRE_PK primary key("MOVIE_ID","GENRE_ID");
alter table "DIRECTORS" add constraint DIRECTORS_PK primary key("DIRECTOR_ID");
alter table "REVIEWS" add constraint REVIEWS_PK primary key("REVIEW_ID");
alter table "USER_BACKLOG" add constraint USER_BACKLOG_PK primary key("USER_ID","MOVIE_ID");
alter table "USER_WATCHED" add constraint USER_WATCHED_PK primary key("USER_ID","MOVIE_ID");
alter table "GENRES" add constraint GENRES_PK primary key("GENRE_ID");
alter table "COMMENTS" add constraint COMMENTS_PK primary key("COMMENT_ID");
alter table "RATINGS" add constraint RATINGS_PK primary key("RATING_ID");

/*****************************************************************************
	FOREIGN KEYS
*****************************************************************************/

alter table "MOVIES" add constraint MOVIE_RATING_FK foreign key("RATING") references "RATINGS"("RATING_ID");
alter table "MOVIE_ACTOR" add constraint MOVIE_ACTOR_MOVIE_FK foreign key("MOVIE_ID") references "MOVIES"("MOVIE_ID");
alter table "MOVIE_ACTOR" add constraint MOVIE_ACTOR_ACTOR_FK foreign key("ACTOR_ID") references "ACTORS"("ACTOR_ID");
alter table "MOVIE_GENRE" add constraint MOVIE_GENRE_MOVIE_FK foreign key("MOVIE_ID") references "MOVIES"("MOVIE_ID");
alter table "MOVIE_GENRE" add constraint MOVIE_GENRE_GENRE_FK foreign key("GENRE_ID") references "GENRES"("GENRE_ID");
alter table "USER_BACKLOG" add constraint USER_BACKLOG_USER_FK foreign key("USER_ID") references "USERS"("USER_ID");
alter table "USER_BACKLOG" add constraint USER_BACKLOG_MOVIE_FK foreign key("MOVIE_ID") references "MOVIES"("MOVIE_ID");
alter table "REVIEWS" add constraint REVIEWS_USER_FK foreign key("USER_ID") references "USERS"("USER_ID");
alter table "REVIEWS" add constraint REVIEWS_MOVIE_FK foreign key("MOVIE_ID") references "MOVIES"("MOVIE_ID");
alter table "USER_WATCHED" add constraint USER_WATCHED_USER_FK foreign key("USER_ID") references "USERS"("USER_ID");
alter table "USER_WATCHED" add constraint USER_WATCHED_MOVIE_FK foreign key("MOVIE_ID") references "MOVIES"("MOVIE_ID");
alter table "COMMENTS" add constraint COMMENTS_USER_FK foreign key("USER_ID") references "USERS"("USER_ID");


/*****************************************************************************
	TRIGGERD!!!!!
******************************************************************************/

create sequence backlog_id_seq;
create sequence comment_id_seq;
create sequence review_id_seq;
create sequence user_id_seq;
create sequence watched_id_seq;

create or replace trigger backlog_id_trig
before insert or update on backlog
for each row
begin
    if inserting then 
        select backlog_id_seq.nextVal into :new.backlog_id from dual;
    elsif updating then
        select :old.backlog_id into :new.backlog_id from dual;
    end if;
end;
/

create or replace trigger comment_id_trig
before insert or update on comments
for each row
begin
    if inserting then 
        select comment_id_seq.nextVal into :new.comment_id from dual;
    elsif updating then
        select :old.comment_id into :new.comment_id from dual;
    end if;
end;
/

create or replace trigger review_id_trig
before insert or update on reviews
for each row
begin
    if inserting then 
        select review_id_seq.nextVal into :new.review_id from dual;
    elsif updating then
        select :old.review_id into :new.review_id from dual;
    end if;
end;
/

create or replace trigger user_id_trig
before insert or update on users
for each row
begin
    if inserting then 
        select user_id_seq.nextVal into :new.user_id from dual;
    elsif updating then
        select :old.user_id into :new.user_id from dual;
    end if;
end;
/

create or replace trigger watched_id_trig
before insert or update on watched
for each row
begin
    if inserting then 
        select watched_id_seq.nextVal into :new.watched_id from dual;
    elsif updating then
        select :old.watched_id into :new.watched_id from dual;
    end if;
end;
/

/*****************************************************************************
INSERTS
****************************************************************************/

/*****************************************************************************
GENRES
*****************************************************************************/

INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (4, 'N/A');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (9, 'MUSIC');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (14, 'THRILLER');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (6, 'BIOGRAPHY');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (5, 'DRAMA');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (20, 'SCI-FI');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (22, 'SPORT');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (13, 'CRIME');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (1, 'REALITY-TV');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (10, 'ANIMATION');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (7, 'COMEDY');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (8, 'TALK-SHOW');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (21, 'WAR');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (23, 'ADVENTURE');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (2, 'DOCUMENTARY');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (16, 'ADULT');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (3, 'SHORT');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (11, 'FAMILY');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (12, 'ACTION');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (19, 'ROMANCE');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (15, 'FANTASY');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (17, 'NEWS');
INSERT INTO genres (GENRE_ID, GENRE) 
	VALUES (18, 'GAME-SHOW');

/****************************************************************************
ACTORS
**************************************************************************/

INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (49, 'Laverne', 'Cox');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (92, 'Héctor', 'Larrea');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (181, 'Kevin', 'Markwell');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (84, 'Morgan', 'Reigns');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (71, 'Jenna', 'Presley');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (62, 'Justin', 'Briggs');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (83, 'Enrique', 'Pinti');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (87, 'Bailey', 'Brooks');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (64, 'Melissa', 'Bayer');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (94, 'Rubén', 'Juárez');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (53, 'Lee', 'Pace');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (58, 'Matías', 'Martin');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (154, 'Will', 'Brittain');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (124, 'Natalia', 'Lobo');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (98, 'Roberto', 'Pettinato');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (41, 'McKinley', 'Freeman');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (158, 'Sigrid', 'Alegría');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (57, 'Jonathan', 'Burkhardt');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (76, 'Brooke', 'Belle');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (134, 'Alvin', 'Jones');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (151, 'Nate', 'Donaldson');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (82, 'Araceli', 'González');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (216, 'Elaine', 'Chu');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (103, 'Moira', 'Gough');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (18, 'John', 'Doyle');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (68, 'Jennifer', 'White');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (40, 'Raha', 'Lewis');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (96, 'Guy', 'Fieri');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (110, 'Juan', 'Alberto');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (180, 'Konnor', 'Dyer');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (75, 'Sandy', 'McCutcheon');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (48, 'Paula', 'Pell');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (63, 'Phil', 'Baumhardt');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (43, 'Josh', 'Meyers');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (147, 'Eva', 'Cotton');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (22, 'Craig', 'Ferguson');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (120, 'Narendra', 'Gupta');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (148, 'Jennifer', 'Cotton');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (122, 'Ajay', 'Nagrath');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (6, 'Sachin', 'Joab');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (159, '�?lvaro', 'Espinoza');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (192, 'Al', 'Sharpton');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (152, 'Saro', 'Solis');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (184, 'Alexa', 'Castillo');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (208, 'Mike', 'Barnes');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (191, 'Eric', 'Braeden');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (203, 'Ruth', 'Reynolds');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (205, 'Bettina', 'Skye');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (194, 'E.J.', 'Dionne');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (171, 'Christie', 'Brinkley');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (20, 'Leo', 'McKern');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (66, 'Cassidy', 'Morgan');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (145, 'Ellie', 'Hahn');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (74, 'Stephanie', 'Duchaine');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (130, 'Bebe', 'Sanzo');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (29, 'Gert', 'Voss');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (123, 'Damián', 'de');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (114, 'Daniela', ' ');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (131, 'Katja', 'Alemann');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (157, 'Cristian', 'Gonzalez');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (30, 'Kumud', 'Pant');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (143, 'Riley', 'Rydin');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (32, 'Jan', 'Dolanský');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (178, 'Jeevan', ' ');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (65, 'Charles', 'Irving');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (50, 'Chris', 'Pratt');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (117, 'Lasse', 'Pöysti');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (207, 'Lionel', 'Antoine');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (16, 'Vanessa', 'Riddell');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (101, 'Carlos', 'Monti');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (99, 'Karina', 'Mazzocco');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (24, 'Simon', 'Pegg');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (218, 'Zoe', 'Saldana');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (172, 'Jessica', 'Gomes');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (196, 'Anisha', 'Adusumilli');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (160, 'Paulo', 'Brunetti');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (136, 'Vahina', 'Giocante');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (95, 'Laura', 'Miller');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (108, 'Zane', 'Caplansky');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (91, 'Humberto', 'Martins');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (67, 'Emma', 'Heart');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (69, 'Audrianna', 'Angel');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (77, 'Madelyn', 'Marie');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (109, 'Leo', 'Montero');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (13, 'Jono', 'Pryor');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (209, 'Maxie', 'Baughan');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (81, 'Catherine', 'Fulop');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (141, 'Tanya', 'Christiansen');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (144, 'Trinity', 'Scott');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (3, 'N/A', ' ');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (44, 'Joan', 'Rivers');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (156, 'Rosie', 'Darch');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (2, 'Josie', 'Le');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (5, 'Scott', 'Cartmill');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (210, 'Bill', 'Belichick');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (170, 'Jeffrey', 'Johnson');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (198, 'Alison', 'Becker');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (188, 'Meredith', 'Baxter');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (28, 'Peter', 'Simonischek');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (15, 'Toni', 'Potter');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (9, 'Stefan', 'Hunstein');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (33, 'Erika', 'Deutschova');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (162, 'Jon', 'Bailey');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (166, 'Timothy', 'J.');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (213, 'Levin', 'O''Connor');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (118, 'Gunvor', 'Sandkvist');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (35, 'Kristýna', 'Frejová');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (201, 'Anastasios', 'Tasos');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (73, 'Melissa', 'Matthews');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (4, 'Clemence', 'Gossett');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (54, 'Paris', 'Hilton');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (19, 'Deborah', 'Kennedy');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (121, 'Gaurav', 'Khanna');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (21, 'Peter', 'O''Brien');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (86, 'Mae', 'Victoria');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (153, 'Frank', 'Zapata');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (8, 'Josh', 'Saks');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (135, 'Damien', 'Bonnard');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (31, 'Ker', 'Milan');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (197, 'Lauralee', 'Bell');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (132, 'Héctor', 'Alterio');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (138, 'Sean', 'Bartram');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (37, 'Porscha', 'Coleman');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (142, 'Nathan', 'Marlow');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (212, 'Tracy', 'Meyer');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (214, 'Mike', 'Betette');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (204, 'Rick', 'Cordeiro');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (56, 'Steve', 'Guttenberg');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (189, 'Peter', 'Bergman');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (190, 'J.', 'Paul');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (161, 'Carolina', 'Varleta');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (89, 'Bruna', 'Marquezine');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (167, 'Caitlin', 'Johnston');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (90, 'Gabriel', 'Braga');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (206, 'Paul', 'Marshall');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (27, 'Tiffanie', 'Mang');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (174, 'Hannah', 'Davis');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (97, 'Gerry', 'Garvin');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (72, 'Lana', 'Violet');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (51, 'Scott', 'Aukerman');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (187, 'Matthew', 'Atkinson');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (119, 'Janvi', 'Chheda');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (173, 'Christine', 'Teigen');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (175, 'Patrick', 'McIntyre');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (79, 'Aryan', 'Astyn');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (182, 'Kurt', 'Markwell');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (177, 'Aruna', 'Irani');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (60, 'Alfredo', 'Alcón');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (45, 'Rixton', ' ');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (193, 'Midwin', 'Charles');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (26, 'Josh', 'Wolf');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (61, 'Matías', 'Ale');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (80, 'Jorge', 'Guinzburg');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (128, 'Flavia', 'Palmiero');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (88, 'Júlia', 'Lemmertz');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (105, 'Danny', 'Boome');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (150, 'Kwakoe', 'Amoelibi');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (211, 'Bryce', 'Wissel');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (42, 'Seth', 'Meyers');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (100, 'Liliana', 'López');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (179, 'Prithviraj', 'Kapoor');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (139, 'Jeffery', 'Boos');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (70, 'Lexi', 'Belle');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (107, 'David', 'Rocco');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (183, 'Gerardo', 'Albarrán');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (219, 'Dave', 'Bautista');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (133, 'Arnaldo', 'André');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (202, 'Mickey', 'Cardoni');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (23, 'Jamie', 'Chung');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (17, 'Genevieve', 'Riutort');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (106, 'Daryn', 'Jones');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (137, 'Rodolphe', 'Pauly');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (38, 'AJ', 'Gibson');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (14, 'Michael', 'Hurst');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (140, 'Eric', 'Castle');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (199, 'Stephen', 'Chang');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (164, 'Billie', 'Jo');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (217, 'Brenna', 'Lampson');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (126, 'Elina', 'Salo');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (102, 'Néstor', 'Fabián');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (10, 'Nobert', 'Beilharz');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (112, 'Jazmín', 'Rodríguez');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (163, 'Mihingarangi', 'Forbes');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (46, 'Ethan', 'Hawke');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (125, 'Melina', 'Petriella');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (155, 'Judy', 'Chan');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (129, 'Viviana', 'Sáez');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (1, 'Laura', 'Avery');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (12, 'Thomas', 'Bernhard');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (47, 'Megyn', 'Kelly');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (52, 'Maggie', 'Gyllenhaal');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (55, 'Alicia', 'Malone');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (146, 'Alexis', 'Anderson');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (215, 'Courtney', 'Barnett');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (165, 'Jennifer', 'Ward-Lealand');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (34, 'Helena', 'Dvoráková');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (59, 'Yayo', 'Guridi');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (7, 'Emily', 'O''Meara');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (186, 'Armando', 'Zamarripa');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (169, 'Jack', 'Horton');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (85, 'Velvet', 'Licx');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (11, 'Maria', 'Asamer');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (78, 'Carolyn', 'Reese');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (185, 'Aleyda', 'Gallardo');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (36, 'Kristen', 'Brockman');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (93, 'Daniel', 'Agostini');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (195, 'Audra', 'McDonald');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (113, 'Pablo', 'Codevila');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (116, 'Tove', 'Jansson');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (168, 'Michael', 'Rehse');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (104, 'Jairo', ' ');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (200, 'Michael', 'Chapman');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (25, 'Olivia', 'Williams');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (220, 'Vin', 'Diesel');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (115, 'Bo', 'Andersson');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (111, 'Panam', ' ');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (127, 'Osvaldo', 'Laport');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (176, 'Helen', ' ');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (39, 'Jonathan', 'Hyla');
INSERT INTO actors (ACTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (149, 'JP', 'DeStefano');

/***************************************************************************
DIRECTORS
**************************************************************************/

INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (5, 'Ron', 'Krauss');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (14, 'Zdenek', 'Viktora');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (20, 'Celia', 'Tait');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (31, 'Sean', 'Murray');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (2, 'N/A', ' ');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (1, 'Kenneth', 'Hinegardner');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (38, 'Paul', 'Bounds');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (40, 'James', 'Gunn');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (26, 'Rodolphe', 'Pauly');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (6, 'Blake', 'Bradford');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (36, 'Conal', 'O''Brien');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (3, 'Hugh', 'Piper');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (16, 'Shannon', 'Walden,');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (35, 'Casey', 'Childs');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (22, 'Jayme', 'Monjardim,');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (32, 'Andy', 'Signore');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (19, 'Peter', 'Butt');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (29, 'Don', 'Okolo');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (33, 'Babubhai', 'Mistri');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (4, 'Nobert', 'Beilharz');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (23, 'Carl', 'Mesterton');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (17, 'Jonathan', 'Burkhardt');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (39, 'Ethan', 'Cushing');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (13, 'Carlo', 'Fiorio');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (28, 'Dwight', 'Thompson');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (18, 'Jake', 'Bowen');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (7, 'Ian', 'Munro');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (37, 'Michael', 'Eilbaum');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (8, 'Tim', 'Mancinelli');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (15, 'Holly', 'Pearson');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (24, 'Siba', 'Mishra,');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (9, 'Tiffanie', 'Mang');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (12, 'Kumud', 'Pant');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (10, 'Matthias', 'Kopfmüller,');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (25, 'Leena', 'Paavonen');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (11, 'Sandra', 'Marchart');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (30, 'Kyle', 'Smithers');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (34, 'Christian', 'González');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (27, 'Austin', 'McKinley');
INSERT INTO DIRECTORS (DIRECTOR_ID, FIRSTNAME, LASTNAME) 
	VALUES (21, 'Kangpin', ' ');

/***************************************************************************
RATINGS
***************************************************************************/

INSERT INTO RATINGS (RATING_ID, RATING) 
	VALUES (4, 'PG-13');
INSERT INTO RATINGS (RATING_ID, RATING) 
	VALUES (1, 'N/A');
INSERT INTO RATINGS (RATING_ID, RATING) 
	VALUES (3, 'X');
INSERT INTO RATINGS (RATING_ID, RATING) 
	VALUES (2, 'TV-14');

/*****************************************************************************
MOVIES
*****************************************************************************/

INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896448', 'Episode #2.2', 2014, 1, 'N/A', 1, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896446', 'Bajo la capucha: yo tapo mi cara, tú tapas la realidad', 2014, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896444', 'Episode #2.1', 2014, 1, 'N/A', 1, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3895152', '#DUPE#', 2014, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896440', 'The Post', 1999, 1, 5, 3, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896438', 'In Between', 2014, 1, 1, 2, 'Three 20 something College kids spend a weekend in the Mexican tourist town of Ensenada. What begins as a good natured party soon turns sinister when two threatening strangers enter the ...', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896436', 'Thomas Bernhard - Die Kunstnaturkatastrophe', 2011, 1, 5, 4, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896434', 'Sir Butch', 2010, 1, 2, 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896432', 'Mother of the Street', 2015, 1, 'N/A', 5, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896430', 'Episode #2.10', 2014, 1, 'N/A', 6, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896428', 'Federation', 1999, 1, 16, 7, 'N/A', 'http://ia.media-imdb.com/images/M/MV5BOTBiM2YwYmQtN2MxYy00ZTA3LWFiODUtMGVlZmYwZDVkNDgzXkEyXkFqcGdeQXVyNjYxMjQwNzg@._V1_SX300.jpg');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896426', 'Episode #2.9', 2014, 1, 'N/A', 6, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896422', 'Episode #2.8', 2014, 1, 'N/A', 6, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896418', 'Episode #2.7', 2014, 1, 'N/A', 6, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896416', 'Simon Pegg/Jamie Chung', 2014, 2, 4, 8, 'Simon Pegg; Jamie Chung.', 'http://ia.media-imdb.com/images/M/MV5BMTcyMjIwNzM0Ml5BMl5BanBnXkFtZTcwNDAxNjgwNA@@._V1_SX300.jpg');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896414', 'Olivia Williams/Josh Wolf', 2014, 2, 4, 8, 'Olivia Williams; comedian Josh Wolf.', 'http://ia.media-imdb.com/images/M/MV5BMTcyMjIwNzM0Ml5BMl5BanBnXkFtZTcwNDAxNjgwNA@@._V1_SX300.jpg');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896410', 'Emile', 2014, 1, 'N/A', 9, 'A blind beggar boy sitting in the streets loses his one coin and sets out to find it, only to discover a trail of music that leads him to something more magical than he could ever imagine.', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896408', 'Episode #2.6', 2014, 1, 'N/A', 6, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896404', 'Episode #2.5', 2014, 1, 'N/A', 6, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896402', 'Episode #2.4', 2014, 1, 'N/A', 6, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896400', 'Episode #2.3', 2014, 1, 'N/A', 6, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896398', 'Unbekannte Tiefen - Vom Harz bis zur Nordsee', 2014, 1, 4, 10, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896396', 'Der Briefwechsel', 2010, 1, 6, 11, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896394', 'Episode #2.2', 2014, 1, 'N/A', 6, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896392', 'Episode #2.1', 2014, 1, 'N/A', 6, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896388', 'Who Knows Tomorrow', 2015, 1, 'N/A', 12, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896386', 'Strides', 2013, 1, 'N/A', 13, 'The film''s narrative revolves around a man''s pursuit of happiness despite his inability to communicate correctly with others, and what he will do to replace that need.', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896384', 'Raluca', 2014, 1, 'N/A', 14, 'Former cop Filip Marold (Jan Dolanský) doesn''t want to be reminded of some things from his past. But others remind him... He works as a private detective, sleeps with his secretary and ...', 'https://images-na.ssl-images-amazon.com/images/M/MV5BMDNmMDY3NDctYjc2Ni00MGE3LTk2ZTYtMDE3ODcxNTU5OTJkXkEyXkFqcGdeQXVyMjIxMzMyMQ@@._V1_SX300.jpg');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896382', 'Alex Newell', 2014, 1, 'N/A', 15, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896380', 'Amy Paffrath/Sam Saboura/J. August Richards', 2014, 1, 'N/A', 15, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896378', 'Keke Palmer/McKinley Freeman', 2014, 1, 'N/A', 15, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896376', 'Joan Rivers/Josh Meyers/Rixton', 2014, 1, 'N/A', 2, 'Joan Rivers; Josh Meyers. Also: Rixton performs.', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896374', 'Ethan Hawke/Megyn Kelly/Paula Pell', 2014, 1, 'N/A', 2, 'Ethan Hawke; Megyn Kelly; Paula Pell.', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896372', 'Chris Pratt/Laverne Cox/Big Data ' || chr(38) || ' Joywave', 2014, 1, 'N/A', 2, 'Chris Pratt; Laverne Cox. Also: Big Data and Joywave perform.', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896368', 'Maggie Gyllenhaal/Lee Pace/Scott Aukerman', 2014, 2, 6, 2, 'Maggie Gyllenhaal (River of Fundament (2014)); Lee Pace (Guardians of the Galaxy (2014)); Scott Aukerman.', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896366', 'Paris Hilton/Judy Reyes', 2014, 1, 'N/A', 15, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896364', 'Weird Al Yankovic/Adam Korson', 2014, 1, 'N/A', 16, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896362', 'The Color Orange-', 2009, 2, 1, 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896360', 'Larenz Tate', 2014, 1, 'N/A', 15, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896358', 'Steve Guttenberg/Nicky Whelan', 2014, 1, 'N/A', 15, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896356', 'Global Agenda', 2014, 1, 1, 17, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896352', 'Episode dated 3 May 2005', 2005, 1, 6, 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896350', 'Talion', 2014, 1, 10, 18, 'In a gothic setting, a detective uses a mysterious machine to solve one of the Century''s most difficult cases.', 'http://ia.media-imdb.com/images/M/MV5BMTAxOTkwMjc3MDZeQTJeQWpwZ15BbWU4MDYxMzA1NDIx._V1_SX300.jpg');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896348', 'Bendy Broads', 2011, 3, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3893476', '#DUPE#', 2014, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896340', '2 Rods 1 Broad 2', 2011, 3, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896338', 'Inside Jessica Simpson''s Wedding', 2014, 1, 'N/A', 2, 'Jessica Simpson shares her real life fairytale wedding, Jimmy Fallon opens up about his unique workout routine. Plus, grab the s''mores - because we have some of the best summer camp movie moments.', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896336', 'Lies, Spies and Olympics', 1999, 1, 5, 19, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896334', '2 Rods 1 Broad', 2010, 3, 8, 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896332', 'Belinda''s Baby', 1998, 1, 5, 20, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896330', 'Episode dated 7 April 2000', 2000, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896328', 'Bang My Step Mom', 2009, 3, 22, 21, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896326', 'Episode #1.143', 2014, 1, 'N/A', 22, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896324', 'Episode dated 7 January 2000', 2000, 1, 6, 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896322', 'From Standards to Standouts', 2014, 1, 3, 2, 'Guys eats Mexican food, including savory chicken sopes and posole, in Jackson, Wyoming; and, accompanied by G. Garvin, visits an authentic Italian joint known for its tricolor cannelloni and fresh seafood cioppino in Carmel, California.', 'http://ia.media-imdb.com/images/M/MV5BMjgwNjg0MjU2Nl5BMl5BanBnXkFtZTgwOTQ5MTg5MjE@._V1_SX300.jpg');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896320', 'Episode dated 4 January 2000', 2000, 1, 6, 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896318', 'Episode #1.10', 2013, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896316', 'Episode dated 28 January 2000', 2000, 1, 6, 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896314', 'New York City', 2014, 1, 2, 2, 'Making donuts using pizza toppings.', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896310', 'Episode dated 26 January 2000', 2000, 1, 6, 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896308', 'Episode dated 25 January 2000', 2000, 1, 6, 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896306', 'Det finns så många saker man kan inte förstå', 1970, 1, 4, 23, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896304', 'Raaz Jungle Ke Bhoot Ka', 2014, 1, 'N/A', 24, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896302', 'Episode dated 9 June 2000', 2000, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896300', 'Tove ja meri', 1984, 1, 3, 25, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896298', 'Best of "In Depth"', 2008, 1, 6, 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896296', 'Episode dated 27 August 1999', 1999, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896294', 'Episode #2.6', 2013, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896292', 'Planet Vehicle', 2010, 1, 3, 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896290', 'The Ballad of Billy the Kid', 2013, 1, 2, 26, 'Billy The Kid crosses the Wild West to his heroic and tragic destiny. Despite the love of Maria and his desire to become an honest farmer, the betrayal of his friend Pat Garrett motivates him to avenge the deaths of his family.', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896288', 'Caster''s Blog', 2014, 1, 'N/A', 27, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896286', 'Caught Inside', 2014, 1, 1, 28, 'A driven man relentlessly pursues possessions and pleasure to rise above his impoverished boyhood. But soon his life spirals out of control and he reaches a dramatic turning point. He ...', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896284', 'Pound of Flesh', 2015, 1, 14, 29, 'On their way home from the concert, an accident happens and Nelo is trapped in the family''s burning car. She dies from a single gunshot - But, how?', 'https://images-na.ssl-images-amazon.com/images/M/MV5BMTYzMDY3MDEwNF5BMl5BanBnXkFtZTgwNjcxNzU0MjE@._V1_SX300.jpg');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896280', 'Mom', 2014, 1, 'N/A', 30, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896278', '25 ' || chr(38) || ' Counting', 2015, 1, 3, 2, 'Two cousins have both turned 25-years-old and are experiencing a Quarter-Life crisis.', 'http://ia.media-imdb.com/images/M/MV5BOTE2ODcwMjI1MF5BMl5BanBnXkFtZTgwMTU4NjY5NTE@._V1_SX300.jpg');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896276', 'The Lion King', 2014, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896274', 'Top Gun', 2014, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896272', 'Hablar de más', 2014, 1, 6, 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896270', 'Alice in Wonderland', 2014, 1, 'N/A', 2, '"Maleficent" is just the latest live-action fairy tale Disney reboot. Fall down the rabbit hole once again with "Alice in Wonderland," visionary Tim Burton''s not-so-visionary take on the classic story.', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896268', 'The X-Men Trilogy', 2014, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896266', 'Godzilla (1998)', 2014, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896264', 'Star Wars: Episode 2 - Attack of the Clones', 2014, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896262', 'Episode dated 21 July 2014', 2014, 1, 6, 2, 'Segment: Profile of Jennifer Ward-Lealand, with focus on her study of Te Reo Maori.', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896260', 'The Wolf of Wall Street', 2014, 1, 'N/A', 2, 'Relive the excessive profanity, lengthy runtime, and bad behavior of Martin Scorsese''s The Wolf of Wall Street.', 'http://ia.media-imdb.com/images/M/MV5BNGJkMTM0NGQtMjEwMS00NjZmLWI4ODctYzcwZjY4NTc5ODBkXkEyXkFqcGdeQXVyNjE4Njk5NTM@._V1_SX300.jpg');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896258', 'The Spider-Man Trilogy', 2014, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896256', 'Captain America: The First Avenger', 2014, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896254', 'Space Qats: The Big Tease', 2012, 1, 'N/A', 31, 'Space Qats follows the misadventures of three spacefaring felines marooned far from their home planet of Meowth. A gun toting Seargent, a plucky Science Officer, and a Captain who''s lost ...', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896250', 'Game of Thrones', 2014, 1, 'N/A', 32, 'The return of "Game of Thrones" is upon us! Watch as we break down the most perfect mix of history, D' || chr(38) || 'D, and porn ever made!! PLUS, for the first time ever, we are offering this Honest ...', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896248', 'Inside Job', 2014, 1, 'N/A', 2, 'A new series that puts executive job candidates through a unique screening process while being spied upon by a company insider.', 'https://images-na.ssl-images-amazon.com/images/M/MV5BMjE0MDQyODM0M15BMl5BanBnXkFtZTgwNTkzMTU2NTE@._V1_SX300.jpg');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896246', 'Safety in Paradise', 2014, 1, 'N/A', 2, 'Models from the Sports Illustrated swimsuit issue and residents of Cook Islands demonstrate airline safety, without actually being on an airplane.', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896244', 'Man University', 2014, 1, 'N/A', 2, 'Host Patrick McIntyre teaches men everywhere the basic skills needed to lead a masculine life. How to shave, tie a tie, grill a steak, etc. At Man U, you''ll learn all things manly.', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3127816', '#DUPE#', 2013, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896240', 'Shamsheer', 1967, 1, 'N/A', 33, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896238', 'Vemma Link', 2014, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896236', 'Me salió... ¡Cabrón!', 2002, 1, 'N/A', 34, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896234', 'Episode #1.10492', 2014, 2, 6, 35, 'N/A', 'http://ia.media-imdb.com/images/M/MV5BMTYyNzAyNzMyNV5BMl5BanBnXkFtZTgwNzYxNzA2MjE@._V1_SX300.jpg');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896232', 'Episode #1.10493', 2014, 2, 6, 36, 'N/A', 'http://ia.media-imdb.com/images/M/MV5BMTYyNzAyNzMyNV5BMl5BanBnXkFtZTgwNzYxNzA2MjE@._V1_SX300.jpg');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3113872', '#DUPE#', 2013, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896228', 'Episode dated 25 July 2014', 2014, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896226', 'Episode #1.10502', 2014, 2, 6, 37, 'N/A', 'http://ia.media-imdb.com/images/M/MV5BMTYyNzAyNzMyNV5BMl5BanBnXkFtZTgwNzYxNzA2MjE@._V1_SX300.jpg');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896222', 'Street Talk with Alison Becker', 2014, 1, 'N/A', 2, 'Comedian Alison Becker runs up to random people on the street to put them on the spot. Becker asks funny, ridiculous and occasionally uncomfortable questions, forcing her subjects to answer on camera with nowhere to hide.', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896220', 'Blood: The Ghosts of War', 2016, 1, 13, 2, 'Sentenced to death a former G.I undergoes months of physical and psychological torture after he is captured during a black ops assassination mission. Civilized war hero''s become animals in their desperation for survival. Rated-X', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896218', 'Flowers in the Snow', 2015, 1, 12, 38, 'A Feature Film Presentation dedicated to curbing senseless shootings, stabbings, bullying and other forms of youth violence, workplace violence, and lifestyle violence.', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896216', 'Bachelors vs. Bachelorettes', 2014, 1, 4, 2, 'N/A', 'http://ia.media-imdb.com/images/M/MV5BMjAyMTA5OTkzNV5BMl5BanBnXkFtZTcwNTU0NjE4MQ@@._V1_SX300.jpg');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896214', 'Fulton County, GA: Blood Orange', 2014, 1, 'N/A', 2, 'A 13-year old gang member visits a prison in Georgia.', 'http://ia.media-imdb.com/images/M/MV5BMzE4ODU1MzI2MF5BMl5BanBnXkFtZTgwNTIxNDE4MDE@._V1_SX300.jpg');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896212', 'Baltimore Colts vs. Chicago Bears', 1975, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896210', 'Mark Twain Hates Photocopying', 2013, 1, 'N/A', 39, 'Mark Twain tries to use reverse psychology on his coworker to get out of making photocopies. It doesn''t work.', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896208', 'Mark Twain Gives a Presentation', 2013, 1, 'N/A', 39, 'Mark Twain gives a presentation with a great cliff hanger!', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896206', 'Huffington Post Interviews Mark Twain', 2014, 1, 'N/A', 39, 'Mark Twain is on a mission to reclaim his fame and an interview with the Huffington Post is probably the way to do it! How will Mark Twain respond to a headline hungry HuffPo blogger? Will he even know what a blog is?', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896202', 'Locked and Loaded', 2014, 1, 'N/A', 2, 'N/A', 'N/A');
INSERT INTO movies (movie_id, title, year, rating, runtime, director, plot, poster) 
	VALUES ('tt3896198', 'Guardians of the Galaxy Vol. 2', 2017, 4, 13, 40, 'The Guardians must fight to keep their newfound family together as they unravel the mystery of Peter Quill''s true parentage.', 'https://images-na.ssl-images-amazon.com/images/M/MV5BMTg2MzI1MTg3OF5BMl5BanBnXkFtZTgwNTU3NDA2MTI@._V1_SX300.jpg');

/***************************************************************************
MOVIE GENRE JUNCTION TABLE
***************************************************************************/

INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896448', 1);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896446', 2);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896446', 3);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896444', 1);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3895152', 4);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896440', 2);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896438', 5);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896436', 2);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896436', 6);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896434', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896432', 2);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896430', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896428', 2);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896426', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896422', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896418', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896416', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896416', 9);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896416', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896414', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896414', 9);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896414', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896410', 10);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896410', 3);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896410', 11);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896408', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896404', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896402', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896400', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896398', 2);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896396', 4);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896394', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896392', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896388', 12);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896386', 3);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896386', 5);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896384', 13);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896384', 5);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896384', 14);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896382', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896380', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896378', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896376', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896376', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896374', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896374', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896372', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896372', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896368', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896368', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896366', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896364', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896362', 10);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896360', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896358', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896356', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896352', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896350', 13);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896350', 5);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896350', 15);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896348', 16);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3893476', 4);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896340', 16);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896338', 17);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896336', 2);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896334', 16);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896332', 2);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896330', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896328', 16);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896326', 12);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896326', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896326', 5);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896324', 11);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896324', 18);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896322', 1);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896320', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896318', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896316', 11);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896316', 18);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896314', 1);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896310', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896308', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896306', 4);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896304', 13);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896304', 5);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896302', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896300', 4);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896298', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896296', 8);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896294', 6);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896292', 1);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896290', 3);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896288', 3);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896286', 3);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896286', 5);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896284', 5);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896280', 3);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896280', 5);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896278', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896278', 19);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896276', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896274', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896272', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896272', 5);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896270', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896268', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896266', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896264', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896262', 17);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896260', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896258', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896256', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896254', 3);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896254', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896254', 20);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896250', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896248', 1);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896246', 3);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896244', 4);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3127816', 4);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896240', 12);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896238', 1);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896236', 5);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896234', 5);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896232', 5);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3113872', 4);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896228', 17);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896226', 5);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896222', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896220', 21);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896218', 12);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896218', 5);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896216', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896216', 18);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896216', 1);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896214', 1);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896212', 22);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896210', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896208', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896206', 7);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896202', 18);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896198', 12);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896198', 23);
INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) 
	VALUES ('tt3896198', 20);

/****************************************************************************
MOVIE ACTOR JUNCTION TABLE
****************************************************************************/

INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896448', 1);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896448', 2);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896446', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896444', 1);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896444', 4);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3895152', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896440', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896438', 5);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896438', 6);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896438', 7);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896438', 8);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896436', 9);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896436', 10);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896436', 11);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896436', 12);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896434', 13);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896434', 14);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896434', 15);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896434', 16);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896432', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896430', 17);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896428', 18);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896428', 19);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896428', 20);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896428', 21);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896426', 17);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896422', 17);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896418', 17);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896416', 22);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896416', 23);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896416', 24);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896414', 22);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896414', 25);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896414', 26);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896410', 27);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896408', 17);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896404', 17);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896402', 17);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896400', 17);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896398', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896396', 28);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896396', 29);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896394', 17);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896392', 17);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896388', 30);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896386', 31);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896384', 32);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896384', 33);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896384', 34);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896384', 35);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896382', 36);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896382', 37);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896382', 38);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896382', 39);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896380', 36);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896380', 37);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896380', 38);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896380', 40);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896378', 36);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896378', 37);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896378', 41);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896378', 38);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896376', 42);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896376', 43);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896376', 44);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896376', 45);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896374', 42);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896374', 46);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896374', 47);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896374', 48);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896372', 42);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896372', 49);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896372', 50);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896368', 42);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896368', 51);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896368', 52);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896368', 53);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896366', 36);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896366', 37);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896366', 38);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896366', 54);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896364', 36);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896364', 37);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896364', 38);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896364', 39);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896362', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896360', 36);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896360', 37);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896360', 38);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896360', 55);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896358', 36);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896358', 37);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896358', 38);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896358', 56);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896356', 57);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896352', 58);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896352', 59);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896352', 60);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896352', 61);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896350', 62);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896350', 63);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896350', 64);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896350', 65);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896348', 66);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896348', 67);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896348', 68);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896348', 69);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3893476', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896340', 70);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896340', 71);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896340', 72);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896340', 73);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896338', 74);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896336', 75);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896334', 76);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896334', 77);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896334', 78);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896334', 79);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896332', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896330', 80);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896330', 81);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896330', 82);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896330', 83);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896328', 84);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896328', 85);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896328', 86);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896328', 87);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896326', 88);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896326', 89);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896326', 90);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896326', 91);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896324', 92);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896324', 93);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896324', 94);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896324', 95);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896322', 96);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896322', 97);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896320', 98);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896320', 99);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896320', 100);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896320', 101);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896318', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896316', 92);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896316', 102);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896316', 103);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896316', 104);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896314', 105);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896314', 106);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896314', 107);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896314', 108);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896310', 109);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896310', 110);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896310', 111);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896310', 112);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896308', 98);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896308', 99);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896308', 113);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896308', 114);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896306', 115);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896306', 116);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896306', 117);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896306', 118);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896304', 119);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896304', 120);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896304', 121);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896304', 122);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896302', 80);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896302', 123);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896302', 124);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896302', 125);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896300', 126);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896300', 116);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896298', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896296', 80);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896296', 127);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896296', 128);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896296', 129);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896294', 130);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896294', 131);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896294', 132);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896294', 133);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896292', 134);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896290', 135);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896290', 136);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896290', 137);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896288', 138);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896288', 139);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896288', 140);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896288', 141);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896286', 142);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896286', 143);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896286', 144);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896286', 145);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896284', 146);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896284', 147);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896284', 148);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896284', 149);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896280', 150);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896280', 151);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896280', 152);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896280', 153);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896278', 154);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896278', 155);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896278', 156);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896278', 157);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896276', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896274', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896272', 158);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896272', 159);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896272', 160);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896272', 161);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896270', 162);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896268', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896266', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896264', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896262', 163);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896262', 164);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896262', 165);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896260', 162);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896258', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896256', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896254', 166);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896254', 167);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896254', 168);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896254', 169);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896250', 162);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896248', 170);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896246', 171);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896246', 172);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896246', 173);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896246', 174);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896244', 175);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3127816', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896240', 176);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896240', 177);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896240', 178);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896240', 179);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896238', 180);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896238', 181);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896238', 182);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896236', 183);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896236', 184);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896236', 185);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896236', 186);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896234', 187);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896234', 188);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896234', 189);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896234', 190);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896232', 188);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896232', 189);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896232', 190);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896232', 191);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3113872', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896228', 192);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896228', 193);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896228', 194);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896228', 195);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896226', 196);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896226', 187);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896226', 197);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896226', 190);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896222', 198);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896220', 199);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896220', 200);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896220', 201);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896220', 202);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896218', 203);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896218', 204);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896218', 205);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896218', 206);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896216', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896214', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896212', 207);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896212', 208);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896212', 209);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896212', 210);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896210', 211);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896210', 175);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896210', 212);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896208', 211);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896208', 212);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896208', 213);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896208', 214);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896206', 211);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896206', 215);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896206', 216);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896206', 217);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896202', 3);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896198', 50);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896198', 218);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896198', 219);
INSERT INTO MOVIE_ACTOR (MOVIE_ID, ACTOR_ID) 
	VALUES ('tt3896198', 220);

commit;