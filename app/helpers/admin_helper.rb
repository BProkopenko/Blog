module AdminHelper
	def admin_user
		flash[:danger] = "Permission denied" && redirect_to(request.referrer || root_url) unless current_user.admin?
	end
end
