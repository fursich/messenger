class LikesController < ApplicationController

  def create

    t_id = params[:timeline_id]
    timeline = Timeline.find(t_id)
    e_key = params[:emo_id]

    reaction = Reaction.find_or_initialize_by(timeline_id: t_id, user_id: current_user.id)

    if reaction.emotion == e_key            #同じアイコンが二度押しされた場合：初期値０なので、Reaction.newの場合は該当しない
      b_id = 0                              #全てのボタンをnot selectedにする
      db_succeed = reaction.destroy
    else
      b_id = Reaction.emotions[e_key]          #selectedの対象になるボタン番号

      reaction.emotion = e_key                #新たに選択されたemotionをアップデート
      db_succeed = reaction.save              #saveに失敗した場合false
    end

    respond_to do |format|
      format.html do
        redirect_to root_path
      end

      format.json do
        if db_succeed
          if (timeline.number_of_reactions==0)   #表示すべきリアクション（likeなど）が全てなくなった場合
            render json: {t_id: t_id, active_button: b_id, saved: 'true', counter: 'false'}
          else
  
            html_ctr = render_to_string partial: 'likes/like', layout: false, formats: :html, locals: {tl: timeline}
            render json: {t_id: t_id, active_button: b_id, likes_count_html: html_ctr, saved: 'true', counter: 'true'}
          end
        else
          render json: {saved: 'false'}
        end
      end
    end

  end
end
