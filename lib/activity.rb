class Activity
  attr_reader :name, :participants

  def initialize(name)
    @name = name
    @participants = {}
  end

  def add_participant(name, pay)
    @participants[name] = pay
  end

  def total_cost
    total_cost = 0
    @participants.each do |participant|
      total_cost += participant[1]
    end
    total_cost
  end

  def split
    cost = total_cost
    people = @participants.length
    cost / people
  end

  def owed
     amount = split
    @participants.reduce({}) do |acc, participant|
      acc[participant[0]] = (amount - participant[1])
      acc
    end
  end
end
