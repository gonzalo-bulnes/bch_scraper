BancoScraper
============

A minimal app to fetch some data from a remote service using a config file.

Usage
-----

```bash
cd bch_scraper

# install the dependencies
bundle install

# create the configuration file
cp config/credentials{.example,}.yml

# provide your own credentials
vi config/credentials.yml

# start the server
ruby app.rb # visit http://localhost:4567

```

Development
-----------

```bash
# run the tests suite
rspec spec/
```
