module Api
  module V1  
    class ReferralsController < ApplicationController
      before_action :authenticate_user!
      
      def create
        referral_email = params[:email]
        if URI::MailTo::EMAIL_REGEXP.match?(referral_email)
          referral = current_user.referrals.create(email: referral_email, invited: false)

          ReferralMailer.with(referral: referral).send_invite.deliver_later

          render json: { message: "Referral sent successfully!" }, status: :ok
        else
          render json: { error: "Invalid email format" }, status: :unprocessable_entity
        end
      end
    end
  end
end
