class StoriesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :authorize_user, only: [:edit, :update, :destroy]

   layout "editor", only: [:new, :edit, :create, :update]
   
    def show
    @storie = Storie.find(params[:id])
    @responses = @storie.responses.includes(:user)
    #@related_posts = @post.related_posts
    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the post_path, and we should do
    # a 301 redirect that uses the current friendly id.
    if request.path != storie_path(@storie)
      redirect_to @storie, status: 301
    end
  end

  def new
    @storie = Storie.new(current_user)
  end

  def create
    @storie = current_user.posts.build(storie_params)
    if @storie.publish
      redirect_to @storie, notice: "Successfully published the post!"
    else
      @storie.unpublish
      flash.now[:alert] = "Could not update the post, Please try again"
      render :new
    end
  end

  def edit
  end

  def update
    @storie.assign_attributes(storie_params)
    if @storie.publish
      redirect_to @storie, notice: "Successfully published the storie!"
    else
      @storie.unpublish
      flash.now[:alert] = "Could not update the storie, Please try again"
      render :edit
    end
  end

  def destroy
    @storie.destroy
    redirect_to root_url, notice: "Successfully deleted the storie"
  end

  # TODO: ideally move this to a separate controller?
  def create_and_edit
    @storie = current_user.stories.build(storie_params)
    #@post.save_as_draft
    redirect_to edit_storie_url(@storie)
  end
  
    private

    def post_params
      params.require(:storie).permit(:title, :body, :all_tags, :picture)
    end

    def authorize_user
      begin
        @storie = current_user.storie.find(params[:id])
      rescue
        redirect_to root_url
      end
    end
  end
