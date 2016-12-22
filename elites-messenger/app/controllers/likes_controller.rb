class LikesController < ApplicationController

    def create
        like = Like.new

        like.timeline_id = params[:timeline_id]
        like.user_id = current_user.id
        like.reaction = true

        like.save
        redirect_to root_path
    end

end
