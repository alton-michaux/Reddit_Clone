# frozen_string_literal: true

class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  rescue_from StandardError, with: :catch_no_method
  before_action :authenticate_account!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all
    @community = Community.find(params[:community_id])
  end

  def show; end

  def edit; end

  def new
    @community = Community.find(params[:community_id])
    @post = Post.new
  end

  def create
    @community = Community.find(params[:community_id])
    @post = Post.new post_values
    @post.community_id = params[:community_id]
    @post.account_id = current_account.id
    # @subscription = Subscription.new(account_id: current_account.id, community_id: @community.id)
byebug
    if @post.account.communities.include?(@community)
      if @post.save
        flash.notice = "Post created!"
        redirect_to community_path(id: @post.community_id)
      else
        flash.alert = "Post not created"
        render :new
      end
    else
      flash.alert = "Must be a member to post"
      render :index
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_values)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to community_posts_url(@post.community_id), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_values
    params.require(:post).permit(:title, :body, :account_id, :community_id)
  end

  def catch_not_found(e)
    Rails.logger.debug('There was a not found exception in posts_controller.')
    flash.alert = e.to_s
    redirect_to community_posts_url
  end

  def catch_no_method(e)
    Rails.logger.debug("There was a 'NoMethodError' in posts_controller: #{e} (the object may have been created without all it's attributes.)")
    flash.alert = e.to_s
    redirect_to community_posts_url
  end
end
