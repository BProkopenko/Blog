module AdminHelper
	def admin_user
		 redirect_to(request.referrer || root_url) && flash[:danger] = "Permission denied" unless current_user.admin?
	end
end
