require 'capybara/rspec'

def waiting
  Timeout.timeout(60) do
    sleep(1) until Capybara.page.evaluate_script('jQuery.active').zero?
  end
rescue Selenium::WebDriver::Error::UnknownError
  sleep(1)
end
