class PostsController < ApplicationController

  before_action :validate_author, only: [:edit, :update]

  def new
    @subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    # @post.sub_id = params[:post][:sub_id][0]
    if @post.save
      redirect_to post_url(@post)
    else
      @subs = Sub.all
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    parent_sub = @post.sub
    @post.destroy
    redirect_to sub_url(parent_sub)
  end

  private
  def post_params
    # debugger
    params.require(:post).permit(:title, :url, :content, sub_id: [])
  end

  def validate_author
    @post = Post.find(params[:id])
    if current_user.nil?
      redirect_to new_session_url
    elsif current_user.id != @post.author_id
      redirect_to post_url(@post)
    end
  end

end
