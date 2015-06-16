require 'simplecov'

if ENV["RUN_SIMPLECOV"] == 'true'
  SimpleCov.start do
    load_adapter 'test_frameworks'
  end
end

RSpec.configure do |config|
  config.disable_monkey_patching!
end

require 'validates_formatting_of'
require 'active_model'

class TestActiveRecord

  include ActiveModel::Validations
  include ValidatesFormattingOf::Validations
  extend ValidatesFormattingOf::ModelAdditions

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    @persisted = false
  end

  def save
    @persisted = true
  end

  def persisted?
    @persisted ||= false
  end

end

RSpec::Expectations.configuration.warn_about_potential_false_positives = false
# Added above line to turn off "warn_about_bare_error" warning.
# -- WARNING: Using the `raise_error` matcher without providing a specific 
#    error or message risks false positives, since `raise_error` will match
#    when Ruby raises a `NoMethodError`, `NameError` or `ArgumentError`,
#    potentially allowing the expectation to pass without even executing the
#    method you are intending to call. Instead consider providing a specific
#    error class or message. This message can be supressed by setting:           
#    `RSpec::Expectations.configuration.warn_about_potential_false_positives
#    = false`. 

