class ListsController < ApplicationController
  before_action :authenticate_user!

  def reorder
    list = current_user.lists.find(params[:id])

    if list&.update(params.permit(:board_order_position))
      render json: { message: 'List order updated.' }, status: :ok
    else
      render json: { error: 'Failed to update list order.' }, status: :unprocessable_entity
    end
  end
end
