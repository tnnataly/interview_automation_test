require 'capybara'
require 'capybara/dsl'
require 'site_prism'
require 'active_support'
require 'active_support/core_ext'



class BasePage < SitePrism::Page

  element :login_button, 'a[href="/login"]'
  element :signup_button, 'a[href="/signup"]'
  element :submit_button, 'button[type="submit"][id*="submit"]'

  element :account_button, '[data-qaid="account-name"]'
  element :content, 'body'

  def refresh_page
    page.refresh
    waiting
  end

  def fill_in_field(id, value)
    find("input##{id}").set(value)
    waiting
  end


end