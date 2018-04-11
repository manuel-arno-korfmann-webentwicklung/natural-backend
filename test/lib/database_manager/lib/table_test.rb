require 'test_helper'

describe Natural::Table do
  setup do
    @database_manager = ::Natural::DatabaseManager.new
    @test_db = @database_manager.create_database('test')
  end

  teardown do
    @test_db.destroy_table('test') rescue nil
    @test_db.destroy
  end

  describe 'create' do
    it "creates a new table" do
      @test_db.create_table('test')
      @test_db.table_exists?('test').must_equal true
    end
  end

  describe 'destroy' do
    it 'destroys a table' do
      table = @test_db.create_table('test')
      @test_db.destroy_table('test')
      @test_db.table_exists?('test').must_equal false
    end
  end
end
