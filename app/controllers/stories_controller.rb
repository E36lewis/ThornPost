class StoriesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :authorize_user, only: [:edit, :update, :destroy]

   layout "editor", only: [:new, :edit, :create, :update]
  
  def index
	prepare_meta_tags title: "Stories" description:
	"These are the travels of people around this world."
  end  
  
  def show
    @story = Story.friendly.find(params[:id])
	prepare_meta_tags(title: @story.name, description: @story.description,
					  keywords: @story_keywords,
					  image: @story.picture.url(:large),
					  twitter: {card: "Summary_large_image"})
    @responses = @story.responses.includes(:user)
    @related_stories = @story.related_stories
    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the story_path, and we should do
    # a 301 redirect that uses the current friendly id.
    if request.path != story_path(@story)
      redirect_to @story, status: 301
    end
	
  end

  def new
    @story = Story.new_draft_for(current_user)
  end

  def create
    @story = current_user.stories.build(story_params)
    if @story.publish
      redirect_to @story, notice: "Successfully published the story!"
    else
      @story.unpublish
      flash.now[:alert] = "Could not update the story, Please try again"
      render :new
    end
  end

  def edit
  end

  def update
    @story.assign_attributes(story_params)
    if @story.publish
      redirect_to @story, notice: "Successfully published the story!"
    else
      @story.unpublish
      flash.now[:alert] = "Could not update the story, Please try again"
      render :edit
    end
  end

  def destroy
    @story.destroy
    redirect_to root_url, notice: "Successfully deleted the story"
  end

  # TODO: ideally move this to a separate controller?
  def create_and_edit
    @story = current_user.stories.build(story_params)
    @story.save_as_draft
    redirect_to edit_story_url(@story)
  end
  
    private

    def story_params
      params.require(:story).permit(:title, :body, :all_tags, :picture)
    end

    def authorize_user
      begin
        @story = current_user.stories.find(params[:id])
      rescue
        redirect_to root_url
      end
    end
  end
