class BookmarksController < ApplicationController
  before_action :authenticate_user! 
  def create
    bookmark = current_user.bookmarks.build(post_id: params[:post_id])
    bookmark.save!
    redirect_back(fallback_location: root_path)
  end
  def destroy
    current_user.bookmarks.find_by(post_id: params[:post_id]).destroy!
    redirect_back(fallback_location: root_path)
  end
end
