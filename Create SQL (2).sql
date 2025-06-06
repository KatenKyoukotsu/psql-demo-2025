CREATE DATABASE "BsAll";

\c BsAll

CREATE TABLE IF NOT EXISTS Users(
	username VARCHAR(50) PRIMARY KEY,
	dbname VARCHAR(50) NOT NULL,
	user_password BYTEA NOT NULL
);

CREATE EXTENSION IF NOT EXISTS pgcrypto;

DO $$
DECLARE
	i INT := 1;
	user_name TEXT;
	db_name TEXT;
	random_password TEXT;
BEGIN
	WHILE i <= 14 LOOP
	user_name = 'user' || i;
	db_name = 'Bs' || i;
	
	random_password := substr(encode(gen_random_bytes(5), 'hex'), 1, 5);

	EXECUTE format('CREATE USER %I WITH PASSWORD %L', user_name, random_password);

	INSERT INTO Users(username, dbname, user_password)
	VALUES (user_name, db_name, convert_to(random_password, 'UTF8'));
	
	i := i + 1;
	END LOOP;
	
END $$;

CREATE DATABASE "Bs1" OWNER user1;
CREATE DATABASE "Bs2" OWNER user2;
CREATE DATABASE "Bs3" OWNER user3;
CREATE DATABASE "Bs4" OWNER user4;
CREATE DATABASE "Bs5" OWNER user5;
CREATE DATABASE "Bs6" OWNER user6;
CREATE DATABASE "Bs7" OWNER user7;
CREATE DATABASE "Bs8" OWNER user8;
CREATE DATABASE "Bs9" OWNER user9;
CREATE DATABASE "Bs10" OWNER user10;
CREATE DATABASE "Bs11" OWNER user11;
CREATE DATABASE "Bs12" OWNER user12;
CREATE DATABASE "Bs13" OWNER user13;
CREATE DATABASE "Bs14" OWNER user14;

SELECT username, dbname, convert_from(user_password, 'UTF8') AS decrypted_password FROM Users;