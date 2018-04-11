require 'test_helper'

describe Natural::DatabaseUser do
  setup do
    @database_manager = ::Natural::DatabaseManager.new
  end

  teardown do
    @database_manager.destroy_user('test') rescue nil
  end

  describe 'create' do
    it "creates a new database user" do
      @database_manager.create_user('test', 'test')

      @database_manager.user_exists?('test').must_equal true

      @database_manager.destroy_user('test')
    end
  end

  describe 'destroy' do
    it 'destroys a database user' do
      @database_manager = ::Natural::DatabaseManager.new
      @database_manager.create_user('test', 'test')
      @database_manager.destroy_user('test')

      @database_manager.user_exists?('test').must_equal false
    end
  end
end
