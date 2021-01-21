class ReviewsController < ApplicationController
    def new
        if @noodle = Noodle.find_by_id(params[:noodle_id])
            @review = @noodle.reviews.build
        else
            @review = Review.new
        #review belongs to a noodle
        end
    end

    def create
        @review = current_user.reviews.build(review_params)
        if @review.save
            redirect_to noodle_path(@review.noodle)
        else 
            render :new
        end
    end

    def show
        @review = Review.find_by_id(params[:id])
    end

    def update
        @review = Review.find_by_id(params[:id])
        @review.stars = params[:review][:stars]
        @review.title = params[:review][:title]
        @review.content = params[:review][:content]
        if @review.save
            redirect_to noodle_path(@review.noodle)
        end
    end

    def edit
        @review = Review.find_by_id(params[:id])
    end

    def destroy
        @review = Review.find_by_id(params[:id])
        @noodle = @review.noodle
        if @review.delete
            redirect_to noodle_path(@noodle)
        end
    end

    def index
        if params[:user_id]
        @reviews  = Review.where(user_id: params[:user_id])
        elsif @noodle = Noodle.find_by_id(params[:noodle_id]) #checks to seef if it is nested and has a valid id
            @reviews = @noodle.reviews #nested
        else
            @reviews = Review.all #not nested
        end
    end

    private

    def review_params
        params.require(:review).permit(:noodle_id, :content, :stars, :title)
    end

end