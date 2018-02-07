def jwt_of(user = nil, password = 'password', route = nil)
  user ||= @user
  route ||= api_v1_users_sessions_path
  
  username_attr = user.sorcery_config.username_attribute_names.first
  username = user.send(username_attr)
  password_attr = user.sorcery_config.password_attribute_name
  
  post route, params: { session: { "#{username_attr}": username, "#{password_attr}": password } }, as: :json
  eval(@response.body)[:auth_token]
end