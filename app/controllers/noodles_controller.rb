class NoodlesController < ApplicationController
    def new
        @noodle= Noodle.new
        @noodle.build_brand
    end

    def create
        @noodle = Noodle.new(noodle_params)
        @noodle.user_id = session[:user_id]
        if @noodle.save
            redirect_to noodle_path(@noodle)
        else
            render :new
        end
    end

    def index
        @noodles = Noodle.all
      end
    
      def show
        @noodle = Noodle.find_by_id(params[:id])
      end


    private

    def noodle_params
        params.require(:noodle).permit(:flavor, :description, :brand_id, brand_attributes: [:name])
    end
end
