class PostsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        @posts = Post.order("created_at DESC")
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        if @post.valid?
            @post.save
            redirect_to root_path
        else
            render :new
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            redirect_to root_path
        else
            render :edit
        end
    end
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy
    end

    def like
        @post = Post.find(params[:id])
        return redirect_to post_path(@post.id) if @post.user == current_user
        if Like.find_by(user_id: current_user.id, post_id: @post.id).present?
            render :show 
        else
            Like.create(user_id: current_user.id, post_id: @post.id)
            like_count = @post.likes.length
            render json: {count: like_count}
        end
    end

    def like_cancel
        @post = Post.find(params[:id])
        return redirect_to post_path(@post.id) if @post.user == current_user
        like = Like.find_by(user_id: current_user.id, post_id: @post.id)
        like.destroy
        like_count = @post.likes.length
        render json: {count: like_count}
    end

    def like_lists
        @post = Post.find(params[:id])
        @likes = @post.likes
    end

    private
    def post_params
        params.require(:post).permit(:title, :content, :image).merge(user_id: current_user.id)
    end
end
