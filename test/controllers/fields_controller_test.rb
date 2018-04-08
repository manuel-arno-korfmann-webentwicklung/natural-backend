require 'test_helper'

class FieldsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @field = fields(:one)
  end

  test "should get index" do
    get fields_url, as: :json
    assert_response :success
  end

  test "should create field" do
    assert_difference('Field.count') do
      post fields_url, params: { field: { name: @field.name, table_id: @field.table_id, type: @field.type } }, as: :json
    end

    assert_response 201
  end

  test "should show field" do
    get field_url(@field), as: :json
    assert_response :success
  end

  test "should update field" do
    patch field_url(@field), params: { field: { name: @field.name, table_id: @field.table_id, type: @field.type } }, as: :json
    assert_response 200
  end

  test "should destroy field" do
    assert_difference('Field.count', -1) do
      delete field_url(@field), as: :json
    end

    assert_response 204
  end
end
