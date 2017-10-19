class MainController < ApplicationController
  def index
    @tasks = Task.all
  end
end
