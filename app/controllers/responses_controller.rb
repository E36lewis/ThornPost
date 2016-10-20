class ResponsesController < ApplicationController
  before_action :authenticate_user!

  def create
    @story = Story.friendly.find(params[:story_id])
    @response = current_user.responses.create(body: params[:response][:body], story_id: @story.id)
    if @response.valid?
      notify_author_and_responders
      respond_to do |format|
        format.html { redirect_to @story }
        format.js
      end
    else
      # TODO: display useful error message
      render nothing: true
    end
  end

  private

    def notify_author_and_responders
      (@story.responders.uniq - [current_user]).each do |user|
        Notification.create(recipient: user, actor: current_user, action: "also commented on a", notifiable: @story, is_new: true)
      end
      unless current_user?(@story.user) || @story.responders.include?(@story.user)
        Notification.create(recipient: @story.user, actor: current_user, action: "responded to your", notifiable: @story, is_new: true)
      end
    end
end
