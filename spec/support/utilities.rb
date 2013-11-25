
def login(user)
  sign_in :user, user
  session[:ada_id] = user[:ada_id]
end