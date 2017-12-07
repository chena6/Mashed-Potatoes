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

create sequence comment_id_seq;
create sequence review_id_seq;
create sequence user_id_seq;

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

commit;


