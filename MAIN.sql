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
	id uuid default uuid_generate_v4() PRIMARY KEY,
	name character varying NOT NULL CHECK (name <> ''),
	description text NOT NULL CHECK (description <> ''),
	active boolean NOT NULL DEFAULT true
);

--
-- Transactions - Individual Line Item Entry Records
--
CREATE TYPE transaction_type AS ENUM ('debit', 'credit');
CREATE TABLE transactions (
	id uuid default uuid_generate_v4() PRIMARY KEY,
	name character varying NOT NULL CHECK (name <> ''),
	occurred_on date NOT NULL,
	transaction_status_id uuid NOT NULL REFERENCES transaction_statuses (id),
	type transaction_type NOT NULL,
	amount decimal(8,2) NOT NULL
);

--
-- Tags - Categorical Grouping of Saved Funds
--
CREATE TABLE tags (
	id uuid default uuid_generate_v4() PRIMARY KEY,
	name character varying NOT NULL CHECK (name <> ''),
	description text NOT NULL CHECK (description <> ''),
	active boolean NOT NULL DEFAULT true
);

--
-- Goals -
--
CREATE TABLE goals (
	id uuid default uuid_generate_v4() PRIMARY KEY,
	name character varying NOT NULL CHECK (name <> ''),
	description text NOT NULL CHECK (description <> ''),
	due_date date NOT NULL CHECK (due_date >= CURRENT_DATE),
	tag_id uuid NOT NULL REFERENCES tags (id)
);

-- COMMIT TRANSACTION
COMMIT;
