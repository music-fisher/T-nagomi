class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

    def after_sign_in_path_for(resource)
        user_path(resource)
    end
    def after_sign_up_path_for(resource)
        posts_path
    end
    def set_search
      @search = Post.ransack(params[:q])
      @search_posts = @search.result.page(params[:page]) if params[:q].present?
    end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end

