class BugsController < ApplicationController


  def index
      @user= User.find(params[:user_id])
      authorize @user
      @project=Projectcode.find(params[:projectcode_id])
      authorize @project
      @bugs=Bug.where(:projectcode_id => params[:projectcode_id])
  end

  def new
       @user = current_user
       @project=Projectcode.find(params[:projectcode_id])  
       @bug=Bug.new
  end

  def create
      @bug=Bug.new(post_params)
      @bug.status='newer'
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
      if params[:bugstatus]=='resolved'&&@bug.status=='newer'
         flash[:error] = 'state cannot be change to resolved!!'
         render 'edit'
         return
         elsif params[:bugstatus]=='completed'&&@bug.status=='newer'
               flash[:error] = 'state cannot be change to completed!!'
               render 'edit'
         return 
         elsif params[:bugstatus]=='started'&&@bug.status=='newer' 
               @bug.assign
      end  
      if(@bug.update(post_params))
         redirect_to user_projectcode_bugs_path  
      else 
         render 'edit'
         return
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
      respond_to do |format|
        format.js
        format.html { redirect_to user_projectcode_bugs_path(params[:user_id],@bug.projectcode_id) , notice: 'Bug was successfully removedd.'}
        format.json { head :no_content }
      end
  end
  
  def markasreolved
      @bug=Bug.find(params[:id])
      authorize @bug
      if @bug.bugtype=='feature'
         @bug.complete
      else
         @bug.resolve
      end     
      redirect_to user_projectcode_bugs_path
  end  
  
  def assignbugtodeveloper
      @bug=Bug.find(params[:id])
      authorize @bug
      @bug.update(developer_id:params[:user_id])
      @bug.assign
      redirect_to user_projectcode_bugs_path(params[:user_id],@bug.projectcode_id)
  end 

  private
  def post_params
      params.require(:bug).permit(:title,:descryption,:screenshot,:deadline).merge(bugtype: params[:bugtype],projectcode_id:params[:projectcode_id],creator_id:params[:user_id],date:Date.today);
  end


end
