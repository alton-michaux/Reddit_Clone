# frozen_string_literal: true

class CommunitiesController < ApplicationController
  before_action :authenticate_account!, except: %i[index show]

  def index
    @communities = Community.all
  end

  def show; end

  def new
    @community = Community.new
  end

  def create; end
end
