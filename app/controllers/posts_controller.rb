# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_account!, except: %i[index show]
  before_action :set_post, only: [:show]
  #   before_action :post_values, only: [:create]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @community = Community.find(params[:community_id])
    @post = Post.new
    @post.community_id = params[:community_id]
  end

  def create
    @community = Community.find(params[:community_id])
    @post = Post.new post_values

    @post.account_id = current_account.id
    @post.community_id = @community.id

    if @post.save
      redirect_to community_path(id: @post.community_id)
    else
      @community = Community.find(params[:community_id])
      render :new
    end
  end

  def destroy; end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_values
    params.require(:post).permit(:title, :body, :account_id, :community_id)
  end
end
