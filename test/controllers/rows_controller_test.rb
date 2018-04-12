# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

require 'test_helper'

class RowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @row = rows(:one)
  end

  test "should get index" do
    get rows_url, as: :json
    assert_response :success
  end

  test "should create row" do
    assert_difference('Row.count') do
      post rows_url, params: { row: { table_id: @row.table_id } }, as: :json
    end

    assert_response 201
  end

  test "should show row" do
    get row_url(@row), as: :json
    assert_response :success
  end

  test "should update row" do
    patch row_url(@row), params: { row: { table_id: @row.table_id } }, as: :json
    assert_response 200
  end

  test "should destroy row" do
    assert_difference('Row.count', -1) do
      delete row_url(@row), as: :json
    end

    assert_response 204
  end
end
