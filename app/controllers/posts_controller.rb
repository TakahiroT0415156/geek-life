class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    search = params[:search]
    tag_id = params[:tag_id]
    input_posts = Post.joins(:user).where("geek LIKE ? OR username LIKE ? OR postion LIKE ? OR region LIKE ? OR course LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")

    if search.present? && tag_id.present?
      post = Tag.find(tag_id).posts
      @posts = input_posts && post
    elsif search.present?
      @posts = input_posts
    elsif tag_id.present?
      @posts =  Tag.find(tag_id).posts
    else
      @posts = Post.all
    end

    @posts = @posts.order(created_at: :DESC)
    random = User.all
    @user = random.sample
  end

  def new
    @post = Post.new
    if params[:tag]
      @tag = Tag.create(name: params[:tag])
      if @tag.save
      else
        render :new
      end
    end
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      redirect_to root_path
    else
      redirect_to action: "new"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:geek, tag_ids: [])
  end
end
