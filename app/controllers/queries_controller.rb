class QueriesController < ApplicationController
  skip_before_action :authenticate_user
  before_action :authenticate_project
  before_action :fetch_database
  before_action :fetch_query, only: [:index, :show, :destroy]

  # GET /queries
  def index
    @queries = @database.queries.all

    render json: @queries
  end

  def show
    render json: { result: @query.response_data }
  end

  def create
    @query = @database.queries.build(request_data: params[:sql])
    @query.instant_execution = !(params[:async] == '1')
    if @query.save
      if @query.instant_execution
        render json: { result: @query.run_query }
      else
        render json: { id: @query.id }, status: :created, location: [@database, @query]
      end
    else
      render json: @query.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @query.destroy
  end

  private

    # TODO: check if project provided by authentication token matches project of queried database
    def authenticate_project
      command = DecodeProjectAuthenticationTokenCommand.call(request.headers)
      @project = command.result
      unless @project
        render json: { error: 'Not Authenticated' }, status: 403
      end
    end

    def fetch_database
      @database = @project.databases.find(params[:database_id])
    end

    def fetch_query
      @query = @database.queries.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def query_params
      params.require(:query).permit(:sql)
    end
end
