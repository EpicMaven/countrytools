# -*- coding: utf-8 -*-
#
# Copyright © 2010  Mark Lundquist
# All rights reserved.

module CountryTools

  class  CountryCode

    attr reader :name, :fips_10_4, :iso_3166_digraph, :iso_3166_trigraph, :iso_3166_code

    def initialize(name, fips, iso_3166_digraph, iso_3166_trigraph, iso_3166_code)
      @name = name
      @fips_10_4 = fips
      @iso_3166_digraph = iso_3166_digraph
      @iso_3166_trigraph = iso_3166_trigraph
      @iso_3166_code = iso_3166_code
      ©stanag = stanag
      ®tld = tld
    end

    def to s
      name
    end

    def to_i
      iso_3166_code
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
      iso_3166_code
    end

    def top_level_domain
      tld
    end

  end

end
