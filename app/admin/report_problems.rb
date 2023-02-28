ActiveAdmin.register ReportProblem do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :problem_with, :type_of_problem, :problem_details
  #
  # or
  #
  # permit_params do
  #   permitted = [:problem_with, :type_of_problem, :problem_details]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
