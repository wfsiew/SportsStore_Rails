module ApplicationHelper
	class Pager
		attr_accessor :total, :pagenum
		attr_reader :pagesize
		
		def initialize(total, pagenum, pagesize)
			@total = total
			@pagenum = pagenum
			@pagesize = pagesize
		end
		
		def pagesize=(pagesize)
			if @total < pagesize || pagesize < 1
				@pagesize = @total
				
			else
				@pagesize = pagesize
			end
		end
		
		def item_message
			Utils.item_message(@total, @pagenum, @pagesize)
		end
		
		def lower_bound
			(@pagenum - 1) * @pagesize
		end
		
		def upper_bound
			upperbound = @pagenum * @pagesize
			if @total < upperbound
				upperbound = @total
			end
			
			upperbound
		end
		
		def hasnext
			@total > upper_bound ? true : false
		end
		
		def hasprev
			lower_bound > 0 ? true : false
		end
		
		def total_pages
			(Float(@total) / @pagesize).ceil
		end
	end
	
	module Utils
		def self.item_message(total, pagenum, pagesize)
			x = (pagenum - 1) * pagesize + 1
			y = pagenum * pagesize
			
			if total < 1
				return ""
			end
			
			"#{x} to #{y} of #{total}"
		end
	end
end

pg = ApplicationHelper::Pager.new(100, 1, 20)
a = pg.total_pages
pg.pagenum = 5
puts pg.item_message