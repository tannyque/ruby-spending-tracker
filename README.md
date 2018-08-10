# Spending Tracker App

## Info
Visit the live version of the app at https://spending-tracker-app.herokuapp.com/

Trello board at https://trello.com/b/cuYq4gas/spending-tracker

## Up and running

To get the app running locally, clone down the repo then:

```bash
cd spending-tracker
create_db spending-tracker
bundle install
rake db:build
rake db:seed
ruby app.rb
```
