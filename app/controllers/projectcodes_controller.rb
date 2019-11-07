class ProjectcodesController < ApplicationController
  
    before_action :setuser, only: [:index,:assignresource,:new]
    before_action :setproject, only: [:show,:update,:destroy,:removeuser,:getallusers,:assignresource]
   
    def index
        authorize @user
        @allprojects = current_user.projectcodes
    end  

    def new
        authorize @user
        @project=Projectcode.new
    end
   
    def show
        @creators=User.getallcreators(@project)
        @developers=User.getalldevelopers(@project)
    end   
    
    def create       
           @project=Projectcode.new(name:post_params[:name],manager_id:current_user.id);
           authorize @project
        if @project.save
            redirect_to user_projectcodes_path(current_user.id)
        elsif(@project.errors.count>0)
              render 'new'
        end 
    end   
    
    def edit
        @user=User.getuser(current_user.id)
        @project=Projectcode.getproject(params[:id])
    end

    def update
        if(@project.update(post_params))
           redirect_to user_projectcode_path(params[:user_id],@project)
        else
           render 'edit'  
        end
    end

    def destroy 
        Bug.deletespecificprojectbugs(@project)
        Userproject.deletespecificprojectassignusers(@project)
        @project.destroy
        respond_to do |format|
              format.js
              format.html { redirect_to user_projectcodes_path(@project.manager_id) , notice: 'Project was successfully removedd.'}
              format.json { head :no_content }
         end
    end

    def removeuser
        @userproject=Userproject.getprojectuser(params[:user_id])
        @userproject.destroy
        redirect_to user_projectcode_path(params[:user_id],@project)
    end

    def getallusers
        @developers=User.get_all_developers_excluding_specificproject(@project)
        @creators=User.get_all_creators_excluding_specificproject(@project)
        @userproject=Userproject.new
    end
    def setuser
        @user= User.getuser(params[:user_id])
    end

    def setproject
        @project=Projectcode.getproject(params[:id])
        authorize @project
    end    
    
    def assignresource
        @userproject=Userproject.new(user_id:@user.id,projectcode_id:params[:id],usertype:@user.type)
          if @userproject.save
              redirect_to user_projectcode_path(@user,params[:id])
          else
              render 'getallusers'
          end
    end  

    def post_params
        params.require(:projectcode).permit(:name)
    end
 
  end
