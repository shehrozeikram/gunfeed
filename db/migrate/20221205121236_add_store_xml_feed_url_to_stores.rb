class AddStoreXmlFeedUrlToStores < ActiveRecord::Migration[7.0]
  def change
    add_column :stores, :store_xml_feed_url, :string
  end
end
