require 'test_helper'

describe Natural::DatabaseManager do
  before do
    @database_manager = ::Natural::DatabaseManager.new
    @database_manager.create_database('test_db')
  end

  after do
    @database_manager.destroy_database('test_db') rescue nil
    @connection.close
  end

  describe 'connect_to_database' do
    it "connects to a given database identifier" do
      @connection = @database_manager.connect_to_database('test_db')
      @connection.nil? must_equal false
    end
  end

end
