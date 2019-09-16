# frozen_string_literal: true

module Api
  module V1
    # The Olympians controller handles all RESTful routes for the Olympians table
    class OlympiansController < ApplicationController
      def index
        render json: OlympianSerializer.new(Olympian.all_with_total_medals_won)
      end
    end
  end
end
