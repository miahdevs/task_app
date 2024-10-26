module Dashboard
  class HomeController < BaseController
    def index
      user_type = set_user
      if (user_type == 'admin')
        @all_tasks = Task.all
        puts "Admin"
      else
        @all_tasks = current_user.assigned_tasks
        puts "User"
      end

      @owned_projects = current_user.owned_projects
                                  .includes(:category)
                                  .order(created_at: :desc)

      @contributed_projects = current_user.contributed_projects
                                        .includes(:category)
                                        .order(created_at: :desc)

      @assigned_tasks = current_user.assigned_tasks
                                  .includes(:project)
                                  .order(created_at: :desc)
    end

    private
    def set_user
      user_type = current_user.email == 'admin@example.com' ? 'admin' : 'user'
    end
  end
end