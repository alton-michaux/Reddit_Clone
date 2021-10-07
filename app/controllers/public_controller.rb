# frozen_string_literal: true

class PublicController < ApplicationController
  def index
    @communities = Community.all.limit(5)
    @posts = Post.all
  end

  
end
