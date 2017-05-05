# Volunteer Tracker

#### _**A site to create and update projects and volunteers.**_

#### _**By Tyler Stephenson, May 5, 2017**_

## Description
This site is designed for a Non Profit organization to track its projects and volunteers.

## Specifications

* As a non-profit employee, I want to view, add, update and delete projects.
* As a non-profit employee, I want to view, add, update and delete volunteers.
* As a non-profit employee, I want to add volunteers to a project.

## Setup/Installation Requirements

* clone the git repository
* navigate to the directory in your terminal
* run psql
* run the following commands to create the database and tables 
* CREATE DATABASE volunteer_tracker;
* \c volunteer_tracker;
* CREATE TABLE projects (id serial PRIMARY KEY, name varchar);
* CREATE TABLE volunteers (id serial PRIMARY KEY, name varchar, hours int, project_id int);
* CREATE DATABASE volunteer_tracker_test WITH TEMPLATE volunteer_tracker;
* In a new terminal run 
* ruby app.rb
* Open localhost:4567 in chrome.

## Known Bugs
_Add hours path is not flushed out_

## Support and Contact details
* Tyler Stephenson
* ilduchea@gmail.com

## Technologies Used

* HTML5
* CSS3
* Bootstrap
* Ruby
* Sinatra

### License

*This is web page is licensed under the MIT License.*

Copyright (c) 2017 **Tyler Stephenson**