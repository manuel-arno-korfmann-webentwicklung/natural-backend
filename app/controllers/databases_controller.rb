class DatabasesController < ApplicationController
  before_action :set_database, only: [:show, :update, :destroy]

  # GET /databases
  def index
    @databases = current_user.databases.all

    render json: @databases
  end

  # GET /databases/1
  def show
    render json: @database
  end

  # POST /databases
  def create
    @database = current_user.databases.build(database_params)

    if @database.save
      render json: @database, status: :created, location: @database
    else
      render json: @database.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /databases/1
  def update
    if @database.update(database_params)
      render json: @database
    else
      render json: @database.errors, status: :unprocessable_entity
    end
  end

  # DELETE /databases/1
  def destroy
    @database.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_database
      @database = current_user.databases.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def database_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:name, :project])
    end
end
