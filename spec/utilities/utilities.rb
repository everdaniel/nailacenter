include ApplicationHelper

def sign_in(user)
  visit login_path
  fill_in "Usuario",    with: user.username
  fill_in "Contraseña", with: user.password
  click_button "Ingresar"
  # Sign in when not using Capybara as well
  cookies[:remember_token] = user.remember_token
end