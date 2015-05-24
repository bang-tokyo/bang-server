class Api::V1::ConversationsController < Api::ApplicationController

  validates :index do
    integer :count
  end

  validates :show do
    integer :id, required: true
  end

  validates :destroy do
    integer :id, required: true
  end

  def index
    count = params[:count] || 50
  end

  def show
  end

  def destroy
  end
end
