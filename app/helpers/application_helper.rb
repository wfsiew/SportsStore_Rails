module ApplicationHelper
  
  class Pager
    attr_accessor :total, :pagenum
    attr_reader :pagesize
    
    @@default_page_size = 10

    def initialize(total, pagenum, pagesize)
      @total = total
      @pagenum = pagenum
      set_pagesize(pagesize)
    end

    def pagesize=(pagesize)
      set_pagesize(pagesize)
    end

    def item_message
      Utils.item_message(total, pagenum, pagesize)
    end

    def lower_bound
      (pagenum - 1) * pagesize
    end

    def upper_bound
      upperbound = pagenum * pagesize
      if total < upperbound
        upperbound = total
      end

      upperbound
    end

    def has_next?
      total > upper_bound ? true : false
    end

    def has_prev?
      lower_bound > 0 ? true : false
    end

    def total_pages
      (Float(total) / pagesize).ceil
    end
    
    def self.default_page_size
      @@default_page_size
    end
    
    private
    
    def set_pagesize(pagesize)
      if (total < pagesize || pagesize < 1) && total > 0
        @pagesize = total

      else
        @pagesize = pagesize
      end
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
    
    def self.numeric?(val)
      true if Float(val) rescue false
    end
  end
  
end
