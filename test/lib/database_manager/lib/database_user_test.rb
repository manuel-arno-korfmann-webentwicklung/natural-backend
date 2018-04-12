require 'test_helper'

describe Natural::DatabaseUser do
  before do
    @database_manager = ::Natural::DatabaseManager.new
  end

  after do
    @database_manager.destroy_database('test') rescue nil
    @database_manager.destroy_user('test') rescue nil
    @database_manager.destroy_user('test-test') rescue nil
  end

  describe 'create' do
    it "creates a new database user" do
      @database_manager.create_user('test', 'test')
      @database_manager.user_exists?('test').must_equal true
    end
  end

  describe 'destroy' do
    it 'destroys a database user' do
      @database_manager.create_user('test', 'test')
      @database_manager.destroy_user('test')
      @database_manager.user_exists?('test').must_equal false
    end
  end

  describe 'grant' do
    it 'grants a user all priviliges for the specififed db' do
      db_user = @database_manager.create_user('test-test', 'test')
      db = @database_manager.create_database('test')

      db_user.grant(db)

      @database_manager.connection.exec(
        """
        SELECT datacl FROM pg_database WHERE datname = 'test';
        """
      ).values[0][0].must_match /test-test\\\"\=CTc/
    end
  end
end
