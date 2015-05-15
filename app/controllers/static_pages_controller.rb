<<<<<<< HEAD
class StaticPagesController < ApplicationController #it means StaticPagesController inherited from Rails class ApplicationController 
  
  def index
  
  end

  def home
    if logged_in?
  @micropost=current_user.microposts.build 
  @feed_items=current_user.feed.paginate(page:params[:page])
    end
  end

  def help
  	
  end
  def about
  	
  end
  def contact
  	
=======
class StaticPagesController < ApplicationController
  def ...
>>>>>>> statis-pages
  end
end
