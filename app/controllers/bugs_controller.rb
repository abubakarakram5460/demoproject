class BugsController < ApplicationController


  def index
  @bugs=Bug.where(:projectcode_id => params[:projectcode_id])
  end

  def new
    @bug=Bug.new
  end

  def create
    @bug=Bug.new(post_params)
     if(@bug.save)
      redirect_to user_projectcode_bugs_path
     else
     if(@bug.errors.count>0)
           render 'new'
     end
     end
  end

  def update
    @bug=Bug.find(params[:id]);
    authorize @bug
    if(@bug.update(post_params))
       redirect_to user_projectcode_bugs_path  
    else 
      render 'edit'
    end
  end
  
  def edit
    @user=User.find(params[:user_id]);
    @bug=Bug.find(params[:id]);
  end

  def destroy
    @bug=Bug.find(params[:id])
    authorize @bug
    @bug.destroy 
    redirect_to user_projectcode_bugs_path(params[:user_id],@bug.projectcode_id) 
  end
  
  def assignbugtodeveloper
   @bug=Bug.find(params[:id])
   authorize @bug
   @bug.update(developer_id:params[:user_id],status:'started')
   redirect_to user_projectcode_bugs_path(params[:user_id],@bug.projectcode_id)
  end 

  def show
  end
  
  private
  def post_params
  params.require(:bug).permit(:title,:descryption,:screenshot).merge(bugtype: params[:bugtype],status:params[:bugstatus],projectcode_id:params[:projectcode_id],creator_id:params[:user_id],deadline:params[:deadline][:date],date:params[:report][:date]);
  end


end
