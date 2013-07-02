class AuthorsController < ApplicationController
  def show
    @author = Author.find_by(screen_name: params[:id])
  end
end
