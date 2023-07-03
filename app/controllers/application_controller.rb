class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:home, :index]
  before_action :fetch_github_info
  include Pundit::Authorization

  # Pundit: white-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  def after_sign_up_path_for(resource)
    user_information_path(current_user)
  end

  def fetch_github_info
    if current_user && current_user.user_information.github_url && current_user.user_information.github_url != "https://github.com/"
      require 'open-uri'
      puts "GitHub username: #{current_user.user_information.github_url}"
      github_username = current_user.user_information.github_url.split("/").last
      puts "GitHub username: #{github_username}"
      @gh_api = JSON.parse(URI.parse("https://api.github.com/users/#{github_username}").open.read)
    end
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
