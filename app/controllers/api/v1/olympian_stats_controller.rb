# frozen_string_literal: true

module Api
  module V1
    # The OlympianStats controller handles finding and returning statistics
    # about all Olympians included in the database
    class OlympianStatsController < ApplicationController
      def index
        json = OlympianStatsSerializer.new(Olympian.statistics)
        render json: json
      end
    end
  end
end
