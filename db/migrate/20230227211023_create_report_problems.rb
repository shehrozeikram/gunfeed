class CreateReportProblems < ActiveRecord::Migration[7.0]
  def change
    create_table :report_problems do |t|
      t.string :problem_with
      t.string :type_of_problem
      t.string :problem_details

      t.timestamps
    end
  end
end
