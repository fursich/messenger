class LikesController < ApplicationController

  def create

    t_id = params[:id]
    e_id = params[:emo_id]

    reaction = Reaction.find_or_initialize_by(timeline_id: t_id, user_id: current_user.id)

    if reaction.emotion == e_id             #Reactionの初期値は０なので、Reaction.newの場合は該当しない
      if (reaction.destroy == false)        #before_destroyに失敗した場合false
        db_succeed = false
      else
        db_succeed = true
      end
    else
      reaction.emotion = Reaction.emotions[e_id]
      db_succeed = reaction.save                 #saveに失敗した場合false
    end

    if db_succeed
      respond_to do |format|
        format.html do
          redirect_to root_path
        end
        format.json do

          if (Timeline.find(t_id).has_emotion?(current_user.id, e_id)) && (Timeline.find(t_id).number_of_reactions(e_id)==1)
            render json: {t_id: t_id, saved: 'true', html: 'false'}

          else
            # total_likes = Reaction.like.where(timeline_id: t_id).count
  
            html = render_to_string partial: 'likes/like', layout: false, formats: :html, locals: {t_id: t_id}
            render json: {likes_count_html: html, t_id: t_id, saved: 'true', html: 'true'}
  
            # render json: {timeline: total_likes}
          end
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
