class ProjectcodesController < ApplicationController
  
    before_action :setuser, only: [:index, :assignresource, :new, :edit]
    before_action :authorizeuser, only: [:index, :new]
    
    before_action :setproject, only: [:show , :update, :destroy, :removeuser, :getallusers, :assignresource, :edit]
    before_action :authorizeproject, only: [:show, :update, :destroy, :removeuser, :getallusers, :assignresource]
    
    def index
        @allprojects = current_user.projectcodes
    end  

    def new
        @project= Projectcode.new
    end
   
    def show
        @creators= User.getallcreators(@project)
        @developers= User.getalldevelopers(@project)
    end   
    
    def create       
        @project= Projectcode.new(name: post_params[:name], manager_id: current_user.id);
          authorize @project
        if @project.save
            redirect_to user_projectcodes_path(current_user.id)
        else 
              render 'new'
        end 
    end   
    
    def edit
    end

    def update
        if(@project.update(post_params))
            redirect_to user_projectcode_path(params[:user_id] , @project)
        else
              render 'edit'  
        end
    end

    def destroy 
        @project.destroy
        respond_to do |format|
          format.js
        end
    end

    def removeuser
        Userproject.getprojectuser(params[:user_id]).destroy
        redirect_to user_projectcode_path(params[:user_id] , @project)
    end

    def getallusers
        @developers= User.get_all_developers_excluding_specificproject(@project)
        @creators= User.get_all_creators_excluding_specificproject(@project)
    end
  
    
    def assignresource
        @userproject= Userproject.new(user_id: @user.id, projectcode_id: params[:id], usertype: @user.type)
          if @userproject.save
              redirect_to user_projectcode_path(@user, params[:id])
          else
              render 'getallusers'
          end
    end 
     
    private
    
    def setuser
        @user= User.getuser(params[:user_id])
    end

    def setproject
        @project= Projectcode.getproject(params[:id])
    end 
    def authorizeproject
        authorize @project
    end 
    
    def authorizeuser
        authorize @user
    end   

    def post_params
        params.require(:projectcode).permit(:name)
    end
 
  end
