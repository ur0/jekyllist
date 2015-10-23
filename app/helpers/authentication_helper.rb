module AuthenticationHelper
	def log_in(login)
		# Create a signed cookie that contains the GitHub login.
		cookies.signed[:login] = login
	end
	
	def current_user
		# Return the user identified by the cookie
		User.find_by_login(cookies.signed[:login])
	end
	
	def logged_in?
		# Does the login cookie exist?
		!!current_user
	end
end
