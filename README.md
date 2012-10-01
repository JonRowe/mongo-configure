[![Build Status](https://secure.travis-ci.org/JonRowe/mongo-configure.png)](http://travis-ci.org/JonRowe/mongo-configure)
# Mongo::Configure

A simple gem for configuring mongo databases.

## Installation

Add this line to your application's Gemfile:

    gem 'mongo-configure'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongo-configure

## Usage

When you have a Mongo URI:

    Mongo::Configure.from_uri "mongodb://remote_server.com:27017/production"

When you only care about the database name:

    Mongo::Configure.from_database "test_db"

To reaccess a previously configured configuration:

    Mongo::Configure.current

To access a configured database connection:

    configuration.load

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
