# frozen_string_literal: true

module Api
  module V1
    # The Olympians controller handles all RESTful routes for the Olympians table
    class OlympiansController < ApplicationController
      def index
        age = 'ASC' if params[:age] == 'youngest'
        age = 'DESC' if params[:age] == 'oldest'
        render json: OlympianSerializer.new(Olympian.all_with_total_medals_won(age))
      end
    end
  end
end
