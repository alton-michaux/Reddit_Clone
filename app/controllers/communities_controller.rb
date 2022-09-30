# frozen_string_literal: true

class CommunitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  rescue_from StandardError, with: :catch_no_method
  before_action :authenticate_account!, except: %i[index show]
  before_action :set_community, except: %i[index create new]

  def index
    @communities = Community.all
  end

  def show
    @posts = @community.posts
    @subscriber_count = @community.subscribers.count
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_values)
    @community.account_id = current_account.id
    if @community.save
      flash.notice = 'Community created successfully'
      redirect_to community_path(id: @community.id)
    else
      flash.alert = 'Something went wrong, community not created'
      render :new
    end
  end

  def update
    respond_to do |format|
      if @community.update(community_values)
        flash.notice = 'Community successfully updated'
        format.html { redirect_to @community, notice: 'Community was successfully updated.' }
        format.json { render :show, status: :ok, location: @community }
      else
        flash.alert = 'Something went wrong'
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @community.update(community_values)
        format.html { redirect_to @community, notice: 'Community was successfully updated.' }
        format.json { render :show, status: :ok, location: @community }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @community.destroy
    respond_to do |format|
      flash.notice = 'Community destroyed'
      format.html { redirect_to communities_url, notice: 'Community was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_community
    @community = Community.find(params[:id])
  end

  def community_values
    params.require(:community).permit(:name, :summary, :account_id, :url, :rules)
  end

  def catch_not_found(err)
    Rails.logger.debug('There was a not found exception in communities_controller.')
    flash.alert = err.to_s
    redirect_to communities_url
  end

  def catch_no_method(err)
    Rails.logger.debug("There was a 'NoMethodError' in communities_controller: #{err} (the object may have been created without all it's attributes.)")
    flash.alert = err.to_s
    redirect_to communities_url
  end
end
