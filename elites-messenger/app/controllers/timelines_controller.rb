class TimelinesController < ApplicationController

  def index
    @input_message = params[:id]? Timeline.find(params[:id]) : Timeline.new
    @timeline = Timeline.includes(:user).user_filter(params[:filter_user_id]).order('updated_at DESC')

    @users = User.all
  end

  def update
    timeline = Timeline.find(params[:id])
    timeline.attributes = input_message_param
    if timeline.valid?
      timeline.save
    else
      flash[:alert] = timeline.errors.full_messages
    end
    redirect_to action: :index    
  end

  def create
    timeline = Timeline.new
    timeline.attributes = input_message_param
    timeline.user_id = current_user.id
    
    if timeline.valid?
      timeline.save
    else
      flash[:alert] = timeline.errors.full_messages
    end
    redirect_to action: :index
  end

  def filter_by_user
    if params[:filter_user_id].present?
      redirect_to action: :index, filter_user_id: params[:filter_user_id]
    else
      redirect_to action: :index
    end
  end

  private
  def input_message_param
    params.require(:timeline).permit(:message)
  end

end
