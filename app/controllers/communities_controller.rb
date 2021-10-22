# frozen_string_literal: true

class CommunitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  rescue_from StandardError, with: :catch_no_method
  before_action :authenticate_account!, except: %i[index show]
  before_action :set_community, only: %i[show edit update destroy]

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
    @community = Community.new community_values

    if @community.save
      redirect_to community_path(id: @community.id)
    else
      @community = Community.find(params[:id])
      render :new
    end
  end

  def update
    respond_to do |format|
      if @community.update(community_values)
        format.html { redirect_to @community, notice: 'Community was successfully updated.' }
        format.json { render :show, status: :ok, location: @community }
      else
        pp "update error: #{@community.errors.to_a} \n error on: #{@community.as_json}"
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @community.destroy
    respond_to do |format|
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

  def catch_not_found(e)
    Rails.logger.debug('There was a not found exception.')
    flash.alert = e.to_s
    redirect_to communities_url
  end

  def catch_no_method(e)
    Rails.logger.debug("There was a 'NoMethodError': #{e} (the object may have been created without all it's attributes.)")
    flash.alert = e.to_s
    redirect_to communities_url
  end
end
