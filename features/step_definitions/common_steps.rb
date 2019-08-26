When(/^system clears cache and cookies$/) do
  @session.driver.quit
end

Given(/^user with role (.*) opens the farmdrop in web-browser$/) do |user_role|
  user_role = user_role.downcase
  environment = get_current_environment
  env_config = get_env_data(environment)
  Capybara.app_host = env_config['host']
  login_data = {
      host: Capybara.app_host,
      email: env_config[user_role]['email'],
      password: env_config[user_role]['user_password'],
  }
  @portal_login_data = login_data
  @session.visit Capybara.app_host
  sleep(1)
  @login_page.login("#{login_data[:email]}", login_data[:password])
  waiting
  $driver = @session.driver.browser
end


Given(/^user opens Farmdrop application$/) do
  environment = get_current_environment
  env_config = get_env_data(environment)
  Capybara.app_host = env_config['host']
  @session.visit Capybara.app_host
end

When(/^user goes to Sign Up page$/) do
  @base_page.login_button.click
  waiting
  @base_page.signup_button.click
  waiting
end

When(/^user fills in the form on Sign Up page with data:$/) do |table|
  table.hashes.each do |row|
    row[:field_name] = row[:field_name] == 'postcode' ? 'zipcode' : row[:field_name]
    row[:field_name] == 'mailing_list' ? @signup_page.radio_button_section(text: row[:value]).radio_button.click : @base_page.fill_in_field(row[:field_name], row[:value])
    waiting
  end

end

 When(/^user (tries to submit|submits) Sign Up form$/) do |action|
   @base_page.submit_button.click
   @base_page.wait_until_submit_button_invisible(5) if action == 'submits'
   waiting
 end

Then(/^user verifies (.*) button is(n't|) displayed on the page$/) do |button_name, not_presence|
  expect(@base_page.has_account_button?(text: button_name)).to be(not_presence.empty?)
end

Then(/^user verifies text is displayed on the page:$/) do |text|
  expect(@base_page.content.text).to include(text)
end

Then(/^user verifies error is displayed on Sign Up page:$/) do |text|
   expect(@signup_page.error_message.text).to eq(text)
end
