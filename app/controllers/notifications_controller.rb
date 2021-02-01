class NotificationsController < ApplicationController
  def index
    # current_userの投稿に紐づいた通知
    @notifications = current_user.passive_notifications
    # indexに一度も遷移していない通知
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
