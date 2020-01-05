require 'minitest/autorun'
require 'minitest/pride'
require './lib/activity'

class ActivityTest < Minitest::Test
  def setup
    @activity_1 = Activity.new("Brunch")
    @activity_2 = Activity.new("Drinks")
    @activity_3 = Activity.new("Bowling")
    @activity_4 = Activity.new("Jet Skiing")
  end

  def test_it_exists
    assert_instance_of Activity, @activity_1
  end

  def test_attributes

    assert_equal "Brunch", @activity_1.name
    assert_equal ({}), @activity_1.participants
  end

  def test_add_participants

    assert_equal ({}), @activity_1.participants
    @activity_1.add_participant("Maria", 20)
    assert_equal ({"Maria" => 20}), @activity_1.participants
  end

  def test_total_cost
    @activity_1.add_participant("Maria", 20)
    assert_equal 20, @activity_1.total_cost

    @activity_1.add_participant("Luther", 40)
    assert_equal ({"Maria" => 20, "Luther" => 40}), @activity_1.participants

    assert_equal 60, @activity_1.total_cost
  end

  def test_split
    @activity_1.add_participant("Maria", 20)
    @activity_1.add_participant("Luther", 40)

    assert_equal 30, @activity_1.split
  end

  def test_owed
    @activity_1.add_participant("Maria", 20)
    @activity_1.add_participant("Luther", 40)

    assert_equal ({"Maria" => 10, "Luther" => -10}), @activity_1.owed
  end

  def test_payees
    @activity_1.add_participant("Maria", 20)
    @activity_1.add_participant("Luther", 40)
    @activity_2.add_participant("Maria", 60)
    @activity_2.add_participant("Luther", 60)
    @activity_2.add_participant("Louis", 0)
    @activity_3.add_participant("Maria", 0)
    @activity_3.add_participant("Luther", 0)
    @activity_3.add_participant("Louis", 30)
    @activity_4.add_participant("Maria", 0)
    @activity_4.add_participant("Luther", 0)
    @activity_4.add_participant("Louis", 40)
    @activity_4.add_participant("Nemo", 40)


    assert_equal ({["Luther"] => 10}), @activity_1.payees("Maria")
    assert_equal ({["Louis"] => -20}), @activity_2.payees("Maria")
    assert_equal ({["Louis"] => 10}), @activity_3.payees("Maria")
    assert_equal ({["Louis", "Nemo"] => 10}), @activity_4.payees("Maria")
  end

end
