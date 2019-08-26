class SignupPage < BasePage

  section :radio_button_section, '[class*="radio_circle"]' do
    element :radio_button, 'label', visible: :false
  end

   element :error_message, '.session__errors'


end