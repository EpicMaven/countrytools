# -*- coding: utf-8 -*-
#
# Copyright © 2010-2015  Mark Lundquist
# All rights reserved.

module CountryTools

  class CountryCode

    attr_reader :name, :short_name, :fips_10_4, :iso_3166_digraph, :iso_3166_trigraph, :iso_3166_numeric, :tld, :ioc

    def initialize(name, short_name, fips, iso_3166_digraph, iso_3166_trigraph, iso_3166_numeric, tld, ioc)
      @name = name
      @short_name = short_name
      @fips_10_4 = fips
      @iso_3166_digraph = iso_3166_digraph
      @iso_3166_trigraph = iso_3166_trigraph
      @iso_3166_numeric = iso_3166_numeric
      @tld = tld
      @ioc = ioc
    end

    def to s
      name
    end

    def to_i
      iso_3166_numeric
    end

    def fips
      fips_10_4
    end

    def iso_digraph
      iso_3166_digraph
    end

    def iso_trigraph
      iso_3166_trigraph
    end

    def iso_code
      iso_3166_numeric
    end

    def iso_numeric
      iso_3166_numeric
    end

    def top_level_domain
      tld
    end

  end

end
