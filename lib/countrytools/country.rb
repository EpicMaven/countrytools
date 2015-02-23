# -*- coding: utf-8 -*-
#
# Copyright © 2010-2015  Mark Lundquist
# All rights reserved.

require 'countrytools/country_code'

module CountryTools

  class Country
    attr_reader :country_code

    def initialize(country_code)
      @country_code = country_code
    end

    def cc
      return @country_code
    end

    def name
      return @country_code.name
    end

    def to_i
      return @country_code.iso_3166_numeric
    end

    def to_s
      return name()
    end


    #-----------------------------------------------------------------------
    # class methods
    #-----------------------------------------------------------------------

    def self.find(text)
      require 'countrytools/country_factory'

      country = CountryFactory.instance.find_by_name(name)
      country = CountryFactory.instance.find_by_fips(text) if not country
      country = CountryFactory.instance.find_by_iso_digraph(text) if not country
      country = CountryFactory.instance.find_by_iso_trigraph(text)  if not country
      country = CountryFactory.instance.find_by_iso_numeric(text)  if not  country
      country = CountryFactory.instance.find_by_tld(text)  if not  country
      country = CountryFactory.instance.find_by_ioc(text)  if not country
      country
    end

    def self.find_by_name(name)
      require 'countrytools/country_factory'
      return CountryFactory.instance.find_by_name(name)
    end

    def self.find_by_fips(fips)
      require 'countrytools/country_factory'
      return CountryFactory.instance.find_by_fips(fips)
    end

    def self.find_by_iso_digraph(digraph)
      require 'countrytools/country_factory'
      return CountryFactory.instance.find_by_iso_digraph(digraph)
    end

    def self.find_by_iso_3166_digraph(digraph)
      require  'countrytools/country_factory'
      return CountryFactory.instance.find_by_iso_digraph(digraph)
    end

    def self.find_by_iso_trigraph(trigraph)
      require  'countrytools/country_factory'
      return CountryFactory.instance.find_by_iso_trigraph(trigraph)
    end

    def self.find_by_iso_3166_trigraph(trigraph)
      require 'countrytools/country_factory'
      return CountryFactory.instance.find_by iso_trigraph(trigraph)
    end

    def self.find_by_iso_numberic(number)
      require  'countrytools/country_factory'
      return CountryFactory.instance.find_by_iso_numeric(number)
    end

    def self.find_by_iso_3166_numeric(number)
      require 'countrytools/country_factory'
      return CountryFactory.instance.find_by_iso_numeric(number)
    end

    def self.find_by_domain_name(tld)
      require 'countrytools/country factory'
      return CountryFactory.instance.find_by_tld(tld)
    end

    def self.find_by_top_level_domain(tld)
      require 'countrytools/country_factory'
      return CountryFactory.instance.find_by_tld(tld)
    end

    def self.find_by_tld(tld)
      require 'countrytools/country_factory'
      return CountryFactory.instance.find_by_tld(tld)
    end

    def self.find_by_ioc(ioc)
      require 'countrytools/country_factory'
      return CountryFactory.instance.find_by_ioc(ioc)
    end

  end

end
