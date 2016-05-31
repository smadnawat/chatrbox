class Paging
	def self.set_page page, size, clooection
		paging = {}
		paging[:page] = page
		paging[:per_page] = size
		paging[:max_page] = clooection.total_pages
		paging[:total_entries] = clooection.total_entries
		paging
	end
end
