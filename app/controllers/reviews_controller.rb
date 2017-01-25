class ReviewsController < ApplicationController
  before_action :authenticate_user!

 def new
   @meme = Meme.find(params[:meme_id])
   @user = current_user.id
   @review = Review.new
   @review.meme = @meme
   @rating_collection = Review::RATINGS
 end

 def create
    @meme = Meme.find(params[:meme_id])
    @user = current_user
    @review = Review.new(params_strong)
    @review.meme = @meme
    @review.user = @user
    if @review.save
      UserMailer.notice(@review).deliver
      flash[:notice] = "Review added successfully"
      redirect_to meme_path(@meme)
    else
      flash[:notice] = @review.errors.full_messages.to_sentence
      @reviews = @meme.reviews
      @rating_collection = Review::RATINGS
      render '/memes/show'
    end
end

private
 def params_strong
   params.require(:review).permit(
     :rating,
     :body
   )
 end
end
