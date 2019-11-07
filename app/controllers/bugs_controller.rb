class BugsController < ApplicationController
    before_action :setuser, only: [:index,:edit,:new,:showspecificbugs]
    before_action :setbug, only: [:markasreolved,:update,:destroy,:assignbugtodeveloper]

  def index
      authorize @user
      @project=Projectcode.getproject(params[:projectcode_id])
      authorize @project
      @bugs=Bug.getspecificprojectbugs(params[:projectcode_id])
  end
   
  def new
       @project=Projectcode.getproject(params[:projectcode_id])  
       @bug=Bug.new
  end

  def create
      @bug=Bug.create(post_params)
      if @bug.errors.count==0
            redirect_to user_projectcode_bugs_path
      else
          if(@bug.errors.count>0)
                render 'new'
          end
      end
  end

  def update
       nmbr= Bug.setstatus(params[:bugstatus],@bug)
       if nmbr==2
          showmessage("state cannot be change to completed!!")
       elsif nmbr==1 
             showmessage("state cannot be change to resolved!!")      
       else    
            if(@bug.update(post_params))
                redirect_to user_projectcode_bugs_path  
            else 
                render 'edit'
            end
        end
  end
  
  def showmessage(message)
      flash[:error] = message
      render 'edit'
  end  

  def edit
      @bug=Bug.getbug(params[:id]);
  end

  def destroy
      @bug.destroy 
      respond_to do |format|
        format.js
        format.html { redirect_to user_projectcode_bugs_path(params[:user_id],@bug.projectcode_id) , notice: 'Bug was successfully removedd.'}
        format.json { head :no_content }
      end
  end
  
  def setuser
      @user= User.getuser(params[:user_id])
  end
  def setbug
      @bug=Bug.getbug(params[:id])
      authorize @bug
  end   
  
  def markasreolved
      Bug.setbugtype(@bug)    
      redirect_to user_projectcode_bugs_path
  end  
  
  def assignbugtodeveloper
      Bug.setbug(@bug,params[:user_id])
      @bug.assign
      redirect_to user_projectcode_bugs_path(params[:user_id],@bug.projectcode_id)
  end
  def showspecificbugs
      authorize @user
      @bugs=Bug.getspecificuserbugs(@user)
  end  

  private
  def post_params
      params.require(:bug).permit(:title,:descryption,:screenshot,:deadline).merge(bugtype: params[:bugtype],projectcode_id:params[:projectcode_id],creator_id:params[:user_id],date:Date.today);
  end


end
