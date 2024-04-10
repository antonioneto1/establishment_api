class Api::V1::OwnersController < Api::V1::ApiController
  before_action :set_owner, only: %i[ show edit update destroy ]
  protect_from_forgery with: :null_session 

  # GET /owners or /owners.json
  def index
    @owners = Owner.all
  end

  # GET /owners/1 or /owners/1.json
  def show
  end

  # GET /owners/new
  def new
    @owner = Owner.new
  end

  # GET /owners/1/edit
  def edit
  end

  # POST /owners or /owners.json
  def create
    @owner = Owner.new(owner_params)

    if @owner.save
      render json: @owner, status: :ok
    else
      render json: { error: 'JSON inválido' }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /owners/1 or /owners/1.json
  def update
    respond_to do |format|
      if @owner.update(owner_params)
        format.html { redirect_to owner_url(@owner), notice: "Owner was successfully updated." }
        format.json { render :show, status: :ok, location: @owner }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /owners/1 or /owners/1.json
  def destroy
    @owner.destroy

    respond_to do |format|
      format.html { redirect_to owners_url, notice: "Owner was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owner
      @owner = Owner.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def owner_params
      params.require(:owner).permit(:name, :phone, :email, :document_number, :type_document)
    end
end