require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
 # Replace this with your real tests.
 def test_unique_assignment
   
   p = Project.first
   w = Week.first
   e = Engineer.first
   assert_not_nil(p)
   assert_not_nil(w)
   assert_not_nil(e)
   a = Assignment.new(:engineer => e, :week => w, :project => p)
   assert_not_nil(a)
   a.save
   assert a.valid?
   
   a2 = Assignment.new(:engineer => e, :week => w, :project => p)
   assert !a2.valid?
   
 end
end