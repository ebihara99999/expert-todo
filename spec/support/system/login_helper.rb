# Use this for system spec login
# Login and redirect to the root page
def login(user)
  visit "/"
  click_link "ログイン"
  find("#session_email").set user.email
  find("#session_password").set "password"
  find("#app > div > main > div > div > div > div > div.card__actions > button > div").click
end
