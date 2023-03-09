class AddConstraintInVotes < ActiveRecord::Migration[7.0]
  def change
    add_check_constraint :votes, 'value = 1 or value = -1', name: 'value_check'
  end
end
