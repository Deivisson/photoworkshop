module User::WorkshopHelper
	def workshop_status(workshop)
		if !workshop.opened?
			"Novo"
		else
			"Aberto"
		end	
	end
end