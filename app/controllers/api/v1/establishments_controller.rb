# frozen_string_literal: true

module Api
  module V1
    class EstablishmentsController < Api::V1::ApiController
      before_action :set_establishment, only: %i[show edit update destroy]

      # GET /establishments or /establishments.json
      def index
        @establishments = Establishment.all
        render json: @establishments
      end

      # GET /establishments/1 or /establishments/1.json
      def show
        render json: @establishment&.establishment_profile
      end

      # POST /establishments or /establishments.json
      def create
        @response = EstablishmentService.new(establishment_params).run
        if @response[:success]
          establishment = @response[:establishment]
          render json: establishment.establishment_profile, status: :created
        else
          render json: @response[:error], status: :unprocessable_entity
        end
      end

      # PATCH/PUT /establishments/1 or /establishments/1.json
      def update
        if @establishment.update(establishment_params)
          render json: @establishment, status: :ok
        else
          render json: @establishment.errors, status: :unprocessable_entity
        end
      end

      # DELETE /establishments/1 or /establishments/1.json
      def destroy
        @establishment.destroy
        head :no_content
      end

      private

      def set_establishment
        @establishment = Establishment.find(params[:id])
      end

      def establishment_params
        params.require(:establishment).permit(
          :name, :fantasy_name, :category, :cnpj, :phone, :whatsapp, :email, :owner_id,
          :opening_hours, :closing_time, address: %I[street city neighborhood state zip_code country]
        )
      end
    end
  end
end
