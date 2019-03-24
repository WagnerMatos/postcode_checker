# Postcode Checker
Coding test: Postcode Service Checker

## Details
Your customer would like a simple library, web-app or command line application to work out if a given postcode is within their service area.
The input is a UK postcode and the output should be a boolean; true if that postcode can be served and false if not. We are using the Postcodes.io REST API as our source for data.
The service area is described by the following rules:
1. Postcodes are grouped into larger blocks called LSOAs. This is returned from the API when we query a postcode. We want to whitelist any postcode in an LSOA starting "Southwark" or "Lambeth". Example postcodes for these LSOAs are SE1 7QD and SE1 7QA respectively.
2. Some postcodes are unknown by the API or may be served despite being outside of the whitelisted LSOAs. We need to be able to whitelist these anyway, even though the API does not recognise them. SH24 1AA and SH24 1AB are both examples of unknown postcodes that we want to serve.
3. Any postcode not in the LSOA whitelist or the Postcode whitelist is not serviceable.
Please note that no guarantees about the format of the input can be given, and the whitelists will need to be changed from time to time.
Documentation for the Postcodes.io API can be found at http://postcodes.io/
For an example, you can either simulate the API on postcodes.io itself, or you could run:

## Usage
I have set the whole thing up as a Ruby gem for simplicity sake.

In the root folder of the project simply execute `bundle install` to pull in the libraries needed to run the code. Please note that you will need Ruby version 2.2 or higher to be able to run this.

Once you have bundled the dependencies, simply run the programme passing it a web server log file. There's an exemplary file included in the project, so the following works:
`bin/checker "SE1 7QD"`


## Considerations
### Whitelist config file
For the purpose of this exercise I have decided to use a config file for whitelisting,
however I would normally consider either a UI to manage the configuration or environment
variables (not discarding the config file itself).

## Connect class
I have decided to wrap the HTTP client (Faraday in this case) in a separate class for convenience as I would
imagine in the real world this class could do more validations (validate of uri for instance), however on the same
token one could argue the wrapper could be removed for simplicity sake.
 
### Postcode validation and formatting. 
For the purpose of this project, postcode validation and formatting is a crucial step and it needs to 
be handled carefully. I have decided to use a gem [UKPostcode](https://github.com/threedaymonk/uk_postcode).
 
To test the suitability of the gem I have used a list of valid postcodes and tested these postcodes 
against this gem and the gem has performed correctly, however, moving forward I would suggest to create 
an extensive suite of tests to continually test the gem to ensure it perform according to the business 
requirements and maybe participate in its development if it does not or create our own internal gem 
to handle this process.

This stack overflow thread provides insightful information on UK postcode validation: 
https://stackoverflow.com/questions/164979/uk-postcode-regex-comprehensive

Steps taken to validate the postcode gem against valid postcodes:

- Downloaded postcode csv file from: https://www.doogal.co.uk/UKPostcodes.php
- The zipped file is very large so I used the bash utility split to break the full list into 
smaller files: `split -l 100 postcodes.csv new.csv` and took a random file to use as test source.
- Wrote the unit test to gem the gem against this set data. 

Steps taken to validate the gem against invalid postcodes:

- Found invalid postcodes online
- Visited http://www.postoffice.co.uk/postcode-finder and check whether the postcode was valid. The Post Office 
tool tries to auto-complete the invalid postcodes with valid data, however it does not find addresses based on the exact
match. 