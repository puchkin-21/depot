class ApplicationController < ActionController::Base
    before_action :authorize
    before_action :set_i18_locale_from_params
    protect_from_forgery   

    private

    def current_cart
        Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
        cart = Cart.create
        session[:cart_id] = cart.id
        cart
    end

    protected

        def set_i18_locale_from_params
            if params[:locale]
                if I18.available_locales.include?(params[:locale].to_sym)
                    I18.locale = params[:locale]
                else
                    flash.now[:notice] = "#{params[:locale]} translation not available"
                    logger.error flash.now [:notice]
                end
            end
        end

        def authorize
          unless User.find_by_id(session[:user_id])
          redirect_to login_url, notice: "Пожалуйста, пройдите авторизацию"           
        end   
        
        
        def default_url_options
            {locale: I18.locale}
        end 
    end
end