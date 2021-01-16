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
end
