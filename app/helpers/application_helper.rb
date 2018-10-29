module ApplicationHelper
	def number_of_accounts
		Account.count
	end
	
	def number_of_users
		User.count
	end	
end
