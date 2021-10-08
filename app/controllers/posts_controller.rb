# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_account!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all
  end

  def show; end

  def edit; end

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

  def update
    respond_to do |format|
      if @post.update(post_values)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        pp "update error: #{@post.errors.to_a} \n error on: #{@post.as_json}"
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
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
