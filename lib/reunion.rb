class Reunion
  attr_reader :name, :activities

  def initialize(name)
    @name = name
    @activities = []
  end

  def add_activity(activity)
    @activities << activity
  end

  def total_cost
    @activities.reduce(0) do |acc, activity|
      activity.participants.each do |participant|
        acc += participant[1]
      end
      acc
    end
  end

  def breakout
    @activities.reduce(Hash.new(0)) do |acc, activity|
      activity.owed.each do |participant|
        acc[participant[0]] += participant[1]
      end
      acc
    end
  end

  def summary
    info = breakout
    string = info.reduce("") do |acc, kv|
      acc = acc + kv[0] + ":" + " " + kv[1].to_s + "\n"
      acc
    end
    string.chop
  end

  def detailed_breakout
  end
end
