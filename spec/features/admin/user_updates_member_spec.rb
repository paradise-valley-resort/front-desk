require "rails_helper"

feature "User updates member" do
  scenario "is redirected away if not signed in" do
    member = create(:member)

    visit edit_admin_member_path(member)

    expect(current_path).to eq(new_user_session_path)
  end

  scenario "with invalid attributes and sees error message" do
    member = create(:member)

    sign_in create(:user)
    visit edit_admin_member_path(member)
    fill_in "First Name", with: ""
    click_on "Update member"

    expect(page).to have_content("There were problems updating the member")
    within ".member_first_name" do
      expect(page).to have_content("First Name can't be blank")
    end
  end

  scenario "with valid attributes and sees success message" do
    member = create(:member)

    sign_in create(:user)
    visit edit_admin_member_path(member)
    fill_in "First Name", with: "New Name"
    click_on "Update member"

    expect(page).to have_content("Member was successfully updated")
  end
end
