module AdminHelper
	def admin_user
		redirect_to(request.referrer || root_url) unless current_user.admin?
		flash[:danger] = "Permission denied"
	end
end
