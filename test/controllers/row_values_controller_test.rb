# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

require 'test_helper'

class RowValuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @row_value = row_values(:one)
  end

  test "should get index" do
    get row_values_url, as: :json
    assert_response :success
  end

  test "should create row_value" do
    assert_difference('RowValue.count') do
      post row_values_url, params: { row_value: { column_id: @row_value.column_id, row_id: @row_value.row_id, value: @row_value.value } }, as: :json
    end

    assert_response 201
  end

  test "should show row_value" do
    get row_value_url(@row_value), as: :json
    assert_response :success
  end

  test "should update row_value" do
    patch row_value_url(@row_value), params: { row_value: { column_id: @row_value.column_id, row_id: @row_value.row_id, value: @row_value.value } }, as: :json
    assert_response 200
  end

  test "should destroy row_value" do
    assert_difference('RowValue.count', -1) do
      delete row_value_url(@row_value), as: :json
    end

    assert_response 204
  end
end
