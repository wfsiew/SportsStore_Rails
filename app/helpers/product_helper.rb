module ProductHelper
  
  # Get the list of products with paging info
  def self.get_all(pagenum, pagesize)
    total = Product.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    products = Product.limit(pager.pagesize).offset(pager.lower_bound)
    { :pager => pager, :list => products }
  end
  
  # Get the list of products specified by the category, with paging info
  def self.get_by_category(category, pagenum, pagesize)
    total = Product.where(:category => category).count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    products = Product.find_all_by_category(category, :limit => pager.pagesize, :offset => pager.lower_bound)
    { :pager => pager, :list => products }
  end
  
  # Get the list of product categories
  def self.get_categories
    Product.unscoped.all(:select => 'distinct category', :order => 'category')
  end
  
  # Get a product by productID
  def self.get_product(productID)
    Product.unscoped.find_by_productID(productID)
  end
  
  # Get the image byte and mime type of the uploaded file
  def self.get_uploaded_file(file)
    if file.present?
      content_type = file.content_type
      data = file.read
      return content_type, data
    end
    
    return nil, nil
  end
  
end
