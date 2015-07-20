class UserMailer < ApplicationMailer
  def email_notice_new_review review, user
    @user_name = review.user.name
    @user_email = review.user.email
    @last_user = user
    mail to: @user_email, suject: t("emails.review")
  end

  def email_notice_new_comment comment
    @name_comment = comment.user.name
    @comment_body = comment.content
    @email_review = comment.review.user.email
    @name_review = comment.review.user.name
    mail to: @email_review , suject: t("emails.review")
  end

  def email_accept_buy_book request
    @request = request
    @user = request.user
    @user_mail = request.user.email
    mail to: @user_mail, subject: t("mail.subject")
  end
end
