require "jasmine/reporter/version"
require 'fileutils'


module Jasmine
  module Reporter
    class XmlReporter

      PATH = 'spec/reports'
      JASMINE_FILE = 'jasmine.out'
      REPORT_FILE = 'SPEC-jasmine.xml'

      def initialize(report_file = REPORT_FILE)
        create_test_directory
        start = Time.now
        run_jasmine
        result = parse_tests
        xml = generate_xml(result[0], result[1],Time.now-start)
        write_xml_output(report_file, xml)
      end

      private

      def create_test_directory
        FileUtils::mkdir_p PATH
      end

      def run_jasmine
        system "rake jasmine:ci > #{PATH}/#{JASMINE_FILE}"
      end

      def parse_tests
        contents = File.read("#{PATH}/#{JASMINE_FILE}")
        result = /(\d+)\sspecs,\s(\d+)\sfailures/.match(contents)
        if result.size==3
          return [result[1].to_i, result[2].to_i]
        else
          return [0, 0]
        end
      end

      def generate_xml(number_of_specs, number_of_failures,time_taken)
        result = '<?xml version="1.0" encoding="UTF-8"?>'+ "\n"
        result += '<testsuite name="Jasmine JavaScript Tests" tests="'+number_of_specs.to_s+'" time="'+time_taken.to_s+'">'+ "\n"
        (1..number_of_specs).each do |s|
          result += '  <testcase name="'+s.to_s+' Test">'+ "\n"
          if number_of_failures>0
            result += '    <failture />'+ "\n"
            number_of_failures-=1
          end
          result += '  </testcase>'+ "\n"
        end
        result += "</testsuite>"
        result
      end

      def write_xml_output(report_file, xml)
        File.write("#{PATH}/#{report_file}", xml)
      end
    end
  end
end
