class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
    before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :prepare_meta_tags, if: "request.get?"
	
	def prepare_meta_tags(options={})
		site_name   = "ThornPost"
		title       = [controller_name, action_name].join(" ")
		description = "ThornPost provides the aggregated news needed for informed decisions, while providing the dopamine levels to get throught the day!"
		image       = options[:image] || "/assets/images/favicon.png"
		current_url = request.url
		
		defaults = {
			site:         site_name,
			title:        title,
			image:        image,
			description:  description,
			keywords:     %w[news photo video global business science],
			twitter: {
				site_name: site_name,
				site: @ThornPost,
				card: 'summary',
				description: description,
				image: image
			},
			og: {
				url: current_url,
				site_name: site_name,
				title: title,
				image: image,
				description: description,
				type: 'website'
			}
		}
		
		options.reverse_merge!(defaults)
		
		set_meta_tags options
	end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
    end

    def current_user?(user)
      current_user.id == user.id
    end

    helper_method :current_user?
end
