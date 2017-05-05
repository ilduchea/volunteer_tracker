CREATE DATABASE volunteer_tracker;
\c volunteer_tracker;
CREATE TABLE projects (id serial PRIMARY KEY, name varchar);
CREATE TABLE volunteers (id serial PRIMARY KEY, name varchar, hours int, project_id int);
CREATE DATABASE volunteer_tracker_test WITH TEMPLATE volunteer_tracker;