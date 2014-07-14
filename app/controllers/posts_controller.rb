class PostsController < ApplicationController
  # once routes are defined by resources :posts in routes.rb, define the actions of the routes here
  # only index, show, new and edit render templates (.html.erb)
  def index
  # show me everything inside my database that is a post
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    # pass into id the parameter (/posts/2)
    # find the post that has the id associated with the input parameter
  end

  def new
  # send "create" action to server
    # authenticate user if there is no current user
    before_filter authenticate_user! if !current_user
    @post = Post.new
  end

  def edit
  # send "update" action to server
    before_filter authenticate_user! if !current_user
    @post = Post.find(params[:id])
  end

  # create, update and destroy run on server only (actions called from view
  # to manipulate data on server)
  def create
    # make a new post and enter the post_params into it
    @post = Post.new(post_params)

    # make sure each tweet is associated with a user id
    @post.user_id = current_user.id

    if @post.save
      # function redirect_to, parameter: post_path, hash: notice
      redirect_to post_path(@post), notice: "Post saved!"
    else 
      # error - re-render the "new" view
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:content) #"it's ok to update content in database thru website form"
        # in "post" table, permit content field to be updated
    end
end
