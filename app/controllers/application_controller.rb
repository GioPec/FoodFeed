class ApplicationController < ActionController::Base

    before_action :authenticate_user!

    before_action :banned?

    def banned?
    if current_user.present? && current_user.disabled?
      sign_out current_user
      flash[:error] = "This account has been suspended...."
      redirect_back(fallback_location: root_path)
    end
  end
end
