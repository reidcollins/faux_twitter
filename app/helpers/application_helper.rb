module ApplicationHelper

	#returns full title on per page basis
	def proper_title(page_title)
		base_title = 'fauxtwitter'

		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
		
	end
end