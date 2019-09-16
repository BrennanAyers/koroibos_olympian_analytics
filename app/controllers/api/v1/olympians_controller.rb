# frozen_string_literal: true

# The Olympians controller handles all RESTful routes for the Olympians table
module Api
  module V1
    class OlympiansController < ApplicationController
      def index
        render json: OlympianSerializer.new(Olympian.all_with_total_medals_won)
      end
    end
  end
end
