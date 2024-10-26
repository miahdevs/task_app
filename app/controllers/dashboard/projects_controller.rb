module Dashboard
  class ProjectsController < BaseController
    before_action :authenticate_user!
    before_action :set_project, only: [:show, :edit, :update, :destroy]

    def index
      if current_user.email == 'admin@example.com'
        @projects = Project.all
      else
        @projects = current_user.owned_projects
      end
    end

    def show
    end

    def new
      @project = Project.new
    end

    def create
      @project = current_user.owned_projects.build(project_params)
      if @project.save
        redirect_to dashboard_project_path(@project), notice: 'Project was successfully created.'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @project.update(project_params)
        redirect_to dashboard_project_path(@project), notice: 'Project was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @project.destroy
      redirect_to dashboard_projects_path, notice: 'Project was successfully deleted.'
    end

    private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :category_id, :status, :priority, :deadline)
    end
  end
end
