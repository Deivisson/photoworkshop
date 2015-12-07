module User::WorkshopHelper
	def workshop_status(workshop)
		if !workshop.published?
			"Novo"
		else
			"Publicado"
		end	
	end
end