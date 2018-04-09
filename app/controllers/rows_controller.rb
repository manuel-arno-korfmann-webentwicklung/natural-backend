class RowsController < ApplicationController
  before_action :set_row, only: [:show, :update, :destroy]

  # GET /rows
  def index
    @rows = Row.all

    render json: @rows
  end

  # GET /rows/1
  def show
    render json: @row
  end

  # POST /rows
  def create
    @row = Row.new(row_params)

    if @row.save
      render json: @row, status: :created, location: @row
    else
      render json: @row.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rows/1
  def update
    if @row.update(row_params)
      render json: @row
    else
      render json: @row.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rows/1
  def destroy
    @row.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_row
      @row = Row.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def row_params
      params.require(:row).permit(:table_id)
    end
end
