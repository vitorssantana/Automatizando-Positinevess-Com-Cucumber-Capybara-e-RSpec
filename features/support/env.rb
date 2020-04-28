require 'capybara/cucumber'
require 'selenium-webdriver'
require 'site_prism'
 
Capybara.default_max_wait_time = 20
Capybara.javascript_driver = :webkit
Capybara.default_driver = :selenium_firefox
Capybara.app_host = "https://positiveness.herokuapp.com/"
World(Capybara::DSL)
World(Capybara::RSpecMatchers)