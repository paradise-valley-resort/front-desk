require "rails_helper"

feature "User creates member" do
  scenario "is redirected away if not signed in" do
    visit new_admin_member_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario "with invalid attributes and sees error message" do
    sign_in create(:user)
    visit new_admin_member_path
    fill_out_member_form(first_name: "")

    expect(page).to have_content("There were problems creating the member")
    expect(page).to have_content("First Name can't be blank")
  end

  scenario "with valid attributes and sees success message" do
    sign_in create(:user)
    visit new_admin_member_path
    fill_out_member_form

    expect(page).to have_content("Member was successfully created")
  end

  def fill_out_member_form(member_attributes = {})
    member = build(:member, {}.merge(member_attributes))
    fill_in "First Name", with: member.first_name
    fill_in "Last Name", with: member.last_name
    fill_in "Address 1", with: member.address_1
    fill_in "City", with: member.city
    within "#member_state" do
      find("option[value='#{member.state}']").select_option
    end
    fill_in "Zip Code", with: member.zip_code
    fill_in "Membership ID", with: member.membership_id
    click_on "Create member"
  end
end
