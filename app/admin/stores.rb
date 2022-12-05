ActiveAdmin.register Store do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :store_xml_feed_url
  #
  # or
  #
  # permit_params do
  #   permitted = [:title]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  #
  #
  #   form(html: {multipart: true}) do |f|
  #     f.inputs do
  #       f.input :ad_title
  #       f.input :ad_type
  #       f.input :attachments, as: :file, input_html: { multiple: true }
  #     end
  #     f.actions
  #   end
  #
  #   index do
  #     selectable_column
  #     id_column
  #     column :ad_title
  #     column :ad_type
  #     column :attachments do |ad|
  #       ul do
  #         ad.attachments.each do |image|
  #           li do
  #             image_tag(image.url, width: 100, height: 100) rescue ""
  #           end
  #         end
  #       end
  #     end
  #     actions
  #   end
  # require 'json'
  # require 'net/http'
  # require 'active_support/core_ext/hash'
  # s = Net::HTTP.get_response(URI.parse('https://feeds.feedgeni.com/custom_feeds/stores/115044/feed/3372/Spiguns.xml'))

end
