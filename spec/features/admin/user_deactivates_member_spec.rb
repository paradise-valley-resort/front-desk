require "rails_helper"

feature "User deactivates member" do
  scenario "and is presented with confirmation dialog", js: true do
    member = create(:member, :active)

    sign_in create(:user)
    visit admin_members_path
    confirm_message = accept_confirm do
      within "#member_#{member.to_param}" do
        find(".manage-member").click
        click_on "Deactivate member"
      end
    end

    expect(confirm_message).to eq(
      "Are you sure you want to deactivate this member?"
    )
  end

  scenario "and sees success message", js: true do
    member = create(:member, :active)

    sign_in create(:user)
    visit admin_members_path
    accept_confirm do
      within "#member_#{member.to_param}" do
        find(".manage-member").click
        click_on "Deactivate member"
      end
    end

    expect(page).to have_content("Member was successfully deactivated")
  end
end
