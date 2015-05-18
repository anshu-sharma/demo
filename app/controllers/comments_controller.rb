class CommentsController < ApplicationController
before_filter :logged_in_user, only: [:create, :destroy]	 


def index
	@comments=Comment.all	
end



def create
	# @micropost = Micropost.find(params[:micropost_id])
 #    @comment = Comment.new(params[:comment])
 #    @comment.micropost = @micropost
 #    @comment.user = current_user
 #    if @comment.save
 #       flash[:success] = "Comment created!"
 #       redirect_to current_user
 #    else
    @micropost = Micropost.find(params[:micropost_id])
    @comment= @micropost.comments.create(comment_params)
    @comment.user = current_user
      if @comment.save
          flash[:success] = "Comment created!"
          redirect_to root_url
      else
          render 'microposts/comment'
      end
end
def destroy
    @comment=Comment.find(params[:id])
    @comment.destroy
    redirect_to root_url
    end
end

private

def comment_params
	params.require(:comment).permit(:content)

end
