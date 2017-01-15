module Admin::UsersHelper
  def user_password_hint(user)
    if user.persisted?
      "Leave blank if you don't want to change it"
    else
      "Use at least #{user.class.password_length.min} characters" if user.class.password_length.min
    end
  end
end
