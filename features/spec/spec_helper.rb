require 'capybara/rspec'
require 'selenium-webdriver'
require 'site_prism'
 
Capybara.default_max_wait_time = 20
Capybara.javascript_driver = :webkit
Capybara.default_driver = :selenium
Capybara.app_host = "https://positiveness.herokuapp.com/"


RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.include Capybara::DSL

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
 
  config.shared_context_metadata_behavior = :apply_to_host_groups

=begin
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.warnings = true
  if config.files_to_run.one?
    config.default_formatter = "doc"
  end
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
=end

end
