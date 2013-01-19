# Omniauth SAML and ITP

To run this application you need to create a file in this directory named `.env` and put in the following

    PORT=9393
    IDP_CERT="SOME CERTIFICATE YOU GOT FROM THE SYSTEM ADMINISTRATOR WITH NEW LINES REPLACED WITH \n"

Then in Terminal:

    $ gem install foreman
    $ gem install bundler
    $ bundler install
    $ foreman start

Finally, visit http://localhost:9393 and click the link. Enter your netid and password and click submit.

This should work.