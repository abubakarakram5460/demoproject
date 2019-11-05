class ProjectcodesController < ApplicationController
  #  after_action :verify_authorized
 
    def index
        @user= User.getuser(params[:user_id])
        authorize @user
        @allprojects = current_user.projectcodes
    end  

    def new
        @user=User.getuser(params[:user_id])
        authorize @user
        @project=Projectcode.new
    end
   
    def show
        @specificproject=Projectcode.getproject(params[:id])
        authorize @specificproject
        @creators=User.getallcreators(@specificproject)
        @developers=User.getalldevelopers(@specificproject)
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
        @project=Projectcode.getproject(params[:id])
        authorize @project
        if(@project.update(post_params))
           redirect_to user_projectcode_path(params[:user_id],@project)
        else
           render 'edit'  
        end
    end

    def destroy 
        @project=Projectcode.getproject(params[:id])
        authorize @project
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
        puts "heheheheehehheheheh"
        @userproject=Userproject.getprojectuser(params[:user_id])
        @project=Projectcode.getproject(params[:project_id])
        authorize @project
         @userproject.destroy
        redirect_to user_projectcode_path(params[:user_id],@project)
    end

    def getallusers
        @project=Projectcode.getproject(params[:project_id]);
        authorize @project
        @developers=User.get_all_developers_excluding_specificproject(@project)
        @creators=User.get_all_creators_excluding_specificproject(@project)
        @userproject=Userproject.new
    end
    
    def assignresource
        @project=Projectcode.getproject(params[:project_id]);
        @user=User.getuser(params[:resource_id]);
        @userproject=Userproject.new(user_id:@user.id,projectcode_id:params[:project_id],usertype:@user.type)
        authorize @project
          if @userproject.save
              redirect_to user_projectcode_path(@user,params[:project_id])
          else
              render 'getallusers'
          end
    end  

    def post_params
    params.require(:projectcode).permit(:name)
    end
 
  end
