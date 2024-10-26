module Dashboard
  class TasksController < BaseController
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index
    end

    def show
      @project = @task.project
    end

    def new
      @project = Project.find(params[:project_id])
      @task = @project.tasks.build
    end

    def create
      @project = Project.find(params[:project_id])
      @task = @project.tasks.build(task_params)
      if @task.save
        flash[:notice] = "Task was successfully created."
        redirect_to dashboard_project_task_path(@project, @task)
      else
        render :new
      end
    end

    def edit
      @project = @task.project
    end

    def update
      if @task.update(task_params)
        flash[:notice] = "Task was successfully updated."
        redirect_to dashboard_project_task_path(@task.project, @task)
      else
        @project = @task.project
        flash.now[:alert] = "There was an error updating the task."
        render :edit
      end
    end

    def destroy
      @project = @task.project
      @task.destroy
      redirect_to dashboard_project_path(@project), notice: "Task was successfully deleted."
    end

    private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :status, :assignee_id, :project_id, :deadline)
    end
  end
end
