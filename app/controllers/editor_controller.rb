class EditorController < ApplicationController
  before_action :require_login

  def editor
    @repos = github.repos.list
    @repo_names = []
    @repos.each { |repo| @repo_names << repo.name }
    @repo = params[:repo]
    @posts = []
    @file = params[:file]
    fullpath = "_posts/#{@file}"
    if @repo
      github.repos.contents.get(current_user.login, @repo, '_posts').each { |f| @posts << f.name }
    end
    if params[:file] && params[:file] != 'new'
      @content = Base64.decode64(github.repos.contents.get(current_user.login, @repo, fullpath).content).gsub("\n", '&#10;')
    else
      @content = '&#10;'
    end
  end

  def save
    contents = Github::Client::Repos::Contents.new oauth_token: current_user.token
    @repo = params[:repo]
    @file = params[:file]
    @input = params[:input].gsub("\r\n", "\n")
    @posts = []
    fullpath = "_posts/#{@file}"
    github.repos.contents.get(current_user.login, @repo, '_posts').each { |f| @posts << f.name }
    if @posts.include? @file
      # Existing post
      file = contents.find current_user.login, @repo, fullpath
      contents.update current_user.login, @repo, fullpath, path: fullpath, message: "Updated #{@file}.", content: @input, sha: file.sha
    else
      # New post
      contents.create current_user.login, @repo, fullpath, path: fullpath, message: "Created #{@file}.", content: @input
    end
    redirect_to "#{editor_path}?repo=#{@repo}&file=#{@file}"
  end

  private

  def github
    @github = Github.new oauth_token: current_user.token
  end
end
