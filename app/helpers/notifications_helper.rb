module NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    @visiter_comment = notification.comment_id
    # notification.actionがどの値か
    case notification.action
      when "follow" then
        tag.a(notification.visiter.name, href: user_path(@visiter), style:"font-weight: bold; color: #0099CC;")+"があなたをフォローしました"
      when "like" then
        tag.a(notification.visiter.name, href: user_path(@visiter), style:"font-weight: bold;  color: #0099CC;")+"が"+tag.a('あなたの投稿', href: post_path(notification.post_id), style:"font-weight: bold; color: #0099CC;")+"にいいねしました"
      when "comment" then
        @comment = Comment.find_by(id: @visiter_comment)&.comment_content
        tag.a(@visiter.name, href: user_path(@visiter), style:"font-weight: bold; color: #0099CC;")+"が"+tag.a('あなたの投稿', href: post_path(notification.post_id), style:"font-weight: bold; color: #0099CC;")+"にコメントしました"
    end
  end
  # 未確認の通知はマークで知らせる
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
