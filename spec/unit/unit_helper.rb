require File.dirname(__FILE__) + '/../spec_helper'
require 'rspec/autorun'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end
