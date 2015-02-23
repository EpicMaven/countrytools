# -*- coding: utf-8 -*-
#
# Copyright © 2010-2015  Mark Lundquist
# All rights reserved.
#

require 'csv'
require 'singleton'
require 'countrytools/country'

module CountryTools
  # Returns the country object to the corresponding lookup
  class CountryFactory
    include Singleton

    # Used to populate country data
    @@config_file = "countrytools/country_data.csv"
    @@name = Hash.new
    @@short_name = Hash.new
    @@fips10 = Hash.new
    @@iso_alpha2 = Hash.new
    @@iso_alpha3 = Hash.new
    @@iso_numeric = Hash.new
    @@tld = Hash.new
    @@ioc = Hash.new

    attr_reader :config_file, :load_file

    def initialize
      load_config
      @_instance_
    end

    def each
      @@name.each {|name,cc| yield cc}
    end

    def size
      @@name.size
    end

    def find_by_name(name)
      @@name[name.downcase]
    end

    def find_by_fips(fips)
      @@fips10[fips.downcase]
    end

    def find_by_iso_digraph(digraph)
      find_by_iso_3166_digraph digraph
    end

    def find_by_iso_3166_digraph(digraph)
      @@iso_alpha2[digraph.downcase]
    end

    def find_by_iso_trigraph(trigraph)
      find_by_iso_3166_trigraph(trigraph)
    end

    def find_by_iso_3166_trigraph(trigraph)
      @@iso_alpha3[trigraph.downcase]
    end

    def find_by_iso_code(code)
      return find_by_iso_numeric(code)
    end

    def find_by_iso_numeric(number)
      @@iso_numeric[number.to_i.to_s]
    end

    def find_by_domain_name(tld)
      find_by_tld(tld)
    end

    def find_by_top_level_domain(tld)
      find_by_tld(tld)
    end

    def find_by_tld(tld)
      # add leading  .  if missing
      if tld[0] != "."
        tld =  "."  + tld
      end
      @@tld[tld.downcase]
    end

    def find_by_ioc(ioc)
      @@ioc[ioc.downcase]
    end

    #-----------------------------------------------------------------------
    # private methods
    #-----------------------------------------------------------------------
    private

    def load_config
      @load_file = nil
      #  ***  TODO  -  fix this  to load better
      ## ***  Hack way to get around not having gems.
      # Searches ruby LOAD PATH for matching file, then loads the
      #  config file from them module
      $LOAD_PATH.each { |load_path|
        file = File.join(load_path, @@config_file)
        if File.exist? file
          @load_file = file
          break
        end
      }

      # This should never happen
      if @load_file.nil?
        throw  "Error: countrytools data file not found in RUBYLIB path. Check that #{@@config_file} is in the RUBYLIB path"
      end

      count = 0
      CSV.foreach(@load_file) { |row|
        ##  deal with header
        if count == 0
          count += 1
          next
        end

        #  Country Name,Short Name, FIPS 10,ISO 3166-1 alpha-2,ISO 3166-1 alpha-3,ISO 3166-1 numeric, TLD, IOC
        name        = row[0]
        short_name  = row[1]
        fips        = row[2]
        digraph     = row[3]
        trigraph    = row[4]
        iso_numeric = row[5]
        tld         = row[6]
        ioc         = row[7]

        cc = CountryCode.new(name, short_name, fips, digraph, trigraph, iso_numeric, tld, ioc)
        country = Country.new(cc)

        # index by downcase strings
        @@name[ name.downcase ] = country
        @@short_name[ short_name.downcase ] = country if short_name
        @@fips10[ fips.downcase ] = country if fips
        @@iso_alpha2[ digraph.downcase ] = country if digraph
        @@iso_alpha3[ trigraph.downcase ] = country if trigraph
        @@iso_numeric[ iso_numeric.to_i.to_s ] = country if iso_numeric
        @@tld[ tld.downcase ] = country if tld
        @@ioc[ ioc.downcase ] = country if ioc
      }
    end
  end
end
