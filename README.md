Time Tracker
====================

Now that we know how to add user authentication to our apps, let's create an app
for multiple users. Today we'll be creating a time tracking app, so that we can
keep track of how productive we're being about our time.



### Release 1: Generate the Models

First let's create the user model, so that we have a record type that we can
use to authenticate. Create the user model in `/models/user.rb`. Make sure that
they have a secure password. Generate a migration for the user that includes an
email address, password, and both first and last names. Create the DB and
migrate it.

Next let's create the main business record for our app. If we're tracking our
time, what should we call this record? Generically, it's an "entry" of some
sort, but that name is pretty generic and difficult to work with. We're tracking
"hours", but not every entry is going to be for multiple hours, so that name
doesn't make sense either. Getting names right is important when we design our
software: when we pick bad names, everything else in our system ends up being
slightly wrong, and the effects compound quickly.

Since we can't come up with a good name that's both descriptive and concise,
let's drop the concission. Create a model called `WorkSession`. Add it to the
models directory and generate a migration for it. Our work session should have
a date, a duration (in hours, but we should allow partial hours), a
description, a relevant user, and a boolean field as to whether our time is
billable.

We shouldn't bill our reddit time to clients.

Also remember to associate the `User` model to the `WorkSession` model using
ActiveRecord associations.

### Release 2: Authentication

Before we go any further, let's build authentication. Here are the test stubs
from today's lesson to help guide your implementation:

  ```ruby
  describe "GET /register" do
    xit "renders the registration form"
  end

  describe "POST /register" do
    xit "creates a new user"
    xit "redirects to the login page"
    xit "includes a nice message when we get to login"
    xit "re-renders the form and returns a different status code if there were errors"
  end

  describe "GET /login" do
    xit "renders the login form"
  end

  describe "POST /login" do
    xit "persists the user session"
    xit "redirects to the homepage when successful"
    xit "shows the login form again when unsuccessful, with a different status code"
  end

  describe "GET /logout" do
    xit "eliminates our session"
  end
  ```

### Release 3: CRUD for Working Sessions

Next we need to build our actual tracking. Though technically we could add all
the routes under `/working_sessions/new` etc etc, verbose links can be a pain
to work with. Instead, just add the entries under `/sessions`.

We're not providing the test stubs this time, so try to build the CRUD
controller from what you remember for each action. If you need, you can refer
back to previous days for hints on what requirements are needed for each route.
Remember to include complete error handling and useful flash messages for the
user. Whenever you're dealing with `WorkingSession` objects, try to chain off
of `current_user` to prevent security issues.

Also remember that if a user isn't authenticated, then visiting any of the
pages under `/sessions` should result in being redirected to the login page.

### Release 4: Other Views of the Data

It's fine and all to be able to view every record in the system, but let's give
users other ways to look at their data. Create a search form at the top of the
list route that lets a user pick a start and end date for records. Also provide
a select option to view only billable or non-billable entries.  When submitted,
filter the data from your collection to only include the relevant data.

Once you complete that, let's create a summary view of that same data. Provide
a checkbox in the search form that summarizes data by week. The data should
look something like this:

  ```text
  Week    | S   | M   | T   | W   | R   | F   | S   |
  ---------------------------------------------------
  Mar 29  | 10  | 5   | 0   | 4.4 | 20  | 10  | 5   |
  Feb 05  | 2.5 | 1   | 0   | 25  | 99  | 3   | 3   |
  ... etc ...
  ```

  
# time-tracker
