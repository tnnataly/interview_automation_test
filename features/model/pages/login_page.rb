class LoginPage < BasePage


  def login(email, user_password)
    fill_in_field('email', email)
    fill_in_field('password', user_password)
    submit_button.click
    waiting
  end

end