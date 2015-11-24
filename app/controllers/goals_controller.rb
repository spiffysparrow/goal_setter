class GoalsController < ApplicationController

  before_action :require_logged_in, only: [:new, :create]


  def index
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def new
    @goal = Goal.new
  end

  def edit

  end

  def create

    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  private
  def require_logged_in
    redirect_to new_session_url unless current_user
  end

  def goal_params
    params.require(:goal).permit(:title, :body, :private)
  end

end
