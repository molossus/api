DROP DATABASE bs_development;
CREATE DATABASE bs_development;
\c bs_development;

-- Execute all commands within a transaction...
BEGIN;

-- Core Configurations
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--
CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';

-- Post-PL/pgSQL Configuration
SET search_path = public, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
COMMENT ON EXTENSION "uuid-ossp" IS 'UUID Generation Framework';

--
-- TransactionStatus - State Machine
--
CREATE TABLE transaction_statuses (
	id integer PRIMARY KEY,
	name character varying NOT NULL CHECK (name <> ''),
	description text NOT NULL CHECK (description <> '')
);
CREATE SEQUENCE IF NOT EXISTS transaction_statuses_id_seq
	START WITH 1
	RESTART WITH 1
	INCREMENT BY 1
	NO MINVALUE
	NO MAXVALUE
	CACHE 1;
ALTER SEQUENCE transaction_statuses_id_seq OWNED BY transaction_statuses.id;

--
-- Transactions - Individual Line Item Entry Records
--
CREATE TABLE transactions (
	id integer PRIMARY KEY,
	name character varying NOT NULL CHECK (name <> ''),
	occurred_on date NOT NULL,
	status_id integer NOT NULL REFERENCES transaction_statuses (id),
	amount decimal(8,2) NOT NULL
);
CREATE SEQUENCE IF NOT EXISTS transactions_id_seq
	START WITH 10000000
	RESTART WITH 10000000
	INCREMENT BY 1
	NO MINVALUE
	NO MAXVALUE
	CACHE 1;
ALTER SEQUENCE transactions_id_seq OWNED BY transactions.id;

-- COMMIT TRANSACTION
COMMIT;