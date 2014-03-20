class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]  #add in edit here

  # for tagging:
  def index
    if params[:tag]
      @microposts = Micropost.tagged_with(params[:tag])
    else
      @microposts = Micropost.all
    end
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Gif post created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'

    end
  end

  #add editing functionality
  #def edit 
   # @micropost.edit
    #@micropost = Micropost.find(params[:id])
  #end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  def tagged #more for tagging
    if params[:tag].present?
      @microposts = Micropost.tagged_with(params[:tag])
    else
      @microposts = Micropost.postall
    end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :tag_list)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end