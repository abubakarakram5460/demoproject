class ProjectcodesController < ApplicationController

 
 def index
 @allprojects=Projectcode.where(manager_id:params[:user_id])   
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
      @creators=@specificproject.users.where(:type => "Creator")
      @developers=@specificproject.users.where(:type => "Developer")
      

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


  def post_params
    params.require(:projectcode).permit(:name)
  end
 
  end
