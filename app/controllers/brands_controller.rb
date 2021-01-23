class BrandsController < ApplicationController
    def index
        if params[:user_id]
            @brands = Brand.where(user_id: params[:user_id])
        end
        @brands = Brand.all
    end

    def show
        @brand =  Brand.find(params[:id])
        @flavors  = Noodle.where(brand: @brand).collect(&:flavor)
    end
    
    # def destroy
    #     @brand = Brand.find_by_id(params[:id])
    #     @brand.destroy
    #     redirect_to brands_path
    # end
end
