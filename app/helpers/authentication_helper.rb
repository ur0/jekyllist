module AuthenticationHelper
	def log_in(login)
		# Create a signed cookie that contains the GitHub login.
		cookies.signed[:login] = login
	end
	
	def current_user
		# Return the contents of the signed login cookie
		cookies.signed[:login]
	end
	
	def logged_in?
		# Does the login cookie exist?
		!!current_user
	end
end
