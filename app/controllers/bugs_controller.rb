class BugsController < ApplicationController
    

  def index
      @user= User.getuser(params[:user_id])
      authorize @user
      @project=Projectcode.getproject(params[:projectcode_id])
      authorize @project
      @bugs=Bug.getspecificprojectbugs(params[:projectcode_id])
  end

  def new
       @user = current_user
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
       @bug=Bug.getbug(params[:id]);
       authorize @bug
       nmbr= Bug.setstatus(params[:bugstatus],@bug)
       if nmbr==2
          flash[:error] = 'state cannot be change to completed!!'
          render 'edit'
       elsif nmbr==1 
             flash[:error] = 'state cannot be change to resolved!!'
             render 'edit'
       elsif nmbr==3 
              flash[:error] = 'QA cannot be change to resolved or completed state!!'
              render 'edit'       
       else    
            if(@bug.update(post_params))
                redirect_to user_projectcode_bugs_path  
            else 
                render 'edit'
                return
            end
        end
  end
  
  def edit
      @user=User.getuser(params[:user_id]);
      @bug=Bug.getbug(params[:id]);
  end

  def destroy
      @bug=Bug.getbug(params[:id])
      authorize @bug
      @bug.destroy 
      respond_to do |format|
        format.js
        format.html { redirect_to user_projectcode_bugs_path(params[:user_id],@bug.projectcode_id) , notice: 'Bug was successfully removedd.'}
        format.json { head :no_content }
      end
  end
  
  def markasreolved
      @bug=Bug.getbug(params[:id])
      authorize @bug
      Bug.setbugtype(@bug)    
      redirect_to user_projectcode_bugs_path
  end  
  
  def assignbugtodeveloper
      @bug=Bug.getbug(params[:id])
      authorize @bug
      Bug.setbug(@bug,params[:user_id])
      @bug.assign
      redirect_to user_projectcode_bugs_path(params[:user_id],@bug.projectcode_id)
  end
  def showspecificbugs
      @user=User.getuser(params[:user_id])
      authorize @user
      @bugs=Bug.getspecificuserbugs(@user)
  end  

  private
  def post_params
      params.require(:bug).permit(:title,:descryption,:screenshot,:deadline).merge(bugtype: params[:bugtype],projectcode_id:params[:projectcode_id],creator_id:params[:user_id],date:Date.today);
  end


end
