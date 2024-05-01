# frozen_string_literal: true

module Api
  module V1
    class OwnersController < Api::V1::ApiController
      before_action :set_owner, only: %i[show edit update destroy]
      protect_from_forgery with: :null_session

      # GET /owners or /owners.json
      def index
        @owners = Owner.all
      end

      # GET /owners/1 or /owners/1.json
      def show; end

      def new; end

      # GET /owners/1/edit
      def edit; end

      # POST /owners or /owners.json

      def create
        @response = OwnerService.new(owner_params).run
        if @response[:success]
          owner = @response[:owner]
          render json: owner.profile, status: :created
        elsif @response[:error_message].present?
          render json: { error: @response[:error_message] }, status: :unprocessable_entity
        else
          render json: { error: 'Internal server error' }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /owners/1 or /owners/1.json
      def update
        if @owner.update(owner_params)
          render json: @owner, status: :ok
        else
          render json: @owner.errors, status: :unprocessable_entity
        end
      end

      # DELETE /owners/1 or /owners/1.json
      def destroy
        @owner.destroy

        respond_to do |format|
          format.html { redirect_to owners_url, notice: 'Owner was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private

      def set_owner
        @owner = Owner.find(params[:id])
      end

      def owner_params
        params.require(:owner).permit(:name, :phone, :email, :document_number, :type_document,
                                      address: %i[street city neighborhood state zip_code country],
                                      establishment_attributes: [:name, :fantasy_name, :category, :cnpj,
                                                                 :phone, :whatsapp, :email,
                                                                 :opening_hours, :closing_time,
                                                                 { address: %i[street city neighborhood state
                                                                               zip_code country] }])
      end
    end
  end
end
