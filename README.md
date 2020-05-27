# Overview
A website to expose and manage the Broward Table Tennis Club

# Features completed
- User Sign up and Sign in
- Expose Contact information in Home Page
- Allow to reserve tables
- Email Confirmations for reservations
- Create roles for User, Coach, and Admin

# Features TODO (not in order of priority):
- Expose upcoming events
- Expose Club's Coaches and Team information
- Improve UI
- Reservations for Private Lessons with coaches
- Registrations for Upcoming Tournaments
- Manage Friday Night League
- ...
 

# How run locally
#### Pre-requisites
- Ruby v2.5.1  (use rvm to install and manage these)
- Rails v5.0.0
- Enabled SMTP server for sending emails

#### Necessary Environment variables
- GMAIL_USERNAME : Using gmail free smtp server, needs your account creds 
- GMAIL_PASSWORD : For the password, instead of regular account pass, you 
need one specifically for apps. [Learn how to here][1]    

#### Run rails app
- On the terminal navigate to app folder and run:
- `$ bundle install` : installs all library dependencies
- `$ rails db:create` : sets up the database in the configured db server 
(specified in config/database.yml)
- `$ rails db:migrate` : runs migrations on db
- `$ rails server` : starts server

###

# Tech Stack
- Ruby on Rails (ruby 2.5.1, rails 5.0)
- SQLite database
- Bootstrap 4 (UI library)
- Devise (gem for user management)



[1]: https://support.google.com/accounts/answer/185833?hl=en
