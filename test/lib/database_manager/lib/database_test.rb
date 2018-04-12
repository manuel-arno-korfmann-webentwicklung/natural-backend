require 'test_helper'

describe Natural::Database do
  setup do
    @database_manager = ::Natural::DatabaseManager.new
  end

  after do
    @database_manager.destroy_database('test') rescue nil
  end

  describe 'create' do
    it "creates a new database" do
      @database_manager.create_database('test')

      @database_manager.database_exists?('test').must_equal true
    end
  end

  describe 'destroy' do
    it 'destroys a database' do
      @database_manager.create_database('test')
      @database_manager.destroy_database('test')

      @database_manager.database_exists?('test').must_equal false
    end
  end
end
