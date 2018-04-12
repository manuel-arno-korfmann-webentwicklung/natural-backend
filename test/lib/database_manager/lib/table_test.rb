# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

require 'test_helper'

describe Natural::Table do
  before do
    @database_manager = ::Natural::DatabaseManager.new
    @test_db = @database_manager.create_database('test') rescue @database_manager.database('test')
    @table = @test_db.create_table('test') rescue @test_db.table('test')
  end

  after do
    @table.connection.close
    @database_manager.destroy_database('test')
  end

  describe 'create' do
    it "creates a new table" do
      @table.exists?.must_equal true
    end
  end

  describe 'destroy' do
    it 'destroys a table' do
      @table.destroy
      @table.exists?.must_equal false
    end
  end

  describe 'insert_value' do
    it 'returns the id of the inserted row' do
      @table.add_column('test')
      id = @table.insert_value('test', 'test')
      @table.connection.exec("SELECT test FROM test WHERE id = #{id}")
      .values[0][0].must_equal 'test'
    end
  end

  describe 'delete_value' do
    it 'deletes_value' do
      @table.add_column('test')
      id = @table.insert_value('test', 'test')
      @table.delete_value('test', id)
      @table.connection.exec("SELECT test FROM test WHERE id = #{id}")
      .values[0][0].must_equal nil
    end
  end
end
