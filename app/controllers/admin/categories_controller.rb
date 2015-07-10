class Admin::CategoriesController < ApplicationController
  before_action :set_category, except: [:index, :new, :create]

  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.number.per_page
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to [:admin, @category], notice: t("admin.category.create-success")
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      redirect_to [:admin, @category], notice: t("admin.category.updated-success")
    else
      render "edit"
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = t("admin.category.destroy-success")
    else
      flash[:alert] = t("admin.category.delete_failed")
    end
    redirect_to admin_categories_url
  end


  private
  def set_category
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit :name, :content, :activate
  end
end
