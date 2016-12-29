class LikesController < ApplicationController

  def create

    @timeline = Timeline.find(params[:timeline_id])
    @reaction = @timeline.reactions.find_or_initialize_by(user_id: current_user.id)
    @reaction.emotion = params[:emo_id]
  
    @emotion_code = @reaction.changed? ? Reaction.emotions[@reaction.emotion] : Reaction.emotions[:na]
    @result = if @reaction.changed?
                @reaction.save
              else
                @reaction.destroy
              end
    respond_to do |format|
      format.html {redirect_to root_path}
      format.json {render json: render_json}
    end

  end
  

  private
  
  def render_json
    if @result
      {
      t_id: @timeline.id,
      active_button: @emotion_code,
      likes_count_html: html_ctr,
      saved: 'true'
      }
    else
    end

  end

  def html_ctr
    return nil if (@timeline.number_of_reactions.zero?)
    render_to_string partial: 'likes/like', layout: false, formats: :html, locals: {tl: @timeline}
  end
  
end
