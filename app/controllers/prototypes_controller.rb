class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy] 
  def index
    @prototypes = Prototype.all.includes(:user)
  end
  def new
    @prototype = Prototype.new
  end
  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end
  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end
  def edit
    @prototype = Prototype.find(params[:id])
    unless user_signed_in? && current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end
  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(params[:id])
    else
      render :edit
    end
  end
  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.destroy
      redirect_to root_path
    end
  end
  private

  def prototype_params
    params_keys = [:title, :catch_copy, :concept, :image]
    params.require(:prototype).permit(params_keys).merge(user_id: current_user.id)
  end
end
