class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    if params[:search].present? && params[:tag_id].present?
      search = params[:search]
      posts = Post.joins(:user).where("geek LIKE ? OR username LIKE ? OR postion LIKE ? OR region LIKE ? OR course LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
      post = Tag.find(params[:tag_id]).posts
      @posts = posts && post
    elsif params[:search].present?
      search = params[:search]
      @posts = Post.joins(:user).where("geek LIKE ? OR username LIKE ? OR postion LIKE ? OR region LIKE ? OR course LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    elsif params[:tag_id].present?
      @posts =  Tag.find(params[:tag_id]).posts
    else
      @posts = Post.all
    end
    @posts = @posts.shuffle

    random = User.all
    @user = random.sample
  end

  def new
    @post = Post.new
    if params[:tag]
      tag = Tag.create(name: params[:tag])
      if tag.save
        redirect_to action: "new"
      else
        redirect_to action: "new"
      end
    end
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      redirect_to action: "index"
    else
      redirect_to action: "new"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to :action => "show", :id => post.id
    else
      redirect_to :action => "index"
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to action: :index
  end

  private
  def post_params
    params.require(:post).permit(:geek, tag_ids: [])
  end
end
