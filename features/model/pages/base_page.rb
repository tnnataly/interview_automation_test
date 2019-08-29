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
  element :frame, 'iframe'

  def refresh_page
    page.refresh
    waiting
  end

  def get_field(id)
    find("input##{id}")
  end

  def fill_in_field(id, value)
    get_field(id).set(value)
    waiting
  end


end