module Dashboard
  class CategoriesController < BaseController
    def index
      @categories = Category.all
    end

    def show
      set_category
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      @category.slug = @category.title.parameterize
      if @category.save
        redirect_to @category, notice: "Category was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end 

    def edit
      set_category
    end

    def update  
      set_category
      if @category.update(category_params)
        redirect_to @category, notice: "Category was successfully updated."
      else
        flash.now[:alert] = "Failed to update the category. Please check the form for errors."
        @category.reload
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      set_category
      @category.destroy

      redirect_to root_path, status: :see_other, notice: "Category was successfully deleted."
    end

    private
      def category_params
        params.require(:category).permit(:title, :body, :slug)
      end

      def set_category
        @category = Category.find_by!(slug: params[:slug])
      end
  end
end
