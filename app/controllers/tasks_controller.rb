class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit destroy update reorder]

  def new
    board = current_user.boards.find_by(id: params[:board_id])
    if board.lists&.first
      @task = Task.new(list: board.lists.first)
      2.times { @task.subtasks.build }
      p @task.subtasks
    else
      redirect_to root_path, alert: "Board wasn't found."
    end
  end

  def edit; end

  def create
    list = current_user.lists.find_by(id: params[:task][:list_id])

    if list
      @task = list.tasks.build(task_params)
      @task.list_order_position = :first
    end

    respond_to do |format|
      if @task.save

        format.turbo_stream { flash.now[:notice] = 'Task was successfully created' }
        format.html { redirect_to @task.board, notice: 'Task was successfully created' }
      else
        format.turbo_stream { flash.now[:alert] = "Task wasn't saved." }
        format.html { render :new, status: :unprocessable_entity, alert: "Task wasn't saved." }
      end
    end
  end

  def update
    @task.assign_attributes(task_params)
    @task.list_order_position = :first if @task.list_id_changed?

    respond_to do |format|
      if @task.save
        @new_list = List.includes(:board, tasks: :subtasks).find(@task.list_id)

        format.turbo_stream { flash.now[:notice] = 'Task was successfully updated!' }
        format.html { redirect_to board_path(@task.list.board), notice: 'Task was successfully updated!' }
      else
        format.turbo_stream { flash.now[:alert] = "Task wasn't updated." }
        format.html { render :edit, status: :unprocessable_entity, alert: "Task wasn't updated." }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to board_path(@task.list.board), notice: 'Task was successfully deleted.' }
    end
  end

  def reorder
    list = current_user.lists.find(params[:list_id])

    if @task && list
      @task.list_id = list.id
      @task.list_order_position = params[:list_order_position]
    end

    if @task.save
      render json: { message: 'Task order updated.' }, status: :ok
    else
      render json: { error: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:id, :title, :description, :list_id,
                                 subtasks_attributes: %i[id title is_completed task_order_position _destroy])
  end

  def set_task
    @task = current_user.tasks.includes(:subtasks).order('subtasks.task_order').find_by(id: params[:id])
  end
end
