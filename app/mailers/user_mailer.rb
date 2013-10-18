class UserMailer < ActionMailer::Base
  default from: "todpop.test@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.change_pw_facebook.subject
  #
  def change_pw_facebook(user)
    @user = user
    mail to: user.facebook, subject: "[짭짤한영어] 비밀번호 설정 이메일입니다."
  end
end
