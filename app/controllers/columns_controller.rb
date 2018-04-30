class ColumnsController < ApplicationController
  before_action :set_column, only: [:show, :update, :destroy]

  # GET /columns
  def index
    @columns = current_user.columns.all

    render json: @columns
  end

  # GET /columns/1
  def show
    render json: @column
  end

  # POST /columns
  def create
    @column = current_user.columns.build(column_params)

    if @column.save
      render json: @column, status: :created, location: @column
    else
      render json: @column.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /columns/1
  def update
    if @column.update(column_params)
      render json: @column
    else
      render json: @column.errors, status: :unprocessable_entity
    end
  end

  # DELETE /columns/1
  def destroy
    @column.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_column
      @column = current_user.columns.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def column_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:table, :name, :type])
    end
end
