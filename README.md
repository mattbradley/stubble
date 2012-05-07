stubble
=======

A super simple URL shortening app written in Ruby using Sinatra, Slim, and
MongoDB. Use it as a baseline for your own URL shortening service or as an
example project when learning Ruby, Sinatra, Slim, or MongoDB.

* [Sinatra](http://www.sinatrarb.com/): web framework that handles routing and
  backend logic
* [Slim](http://slim-lang.com/): templating engine for rendering the views
* [MongoDB](http://www.mongodb.org/): NoSQL database that stores data in
  JSON(-like) documents

Dependecies
-----------

Make sure you have Sinatra, Slim, and the Ruby driver for MongoDB installed. If
you don't, run these commands to get 'em:

    gem install sinatra
    gem install slim
    gem install mongo

    # needed for the MongoDB driver
    gem install bson

    # optional C extensions for a performance boost
    gem install bson_ext

Usage
-----

Fire up Sinatra with `ruby stubble.rb` and visit `http://localhost:4567` in your
browser. To use a different port, try `ruby stubble.rb -p PORT`.

Stubbing a URL is pretty self-explanatory: just hit the button. Look at the code to see how it works;
you'll figure it out!
