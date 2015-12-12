class WorkshopPlansController < ApplicationController
  before_action :set_workshop_plan, only: [:show, :edit, :update, :destroy]

  # GET /workshop_plans
  # GET /workshop_plans.json
  def index
    @workshop_plans = WorkshopPlan.all
  end

  # GET /workshop_plans/1
  # GET /workshop_plans/1.json
  def show
  end

  # GET /workshop_plans/new
  def new
    @workshop_plan = WorkshopPlan.new
  end

  # GET /workshop_plans/1/edit
  def edit
  end

  # POST /workshop_plans
  # POST /workshop_plans.json
  def create
    @workshop_plan = WorkshopPlan.new(workshop_plan_params)

    respond_to do |format|
      if @workshop_plan.save
        format.html { redirect_to @workshop_plan, notice: 'Workshop plan was successfully created.' }
        format.json { render :show, status: :created, location: @workshop_plan }
      else
        format.html { render :new }
        format.json { render json: @workshop_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workshop_plans/1
  # PATCH/PUT /workshop_plans/1.json
  def update
    respond_to do |format|
      if @workshop_plan.update(workshop_plan_params)
        format.html { redirect_to @workshop_plan, notice: 'Workshop plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @workshop_plan }
      else
        format.html { render :edit }
        format.json { render json: @workshop_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workshop_plans/1
  # DELETE /workshop_plans/1.json
  def destroy
    @workshop_plan.destroy
    respond_to do |format|
      format.html { redirect_to workshop_plans_url, notice: 'Workshop plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workshop_plan
      @workshop_plan = WorkshopPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workshop_plan_params
      params.require(:workshop_plan).permit(:description, :settings, :active)
    end
end
