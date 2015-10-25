class EditorController < ApplicationController
  before_action :require_login

  def editor
    @repos = github.repos.list
    @repo_names = []
    @repos.each { |repo| @repo_names << repo.name }
    @repo = params[:repo]
    @posts = []
    @file = "_posts/#{params[:file]}"
    if @repo
      github.repos.contents.get(current_user.login, @repo, '_posts').each { |f| @posts << f.name }
    end
    if params[:file]
      @content = Base64.decode64(github.repos.contents.get(current_user.login, @repo, @file).content).gsub("\n", '&#10;')
    end
    render layout: 'index'
  end

  def save
    contents = Github::Client::Repos::Contents.new oauth_token: current_user.token
    @repo = params[:repo]
    @file = params[:file]
    @input = params[:input].gsub("\r\n", "\n")
    file = contents.find current_user.login, @repo, @file
    contents.update current_user.login, @repo, @file, path: @file, message: "Updated #{@file}.", content: @input, sha: file.sha
    redirect_to editor_path
  end

  private

  def github
    @github = Github.new oauth_token: current_user.token
  end
end
