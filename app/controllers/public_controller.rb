# frozen_string_literal: true

class PublicController < ApplicationController
  def index
    @communities = Community.all.limit(5)
    @posts = Post.order(id: :desc).limit(20)
  end
<<<<<<< HEAD


=======
>>>>>>> cd16a5dc3e01152f2d4e43b5f49e1bf704eb7536
end
