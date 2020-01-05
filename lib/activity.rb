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

  def payees(p_name)
    to_pay = {}
    p_owe = owed[p_name].positive?
    p_owed = owed[p_name].negative?
    if p_owe
      remaining = owed.reject {|part, amount| part == p_name
        amount.positive?}
      payee_amount = owed[p_name] / remaining.length
      payee = remaining.map {|part, amount| part}
    elsif p_owed
      remaining = owed.reject {|part, amount| part == p_name
        amount.negative?}
      payee_amount = owed[p_name] / remaining.length
      payee = remaining.map {|part, amount| part}
    end
    to_pay[payee] = payee_amount
    to_pay
  end

end
