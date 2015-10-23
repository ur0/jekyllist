class GithubController < ApplicationController
  def redirect_to_github
    # Redirect the user to GitHub for OAuth
    address = github.authorize_url scope: Jekyllist.scope
    redirect_to logged_in? ? root_path : address
  end

  def callback
    # Handle the callback
    authorization_code = params[:code]
    access_token = github.get_token authorization_code
    @user = create_user(access_token.token)
    if @user
      log_in(@user.login)
      redirect_to root_path
    else
      redirect_to_github
    end
  end

  def create_user(token)
    # Create a user or find an existsing one. Returns an User if sucessfully created or found.
    @github.oauth_token = token
    @github.users.get
    @login = github.users.get.login
    @user = User.find_by_login @login
    if @user
      return @user
    else
      @name = github.users.get.name
      @user = User.new(login: @login, name: @name, token: token)
      return @user.save ? @user : nil
    end
  end
end
