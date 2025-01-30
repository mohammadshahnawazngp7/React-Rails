class ReferralMailer < ApplicationMailer
    def send_invite
      @referral = params[:referral]
      @user = @referral.user
      mail(to: @referral.email, subject: "You're invited!")
    end
  end