    class BugsController < ApplicationController
    before_action :set_user, only: [:index, :edit, :new, :showspecificbugs]
    before_action :authorize_user, only: [:index, :showspecificbugs]
    
    before_action :set_project, only: [:index, :new]
    before_action :authorize_project, only: [:index]

    before_action :set_bug, only: [:markasreolved, :update, :destroy, :assignbugtodeveloper, :edit]
    before_action :authorize_bug, only: [:edit, :update, :destroy]

    def index
      @bugs=Bug.get_specificproject_bugs(params[:projectcode_id])
    end
   
    def new 
      @bug=Bug.new
    end

    def create
      @bug=Bug.create(post_params)
      if @bug.errors.count==0
          redirect_to user_projectcode_bugs_path
      else
            render 'new'
      end
    end

    def update
      if(@bug.update(post_params))
          redirect_to user_projectcode_bugs_path  
      else 
            render 'edit'
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
      @bug.set_next_state!  
      redirect_to user_projectcode_bugs_path
    end  
    
    def assignbugtodeveloper
      @bug.setbug(params[:user_id])
      @bug.set_next_state!
      redirect_to user_projectcode_bugs_path(params[:user_id], @bug.projectcode_id)
    end
  
    def showspecificbugs
      @bugs=Bug.get_specificuser_bugs(@user)
    end  

    private
    def post_params
      params.require(:bug).permit(:title, :descryption, :screenshot, :deadline).
      merge(projectcode_id: params[:projectcode_id], creator_id: params[:user_id], date: Date.today, bugtype: params[:bugtype],status: params[:bugstatus] );
    end
    
    def set_project
      @project=Projectcode.get_project(params[:projectcode_id])
    end 

    def authorize_user
      authorize @user
    end
    
    def authorize_project
      authorize @project
    end 
    
    def set_user
      @user= User.get_user(params[:user_id])
    end  
    def set_bug
      @bug=Bug.get_bug(params[:id])
    end  
    
    def authorize_bug
      authorize @bug
    end


end
