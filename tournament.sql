-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


-- Delete any existing database with name tournament
DROP DATABASE IF EXISTS tournament;

-- Let's start now!!!!

-- Creates a new database named tournament
CREATE DATABASE tournament;

-- Before going on further
-- First connect to the database tournament
\connect tournament


-- Write these commands only if you are in database tournament and you
-- have any pre tables or views
DROP TABLE IF EXISTS players CASCADE;
DROP TABLE IF EXISTS matches CASCADE;
DROP VIEW IF EXISTS standings CASCADE;


-- Creates a table named players with id and name as columns
-- id is primary key
CREATE TABLE players(
  id SERIAL PRIMARY KEY,
  name VARCHAR(25) NOT NULL
);


-- Creates a table named players with id, winner and loser as columns
-- id is primary key
CREATE TABLE matches(
  id SERIAL PRIMARY KEY,
  winner INT REFERENCES players(id),
  loser INT REFERENCES players(id)
);


-- Creates a view named standings of played matches sorted by wins
CREATE VIEW standings AS
  SELECT players.id, players.name,
  (SELECT count(*) FROM matches WHERE matches.winner = players.id) as wins,
  (SELECT count(*) FROM matches WHERE players.id in (winner, loser)) as played
  FROM players
  GROUP BY players.id
  ORDER BY wins DESC;
