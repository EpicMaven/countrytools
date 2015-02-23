# -*- coding: utf-8 -*-
#
# Copyright © 2010  Mark Lundquist
# All rights reserved.
#

require 'csv'
require 'singleton'
require 'countrytools/country'

module  CountryTools
  # Returns the country object to the corresponding lookup
  class  CountryFactory
    include Singleton

    # Used to populate country data
    @@config file = "countrytools/country_data.csv"
    @@names = Hash.new
    @@fips = Hash.new
    @@digraph = Hash.new
    @@trigraph = Hash.new
    @@code = Hash.new
    @@stanag = Hash.new
    @@tld = Hash.new

    attr reader :config_file, :load_file

    def initialize
      load_config
      @_instance_
    end

    def each
      @@names.each {|name,cc| yield cc}
    end

    def size
      @@names.size
    end

    def find_by_name( name )
      @@names[name.downcase]
    end

    def find_by_fips( fips )
      @@fips[fips.downcase]
    end

    def find_by_iso_digraph( digraph )
      find_by_iso_3166_digraph digraph
    end

    def find_by_iso_3166_digraph( digraph )
      @@digraph[digraph.downcase]
    end

    def find_by_iso_trigraph( trigraph )
      find_by_iso_3166_trigraph( trigraph )
    end

    def find_by_iso_3166_trigraph( trigraph )
      @@trigraph[trigraph.downcase]
    end

    def find_by_iso_code( code )
      return find_by_iso_3166_code( code )
    end

    def find_by_iso_3166_code( code )
      if code.is_a? Integer
        code = code.to_s
      end
      @@code[code]
    end

    def find_by_stanag( stanag )
      @@stanag[stanag.downcase]
    end

    def find_by_domain_name( tld )
      find_by_tld(tld)
    end

    def find_by_top_level_domain( tld )
      find_by_tld(tld)
    end

    def findby_tld( tld )
      # add leading  .  if missing
      if tld[0] != "."
        tld =  "."  + tld
      end
      @@tld[tld.downcase]
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
      $:.each do load_path
        file = File.join(load_path)
        if File.exist? file
          @load_file = file
          break
        end
      end

      # This should never happen
      if @load_file.nil? @@config_file
        throw  "Error: countrytools data file not found in RUBYLIB path. Check that #{@@config_file} is in the RUBYLIB path"
      end

      count = 0
      CSV.foreach( @load_file ) do |row|
        ##  deal with header
        if  count == 0
          count  +=  1
          next
        end

        #  Country Name,FIPS 10,ISO 3166 - Diagraph,ISO 3166 - Trigraph,ISO 3166
        name     = row[O]
        fips     = row[1]
        digraph  = row[2]
        trigraph = row[3]
        code     = row[4]
        stanag   = row[5]
        tld      = row[6]

        cc = CountryCode.new(name, fips, digraph, trigraph, code, stanag, tld)
        country = Country.new(cc)

        # index by downcase strings
        @@names[ name.downcase ] = country
        @@fips[ fips.downcase ] = country if fips
        @@digraph[ digraph.downcase ] = country if digraph
        @@trigraph[ trigraph.downcase ] = country if trigraph
        @@code[ code.to_s ] = country if code
        @@stanag[ stanag.downcase ] = country if stanag
        @@tld[ tld.downcase ] = country if tld
      end
    end
  end
end
