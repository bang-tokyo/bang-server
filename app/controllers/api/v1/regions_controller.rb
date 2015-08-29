class Api::V1::RegionsController < ApplicationController
  skip_before_action :authenticate, only: [:index]

  def index
    @regions = Region.all
  end
end
