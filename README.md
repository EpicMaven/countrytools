## Welcome to CountryTools

CountryTools is a _pure_ Ruby toolkit for Country metadata. It provides a factory for constructing Country objects with meta populated such as: name, ISO 3166-1 codes, FIPS, Top-Level Domains, and IOC codes.

CountryTools
https://github.com/EpicMaven/countrytools

## Getting Started

1. Install CountryTools at the command prompt if you haven't yet:
   ```
   gem install countrytools
   ```

2. Create a country object by any identifier:
   Any of the types of identifiers (e.g., ISO code, TLD, etc) can be used.
   CountryTools will cascade through the identifiers to find a match.
   ```
   us = CountryTools::Country.find("United States")
   us = CountryTools::Country.find("us")
   us = CountryTools::Country.find("USA")
   us = CountryTools::Country.find("840")
   us = CountryTools::Country.find(840)
   us = CountryTools::Country.find(".us")
   ```

3. Create a country object by name:
   The name is the country is defined by the official ISO name, which may not be
   the colloquial name.

```
us = CountryTools::CountryFactory.find_by_iso_3166_digraph("United States")
```

4. Create a country object by ISO 3166 digraph

```
germany = CountryTools::CountryFactory.find_by_iso_3166_digraph("de")
```

  or shorter

```
germany = CountryTools::CountryFactory.find_by_iso_digraph("de")
```

5. Create a country object by FIPS

```
us = CountryTools::CountryFactory.find_by_iso_3166_digraph("us")
```

## Contributing

We encourage you to contribute to CountryTools!

## License

CountryTools is released under the [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0.txt).
