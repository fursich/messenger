class LikesController < ApplicationController

  def create

    t_id = params[:timeline_id]
    reaction = Reaction.find_or_initialize_by(timeline_id: t_id, user_id: current_user.id)

    reaction.emotion = :like
    
    if reaction.save
      respond_to do |format|
        format.html do
          redirect_to root_path
        end
        format.json do
          total_likes = Reaction.like.where(timeline_id: t_id).count

          html = render_to_string partial: 'likes/like', layout: false, formats: :html, locals: {ctr: total_likes}
          render json: {likes_count_html: html, t_id: t_id, saved: 'true'}

          # render json: {timeline: total_likes}
        end
      end

    else
      respond_to do |format|
        format.html do
          redirect_to root_path
        end
        format.json do
          render json: {saved: 'false'}
        end
      end
    end

  end
end
