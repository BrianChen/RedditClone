class SubsController < ApplicationController

  before_action :validate_moderator, only: [:edit]

  def new
    render :new
  end

  def index
    @subs = Sub.all
    render :index
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def validate_moderator
    @sub = Sub.find(params[:id])
    if current_user.id != @sub.moderator_id
      redirect_to sub_url(@sub)
    end
  end
end
