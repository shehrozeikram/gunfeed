module ProductsHelper

  def title(title)
    content_for :title, title
  end

  def upc(upc)
    content_for :upc, upc
  end

  def name(name)
    content_for :name, name
  end

end