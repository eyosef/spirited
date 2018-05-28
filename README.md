# SPIRITED - README

This Rails app makes API calls to the LCBO(Liquor Control Board of Ontario) API to access store and product information.
Feel free to create an account with this rails app and submit product reviews, as well as access store information
that ranges from hours of operation to whether or not staff are multilingual.

## Ruby version

This rails app was created with ruby version 2.3.3

## Configuration

* Fork and clone this repo 
* Run `bundle install` 
* In the termal, run the app by entering `rails s`
* In the browser, enter `http://localhost:3000/welcome`
* Feel free to create an account or signin through Github
* Once you have logged in, you will be able to access stores and products from the LCBO API (so there is no need to run `rake db:migrate` or `rake db:seed`)

## Services (Features of this Rails App)

Users can: 
* login/logout
* create an account
* edit their account
* signin with Github(this app uses oauth, not Devise)
* access a list of Canadian store (and info including hours, accessibility via transportation, etc)
* access a list of products sold by each store 
* access all user reviews 
* publish a product/store review 
* edit store reviews
* delete store reviews

## Contributors Guide 

* To file an issue, open a new issue from your existing pull request in the browser
* Click `Issues` and then `New issue`
* If you have noticed multiple issue types, click `Get started`
* Enter the title & description for your issue
* click submit a new issue 

## License 

* This project has been licensed under the MIT open source license.