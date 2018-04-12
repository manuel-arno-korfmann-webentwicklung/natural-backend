# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

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
