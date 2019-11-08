    class BugsController < ApplicationController
    before_action :setuser, only: [:index, :edit, :new, :showspecificbugs]
    before_action :authorizeuser, only: [:index, :showspecificbugs]
    
    before_action :setproject, only: [:index, :new]
    before_action :authorizeproject, only: [:index]

    before_action :setbug, only: [:markasreolved, :update, :destroy, :assignbugtodeveloper, :edit]
    before_action :authorizebug, only: [:edit, :update, :destroy]

  def index
      @bugs=Bug.getspecificprojectbugs(params[:projectcode_id])
  end
   
  def new 
       @bug=Bug.new
  end

	def create
			puts "params belowww__________"
			puts params 
      @bug=Bug.create(post_params)
      if @bug.errors.count==0
        	redirect_to user_projectcode_bugs_path
      else
        		render 'new'
      end
  end

  def update
       nmbr= Bug.setstatus(params[:bugstatus], @bug)
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
     
  end

  def destroy
      @bug.destroy 
      respond_to do |format|
      	format.js
      end
  end
  
  def markasreolved
      Bug.setbugtype(@bug)    
      redirect_to user_projectcode_bugs_path
  end  
  
  def assignbugtodeveloper
      Bug.setbug(@bug, params[:user_id])
      @bug.assign
      redirect_to user_projectcode_bugs_path(params[:user_id], @bug.projectcode_id)
  end
 
  def showspecificbugs
      @bugs=Bug.getspecificuserbugs(@user)
  end  

  private
  def post_params
			params.require(:bug).permit(:title, :descryption, :screenshot, :deadline, :bugtype).
			merge(projectcode_id: params[:projectcode_id], creator_id: params[:user_id], date:Date.today,bugtype: params[:bugtype]);
  end
  
  def setproject
      @project=Projectcode.getproject(params[:projectcode_id])
  end 

  def authorizeuser
      authorize @user
  end
  
  def authorizeproject
      authorize @project
  end 
  
  def setuser
      @user= User.getuser(params[:user_id])
  end  
  def setbug
      @bug=Bug.getbug(params[:id])
  end  
  
  def authorizebug
      authorize @bug
  end


end
