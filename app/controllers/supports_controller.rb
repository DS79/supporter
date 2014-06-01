class SupportsController < ApplicationController

  before_action :find_support, only: [:edit, :update, :destroy, :change]
  
  def index   
    if params[:search]
      @supports = Support.search(params[:search]).paginate(:page => params[:page], :per_page => 5)
    else
      @supports = Support.all.order("stage ASC").paginate(:page => params[:page], :per_page => 5) 
    end

  end

  def new
    @support = Support.new 

  end

  def create
    @support = Support.new support_attributes
    @support.stage ||= false 
    if @support.save
      flash[:notice] = "support created sucessfully"
      redirect_to supports_path
    else
      flash.now[:alert] = "problem creating support"
      render :new
    end
  end

  def edit   
  end

  def update
    if @support.update_attributes support_attributes
      flash[:notice] = "support updated sucessfully"
      redirect_to supports_path
    else
      flash.now[:alert] = "problem updating support"
      render :edit
    end

  end

  def destroy
    @support.destroy
    redirect_to supports_path , notice: "support deleted sucessfully"
  end

  def change
    if @support.stage == false
      @support[:stage] = true
       @support.save    
    else
      @support[:stage] = false
       @support.save    
    end
    redirect_to supports_path 
  end


  private

  def find_support
    @support = Support.find params[:id]    
  end

  def support_attributes
    params.require(:support).permit(:name, :email, :department, :message)
  end
  

end


