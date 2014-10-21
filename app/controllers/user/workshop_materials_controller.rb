class User::WorkshopMaterialsController < User::BaseController
  before_action :set_workshop
  before_action :set_workshop_material, only: [:show, :edit, :update, :destroy]

  def new
    @workshop_material = WorkshopMaterial.new(workshop_id:params[:workshop_id])
    respond_with(@workshop_material,layout:false)
  end

  def edit
     respond_with(@workshop_material,layout:false)
  end

  def create
    @workshop = current_user.owner_workshops.find(params[:workshop_id])
    @workshop_material = @workshop.materials.build(workshop_material_params)
    respond_to do |format|
      @workshop_material.save
      format.js
    end
  end

  def update
    @workshop_material.update(workshop_material_params)
  end

  def destroy
    @workshop_material.destroy
  end

  private

    def set_workshop
      @workshop = current_user.owner_workshops.find(params[:workshop_id])
    end

    def set_workshop_material
      @workshop_material = @workshop.materials.find(params[:id])
    end

    def workshop_material_params
      params.require(:workshop_material).permit(:workshop_id, :description, :attachment)
    end
end
