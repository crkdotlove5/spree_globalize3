Spree::LocaleController.class_eval do

  skip_before_filter :set_user_language

  def detect
    locale = session[:locale] || env.http_accept_language.compatible_language_from(I18n.available_locales) || I18n.default_locale
    redirect_to "/#{locale}", :status => 302
  end

end
