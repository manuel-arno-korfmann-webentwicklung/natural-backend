class TablesController < ApplicationController
  before_action :set_table, only: [:show, :update, :destroy]

  # GET /tables
  def index
    @tables = current_user.tables.all

    render json: @tables
  end

  # GET /tables/1
  def show
    render json: @table
  end

  # POST /tables
  def create
    @table = current_user.tables.build(table_params)

    if @table.save
      render json: @table, status: :created, location: @table
    else
      render json: @table.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tables/1
  def update
    if @table.update(table_params)
      render json: @table
    else
      render json: @table.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tables/1
  def destroy
    @table.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table
      @table = current_user.tables.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def table_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:name, :database])
    end
end
