class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    logger.debug(request.env["omniauth.auth"])
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_session_url
    end
  end
  
  def failure
    logger.info "============================= failure"
    logger.info params.inspect
    logger.info "============================= failure"
    set_flash_message :alert, :failure, kind: OmniAuth::Utils.camelize(failed_strategy.name), reason: failure_message
    redirect_to after_omniauth_failure_path_for(resource_name)
  end  

end
