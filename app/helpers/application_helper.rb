# -*- encoding : utf-8 -*-
module ApplicationHelper
	def full_title(page_title)
		base_title = "SiRASS"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def boolean_to_icon(boolean)
		iconClass = (boolean == true ? 'ok' : 'remove')
		content_tag :i, nil, class: "icon-#{iconClass}"
	end

	def current_date(format = '%d/%m/%Y')
		Date.today.strftime(format)
	end
end
