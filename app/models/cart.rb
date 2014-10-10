class Cart < ActiveRecord::Base
# Just what do these various declarations do? Basically, they add navigation
# capabilities to the model objects. Because we added the belongs_to declaration
# to LineItem, we can now retrieve its Product and display the book’s title:
# li = LineItem.find(...)
# puts "This line item is for #{li.product.title}"
#default_scope {order('updated_at DESC')}
#default_scope { where(color: 'red') }
belongs_to :place
belongs_to :user

  #class TeacherSchedule < ActiveRecord::Base
  #validates_uniqueness_of :teacher_id, scope: [:semester_id, :class_id]
  #class Person < ActiveRecord::Base
  #validates_uniqueness_of :user_name, scope: :account_id
  
  # validates_uniqueness_of :user_id, scope: :place_id, conditions: -> { where(checked_num: '1') }

end
