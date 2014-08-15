# Jasmine::Reporter

This gem parse the output of a jasmine:ci call and create a valid JUnitXML file as required by the continuous integration plattform jenkins/hudson.
The test results of the jenkins call can be used to show the number of specs run and failed.



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jasmine-reporter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jasmine-reporter


Jasmine will not be installed by this gem.
## Usage

Require the file, wrap the call in a rake task and fire it on your Jenkins / Hudson installation.

## Examples
Create a file in /lib/tasks/jasmine-reporter.rake with the following content:
```ruby
require 'jasmine/reporter'
namespace :jasmine do
  desc 'Run Jasmine:ci and create JUnitXml Output'
  task :xml => :environment do
    Jasmine::Reporter::XmlReporter.new
  end
end
```

Inside your Jenkins Task:
````bash
RAILS_ENV=test bundle exec rake jasmine:xml
´´´´



## Contributing

1. Fork it ( https://github.com/[my-github-username]/jasmine-reporter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
