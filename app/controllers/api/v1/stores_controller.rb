module Api
  module V1

    class StoresController < Api::V1::ApiController

      def show
        if params[:id].present?
          @store = Store.find(params[:id])
          render json: {api_status: true, store: @store.as_json( :include => [:products]) }
        else
          render json: {api_status: false ,  error: 'params is missing or value is not present in our database'}
        end
      end



    end


  end
end