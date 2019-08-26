require 'selenium/webdriver'
require 'capybara/rspec/matchers'
require 'capybara/dsl'
require 'capybara'
require 'site_prism'
require 'parallel_tests'
require 'json'
require 'allure-cucumber'


World(Capybara::RSpecMatchers)

REPORTS_PATH = 'reports'
FileUtils.rm_rf(REPORTS_PATH) if File.exist?(REPORTS_PATH)
FileUtils.mkpath(REPORTS_PATH)
FileUtils.mkpath(REPORTS_PATH + "/json")

SERVER_PORT = 10000 + ENV['TEST_ENV_NUMBER'].to_i
Capybara.server_port = SERVER_PORT

require 'yaml'

def get_current_environment
  ENV['TEST_ENV'] ||=  'env_stage'
end

def get_current_browser
  ENV['BROWSER'] ||=  'chrome'
end


def get_env
  get_env_data(get_current_environment)['env']
end

def get_env_data(env)
  YAML::load(File.read(File.expand_path('../../..', __FILE__) + '/configs/config.yml'))[env.downcase]
end


ENV['SCREENSHOT_PATH'] = 'reports/'

#Hooks
AfterConfiguration do |config|
  puts "Features in #{config.feature_dirs}"
end

class Cucumber::Core::Test::Step
  def name
    text
  end
end


#Hooks Before and After to launch and stop web driver
Before do
  @current_browser = get_current_browser
  if @current_browser == 'chrome' then
    Capybara.current_driver = :chrome
    Capybara.register_driver :chrome do |app|
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--window-size=1920,1080')
      options.add_argument('--disable-web-security')
      options.add_argument('--allow-file-access-from-files')
      Capybara::Selenium::Driver.new(app, :browser => :chrome, options: options)
    end
  else
    Capybara.current_driver = :internet_explorer
    Capybara.register_driver :internet_explorer do |app|
      caps = Selenium::WebDriver::Remote::Capabilities.internet_explorer
      caps["requireWindowFocus"] = true
      caps['ignoreZoomSetting'] = false
      caps["javascriptEnabled"] = true
      Capybara::Selenium::Driver.new(app, :browser => @current_browser, :desired_capabilities => caps)
    end
  end


  Capybara.save_path = REPORTS_PATH
  Capybara.javascript_driver = :javascript_driver

  Capybara.default_max_wait_time = 60
  Capybara.wait_on_first_by_default = true
  @session = Capybara.current_session


  @base_page = BasePage.new
  @signup_page = SignupPage.new
  @login_page = LoginPage.new
 end

After do |scenario|
  if scenario.failed?
    puts ENV['TEST_ENV'] + ' => ' + @session.current_url
    puts scenario.name
    screenshot_path = @session.save_screenshot
    filename = File.basename(screenshot_path)
    log_filename = filename.gsub('.png', '.txt')
    File.write(screenshot_path.gsub('.png', '.txt'), @session.driver.browser.manage.logs.get("browser"))
    embed(screenshot_path, 'image/png', filename)
    embed(screenshot_path.gsub('.png', '.txt'), 'text/plain', log_filename)
  end

  @session.driver.quit

end


