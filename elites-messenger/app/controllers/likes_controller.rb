class LikesController < ApplicationController

  def create

    t_id = params[:timeline_id]
    like = Like.find_or_initialize_by(timeline_id: t_id, user_id: current_user.id)

    like.reaction = true
    

    if like.valid?
      like.save
      respond_to do |format|
        format.html do
          redirect_to root_path
        end
        format.json do
          total_likes = Like.where(timeline_id: t_id).count

          html = render_to_string partial: 'likes/like', layout: false, formats: :html, locals: {ctr: total_likes}
          render json: {likes_count_html: html, t_id: like.timeline_id}

          # render json: {like: tmp}
          # htm = render_to_string partial: 'timelines/timeline', layout: false, formats: :html, locals: {t: timeline}
          # render json: {timeline: 'test'}

        end
      end
 
    end

  end
end
