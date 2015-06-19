require 'test_helper'

class MeasuresControllerTest < ActionController::TestCase
  setup do
    @measure = measures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:measures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create measure" do
    assert_difference('Measure.count') do
      post :create, measure: { plan_id: @measure.plan_id, tank_id: @measure.tank_id, volume: @measure.volume }
    end

    assert_redirected_to measure_path(assigns(:measure))
  end

  test "should show measure" do
    get :show, id: @measure
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @measure
    assert_response :success
  end

  test "should update measure" do
    patch :update, id: @measure, measure: { plan_id: @measure.plan_id, tank_id: @measure.tank_id, volume: @measure.volume }
    assert_redirected_to measure_path(assigns(:measure))
  end

  test "should destroy measure" do
    assert_difference('Measure.count', -1) do
      delete :destroy, id: @measure
    end

    assert_redirected_to measures_path
  end
end
