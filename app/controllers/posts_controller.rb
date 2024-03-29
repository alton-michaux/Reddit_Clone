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
    if member?
      if @post.save
        flash.notice = 'Post created!'
        redirect_to community_path(id: @post.community_id)
      else
        flash.alert = 'Post not created'
        render :new
      end
    else
      flash.alert = 'Must be a member to post'
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

  def upvote
    @post = Post.find(params[:id])
    @post.upvote_by current_account
    redirect_to community_post_path(@post)
  end

  def downvote
    @post = Post.find(params[:id])
    @post.downvote_by current_account
    redirect_to community_post_path(@post)
  end

  # def trending(int)
  #   communities = Hash.new(0)
  #   @posts.each { |post| communities[post.community_id] += 1 }
  #   sorted_communities = communities.sort_by {|k,v| v}.reverse
  #   id = sorted_communities[int][0]
  #   community = Community.find_by(id: id)
  # end

  private

  def member?
    @community.subscriptions.each do |sub|
      sub.account_id == current_account.id
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_values
    params.require(:post).permit(:title, :body, :account_id, :community_id)
  end

  def catch_not_found(err)
    Rails.logger.debug('There was a not found exception in posts_controller.')
    flash.alert = err.to_s
    redirect_to community_posts_url
  end

  def catch_no_method(err)
    Rails.logger.debug("There was a 'NoMethodError' in posts_controller: #{err} (the object may have been created without all it's attributes.)")
    flash.alert = err.to_s
    redirect_to community_posts_url
  end
end
