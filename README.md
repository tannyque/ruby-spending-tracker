# Spending Tracker App

## Info
Trello board at https://trello.com/b/cuYq4gas/spending-tracker

## Up and running

To get the app running locally, clone down the repo then:

```bash
cd spending-tracker
create_db spending-tracker-4567
bundle install
rake db:build
rake db:seed
ruby app.rb
```
