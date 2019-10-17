class ProjectcodesController < ApplicationController

 
 def index
  #  @allprojects=Projectcode.where(manager_id:params[:user_id])   
  @allprojects = current_user.projectcodes
  puts @allprojects  
 end  

def new
    @user=User.find(params[:user_id])
    if(@user.type=="Manager")
     @project=Projectcode.new
    end

    end
    def show
     @specificproject=Projectcode.find(params[:id])
     if(current_user.type=="Manager")
     @creators=@specificproject.users.where(:type => "Creator")
     @developers=@specificproject.users.where(:type => "Developer")
     elsif(current_user.type=="Creator")
         
      
     end
    end   
    
    def create
     if(post_params[:name].blank?)
      post_params[:name]=nil
    end
     @project=Projectcode.create(name:post_params[:name],manager_id:params[:user_id]);
     if @project.errors.count>0
        render 'new'
     end 
      
    end   
    
    def edit
        @user=User.find(params[:user_id])
        @project=Projectcode.find(params[:id])

    end
    def update

        @project=Projectcode.find(params[:id])
        if(@project.update(post_params))
          redirect_to user_projectcode_path(params[:user_id],@project)
        else
          render 'edit'  
        end
    end
    def destroy
      if(params[:id])  
       @project=Projectcode.destroy(params[:id])
       redirect_to user_projectcodes_path(params[:user_id])  
      end
    end  
    def removeuser
        @user=Userproject.find_by(:user_id => params[:user_id])
        Userproject.destroy(@user.id)
        @project=Projectcode.find(params[:project_id])
        redirect_to user_projectcode_path(params[:user_id],@project)
    end    
    def getallusers
     @developers=Developer.all
     @creators=Creator.all
     @project=Projectcode.find(params[:project_id]);
     @userproject=Userproject.new
    end
    
    def assignresource
    @project=Projectcode.find(params[:project_id]);
    @user=User.find(params[:resource_id]);
    @userproject=Userproject.new(user_id:@user.id,projectcode_id:params[:project_id],usertype:@user.type)
    @developers=Developer.all
    @creators=Creator.all
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
