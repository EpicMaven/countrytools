## Welcome to CountryTools

CountryTools is a _pure_ Ruby toolkit for Country metadata. It provides a factory for constructing Country objects with meta populated such as: name, ISO 3166 codes, FIPS, STANAG codes, Top-Level Domains, and IOC codes

CountryTools
http://www.rubyforge.org/projects/countrytools

## Getting Started

1. Install CountryTools at the command prompt if you haven't yet:

        gem install countrytools

2. Create a country object by name:
   The name is the country is defined by the official ISO name, which may not be
   the colloquial name.

        `us = CountryTools::CountryFactory.find_by_iso_3166_digraph("United States")`

3. Create a country object by ISO 3166 digraph

        `germany = CountryTools::CountryFactory.find_by_iso_3166_digraph("de")`
        or shorter
        `germany = CountryTools::CountryFactory.find_by_iso_digraph("de")`

3. Create a country object by FIPS

        `us = CountryTools::CountryFactory.find_by_iso_3166_digraph("us")`

4. Using a browser, go to `http://localhost:3000` and you'll see:
"Welcome aboard: You're riding Ruby on Rails!"

5. Follow the guidelines to start developing your application. You may find
   the following resources handy:
    * [Getting Started with Rails](http://guides.rubyonrails.org/getting_started.html)
    * [Ruby on Rails Guides](http://guides.rubyonrails.org)
    * [The API Documentation](http://api.rubyonrails.org)
    * [Ruby on Rails Tutorial](http://ruby.railstutorial.org/ruby-on-rails-tutorial-book)

## Contributing

We encourage you to contribute to Ruby on Rails! Please check out the
[Contributing to Ruby on Rails guide](http://edgeguides.rubyonrails.org/contributing_to_ruby_on_rails.html) for guidelines about how to proceed. [Join us!](http://contributors.rubyonrails.org)

## Code Status

* [![Build Status](https://travis-ci.org/rails/rails.svg?branch=master)](https://travis-ci.org/rails/rails)

## License

Ruby on Rails is released under the [MIT License](http://www.opensource.org/licenses/MIT).
