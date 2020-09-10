class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.paranoid_status
    acts_as_paranoid column: 'status', 
                     column_type: 'string', 
                     deleted_value: 'removed', 
                     recovery_value: 'active'
  end
end