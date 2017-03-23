# The central controller
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_global_vars
  before_action :store_location
  before_action :prepare_meta_tags, if: "request.get?"

  def prepare_meta_tags(options={})

    site_name   = t("shared.common.name")
    description = options[:description] || t("shared.common.description").html_safe
    title       = options[:title] || t("shared.common.name")
    image       = options[:image] || view_context.image_url("share_#{I18n.locale}.png")
    current_url = request.url

    # Let's prepare a nice set of defaults
    defaults = {
      site:        site_name,
      title:       title,
      image:       image,
      description: description,
      og: {
        url: current_url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: 'website'
      }
    }

    # options.reverse_merge!(defaults)

    set_meta_tags defaults
  end


  ##############################################
  # Locales #

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  before_action :set_locale
  private :set_locale

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  ##############################################
  # helpers

  def set_global_vars
    # indicate if the page title should be shown on the page
    # if false, then it will only be used in <title> tag
    @show_page_title = true

    @latest_pledge = Pledge.latest

    gon.addthis_id = ENV['ADDTHIS_ID']
    gon.facebook_id = ENV['FACEBOOK_APP_ID']
  end

  def clean_filename(filename)
    filename.strip.to_slug.transliterate.to_s.gsub(' ', '_').gsub(/[\\ \/ \: \* \? \" \< \> \| \, \. ]/,'')
  end

  # store the current path so after login, can go back
  def store_location
    session[:previous_urls] ||= []
    # only record path if page is not for users (sign in, sign up, etc) and not for reporting problems
    if session[:previous_urls].first != request.fullpath &&
        params[:format] != 'js' && params[:format] != 'json' && !request.xhr? &&
        request.fullpath.index("/users/").nil?
      session[:previous_urls].unshift request.fullpath
    elsif session[:previous_urls].first != request.fullpath &&
       request.xhr? && !request.fullpath.index("/users/").nil? &&
       params[:return_url].present?
      session[:previous_urls].unshift params[:return_url]
    end

    session[:previous_urls].pop if session[:previous_urls].count > 1
    # Rails.logger.debug "====================================="
    # Rails.logger.debug session[:previous_urls]
  end
  # def store_location
  #   session[:previous_urls] ||= []
  #   # only record path if page is not for users (sign in, sign up, etc) and not for reporting problems
  #   if session[:previous_urls].first != request.fullpath && 
  #       params[:format] != 'js' && params[:format] != 'json' && 
  #       request.fullpath.index("/users/").nil?

  #     session[:previous_urls].unshift request.fullpath
  #   end
  #   session[:previous_urls].pop if session[:previous_urls].count > 1

  #   Rails.logger.debug "====================================="
  #   Rails.logger.debug session[:previous_urls]
  # end


  ##############################################
  # Authorization #

  # role is either the name of the role (string) or an array of role names (string)
  def valid_role?(role)
    redirect_to root_path(locale: I18n.locale), :notice => t('shared.msgs.not_authorized') if !current_user || !((role.is_a?(String) && current_user.is?(role)) || (role.is_a?(Array) && role.include?(current_user.role.name)))
  end

  # after user logs in go back to the last page or go to root page
  def after_sign_in_path_for(resource)
    session[:previous_urls].last || request.env['omniauth.origin'] || root_path(:locale => I18n.locale)
  end



  rescue_from CanCan::AccessDenied do |_exception|
    if user_signed_in?
      not_authorized(root_path(locale: I18n.locale))
    else
      not_authorized
    end
  end

  def not_authorized(redirect_path = new_user_session_path)
    redirect_to redirect_path, alert: t('shared.msgs.not_authorized')
  rescue ActionController::RedirectBackError
    redirect_to root_path(locale: I18n.locale)
  end

  def not_found(redirect_path = root_path(locale: I18n.locale))
    Rails.logger.debug('Not found redirect')
    redirect_to redirect_path,
                notice: t('shared.msgs.does_not_exist')
  end
end
