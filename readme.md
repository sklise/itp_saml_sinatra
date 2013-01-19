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

This should work.

Response:

    {"provider"=>"saml",
      "uid"=>"SOME HASH",
      "info"=>
      {"name"=>nil,
       "email"=>"_____@nyu.edu",
       "first_name"=>nil,
       "last_name"=>nil},
      "credentials"=>{},
      "extra"=>
      {"raw_info"=>
        {"eduPersonAffiliation"=>"_____",
         "telephoneNumber"=>"_____",
         "eduPersonPrimaryAffiliation"=>"_____",
         "mailAllowedServiceAccess"=>"+imap, http:*",
         "nyustatus"=>"current",
         "sn"=>"LAST_NAME",
         "homeUnixUid"=>"_____",
         "homeAccountEligibility"=>"eligible",
         "cn"=>"FULL NAME",
         "nyuidn"=>"N NUMBER",
         "uid"=>"NETID",
         "objectClass"=>"top",
         "givenName"=>"_____",
         "homeAccountStatus"=>"activated",
         "eduPersonPrincipalName"=>"_____@nyu.edu",
         "eduPersonEntitlement"=>"urn:mace:incommon:entitlement:common:1",
         "mail"=>"_____@nyu.edu",
         "nyuPrefMail"=>"_____@nyu.edu"}}}
