class DigestMailer < ApplicationMailer
  add_template_helper(UsersHelper)
  add_template_helper(StoriesHelper)
  add_template_helper(EmailHelper)

  # TODO: change mail to: @user.email when it's production ready
  def daily_email(user)
    @user = user
    @recommended = Story.latest(5).published
    mail to: @user.email, subject: "ThornPost Daily Digest"
  end
end