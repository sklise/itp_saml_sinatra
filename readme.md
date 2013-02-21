# Omniauth SAML and ITP

To run this application you need to create a file in this directory named `.env` and put in the following

    PORT=9393
    IDP_CERT="SOME CERTIFICATE YOU GOT FROM THE SYSTEM ADMINISTRATOR WITH NEW LINES REPLACED WITH \n"

Also, you'll need Ruby 1.9.3, install it using [rvm](http://rvm.io)

Then in Terminal:

    $ gem install foreman
    $ gem install bundler
    $ bundler install
    $ foreman start

Finally, visit http://localhost:9393 and click the link. Enter your netid and password and click submit.

The application will look for a user with a matching netid and first and last name and if not found will create a new user.