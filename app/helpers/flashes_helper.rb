module FlashesHelper
  def user_facing_flashes
    flash.to_hash.slice("alert", "danger", "error", "info", "notice", "success", "warning")
  end
end
