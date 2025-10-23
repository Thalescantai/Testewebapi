class Api::V1::InfoController < BaseController
    def index
        render json:{info: 'ola mundo'}
    end
end