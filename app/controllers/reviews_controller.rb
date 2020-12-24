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
            redirect_to review_path(@review)
        else 
            render :new
        end
    end

    def show
        @review = Review.find_by_id(params[:id])
    end

    def index
        if @noodle = Noodle.find_by_id(params[:noodle_id]) #checks to seef if it is nested and has a valid id
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
