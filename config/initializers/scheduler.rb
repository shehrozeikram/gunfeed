require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new(:lockfile => ".rufus-scheduler.lock")
unless scheduler.down?
  scheduler.every "20h", :overlap => false do
    begin
      require 'rest-client'
      Store.where.not(store_xml_feed_url: nil).each do|store|
        xml = RestClient.get store.store_xml_feed_url
        json_feed =  Hash.from_xml(xml).to_json
        json_feed =  json_feed.gsub("null", "0")
        json_feed = eval(json_feed)
        products = json_feed[:rss][:channel][:item] rescue  json_feed[:channel][:item]
        Product.where(store_id: store.id).update_all(active: false)
        products.each do |pr|
          product = Product.where(user_id: 1, category_id: 1, store_id: store.id, upc:  pr[:upc]).first_or_initialize
          product.title = pr[:title]
           product.description =  pr[:description]
          product.link = pr[:link]
          product.price = pr[:price]
          product.condition = pr[:condition]
          product.image_link = pr[:image_link]
          product.shipping_weight = pr[:shipping_weight]
          product.mpn = pr[:mpn]
          product.brand = pr[:brand]
          product.caliber = pr[:caliber]
          product.shipping_cost = pr[:shipping_cost]
          product.active = true
          product.save!
        end
      rescue => error
      end
    end
  end
end
