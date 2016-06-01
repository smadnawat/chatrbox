class Paging
	def self.set_page page, size, collection
		paging = {}
		paging[:page] = page
		paging[:per_page] = size
		paging[:max_page] = collection.total_pages
		paging[:total_entries] = collection.total_entries
		paging
	end
end
