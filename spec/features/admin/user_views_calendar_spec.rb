require "rails_helper"

feature "User views calendar" do
  scenario "is redirected away if not signed in" do
    visit admin_calendar_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario "successfully" do
    sign_in create(:user)
    visit admin_calendar_path

    expect(current_path).to eq(admin_calendar_path)
  end
end
