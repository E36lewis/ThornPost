class DigestMailer < ApplicationMailer
  add_template_helper(UsersHelper)
  add_template_helper(StoriesHelper)

  # TODO: change mail to: @user.email when it's production ready
  def daily_email(user)
    @user = user
    @recommended = Story.latest(5).published
    mail to: "chri3topher_t@hotmail.com", subject: "ThornPost Weekly Digest"
  end
end