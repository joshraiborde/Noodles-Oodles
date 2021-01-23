class NoodlesController < ApplicationController
    def new
        @noodle = Noodle.new
        @noodle.build_brand
    end

    def create
        @noodle = Noodle.new(noodle_params)
        @noodle.user_id = session[:user_id]
        @noodle.brand.user_id =  session[:user_id] if @noodle.brand
        @noodle.image.attach(params[:noodle][:image]) #2021-01-23 moved this above @noodle.save
        if @noodle.save #this is where validatins occur
            
            redirect_to noodle_path(@noodle)
        else
            @noodle.build_brand
            render :new
        end
    end

    def index
        @noodles = Noodle.order_by_rating.includes(:brand).reverse
    end
    
    def show
        # byebug
        @noodle = Noodle.find_by_id(params[:id])
    end

    def destroy
        @noodle = Noodle.find_by_id(params[:id])
        @noodle.destroy
        redirect_to noodles_path
    end

    def edit
        @noodle = Noodle.find_by_id(params[:id])
            @noodle.build_brand
    end

    def update
        @noodle = Noodle.find_by_id(params[:id])
        @noodle.flavor = params[:noodle][:flavor] if params[:noodle][:flavor]
        @noodle.description = params[:noodle][:description] if params[:noodle][:description]
        @noodle.brand_id= params[:noodle][:brand_id]
        if @noodle.save(validate: false) #this is where validatins occur
            if  params[:noodle][:image]
                if @noodle.image.attached?
                    @noodle.image.attachment.purge
                    @noodle.image.attach(params[:noodle][:image])
                    @noodle.save(validate: false)
                else
                    @noodle.image.attach(params[:noodle][:image])
                    @noodle.save(validate: false)
                end
            end
            redirect_to noodle_path(@noodle)
        else
            @noodle.build_brand
            render :new
        end
    end

    private

    def noodle_params
        params.require(:noodle).permit(:flavor, :image, :description, :brand_id, brand_attributes: [:name])
    end
end
