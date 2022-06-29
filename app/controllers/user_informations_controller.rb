require 'open-uri'
require 'json'

class UserInformationsController < ApplicationController

  def show
    @user_information = UserInformation.find(params[:id])
    authorize @user_information
    @tickets = Ticket.where(user_id: @user_information.user_id)
    @ticket_ids = @tickets.map(&:id)
    @reviews = Review.select { |r| @ticket_ids.include?(r.ticket_id)}

    if @user_information.github_url
      github_username = @user_information.github_url.split("/").last
      url = "https://api.github.com/users/#{github_username}"
      open_url = URI.open(url).read
      @api = JSON.parse(open_url)
    end
  end

  def edit
  end

  def update
    @user_information = UserInformation.find(params[:id])
    @user_information.update(user_information_params)
    redirect_to  user_information_path
    authorize @user_information
  end

  private

  def user_information_params
    params.require(:user_information).permit(:first_name, :last_name, :bio, :github_url)
  end
end
