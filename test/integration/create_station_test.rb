class CreateStationTest < CapybaraTestCase
  test "can create a new bug" do
    visit root_path
    click_link "File new bug"
  end
end