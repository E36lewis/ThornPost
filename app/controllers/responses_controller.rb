class ResponsesController < ApplicationController
  before_action :authenticate_user!

  def create
    @storie = Storie.find(params[:storie_id])
    @response = current_user.responses.create(body: params[:response][:body], storie_id: @storie.id)
    if @response.valid?
      notify_author_and_responders
      respond_to do |format|
        format.html { redirect_to @storie }
        format.js
      end
    else
      # TODO: display useful error message
      render nothing: true
    end
  end

  private

    def notify_author_and_responders
      (@storie.responders.uniq - [current_user]).each do |user|
        Notification.create(recipient: user, actor: current_user, action: "also commented on a", notifiable: @storie, is_new: true)
      end
      unless current_user?(@storie.user) || @storie.responders.include?(@storie.user)
        Notification.create(recipient: @storie.user, actor: current_user, action: "responded to your", notifiable: @storie, is_new: true)
      end
    end
end
