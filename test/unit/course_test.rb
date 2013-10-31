require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'Course attributes must not be empty' do
    course = Course.new
    assert course.invalid?
    assert course.errors[:name].any?
    assert course.errors[:department_code].any?
    assert course.errors[:course_number].any?
  end

  test "Courses can't have the same name" do
    course1 = Course.new(name: "Introduction to Computer Science",
                        department_code: 'CSCI',
                        course_number: '101')
    assert course1.save
    course2 = Course.new(name: "Introduction to Computer Science",
                         department_code: 'CSCI2',
                         course_number: '102')
    assert !course2.save
    assert course2.errors[:name].any?
    # assert course2.errors[:department_code].valid?, 'Department Code shouldn\'t be invalid'
    # assert course2.errors[:course_number].valid?, 'Course Number shouldn\'t be invalid'
  end
end
