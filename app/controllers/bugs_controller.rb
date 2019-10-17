class BugsController < ApplicationController
  def index
  @bugs=Bug.where(:projectcode_id => params[:projectcode_id])
          
  end

  def new
    @bug=Bug.new
     
  end

  def create
    puts "in create"
    puts params
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def show
  end
end
