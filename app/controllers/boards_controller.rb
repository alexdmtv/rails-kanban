class BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: %i[edit update destroy confirm_destroy]

  def index
    return if current_user.boards.empty?

    redirect_to current_user.boards.first
  end

  def show
    @board = current_user.boards.includes(lists: { tasks: :subtasks })
                         .order('lists.board_order, tasks.list_order, subtasks.task_order')
                         .find_by(id: params[:id])
  end

  def new
    @board = current_user.boards.build
    %w[Todo Doing].each { |name| @board.lists.build(name:) }
  end

  def edit; end

  def create
    @board = current_user.boards.build(board_params)

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: 'Board was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Board wasn't saved." }
      end
    end
  end

  def update
    @board.assign_attributes(board_params)
    @board.lists.each_with_index { |list, index| list.board_order = index }

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: "Board wasn't updated." }
      end
    end
  end

  def destroy
    @board.destroy
    redirect_to root_path
  end

  def confirm_destroy; end

  private

  def board_params
    params
      .require(:board)
      .permit(:name, lists_attributes: %i[id name board_order_position color_code _destroy])
  end

  def set_board
    @board = current_user.boards.includes(:lists).order('lists.board_order').find_by(id: params[:id])
  end
end
