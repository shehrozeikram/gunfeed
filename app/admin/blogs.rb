ActiveAdmin.register Blog do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description, :image, :video

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :title
      f.input :description
      # f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
      f.input :image, as: :file, input_html: { multiple: true }
      f.input :video, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

end
