class UserMailer < ApplicationMailer
    default from: 'noreply@example.com'
  
    def sign_up_confirmation(user)
      @user = user
      mail(to: @user.email, subject: 'Welcome to Our Service!')
    end
  end
  