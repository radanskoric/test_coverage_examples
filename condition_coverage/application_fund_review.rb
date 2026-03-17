Application = Struct.new(:founders_hustling?, :grinding_mode, :space)

def blockchain_relevant?
  Date.today.year < 2022
end

def millions_to_invest(application)
  count = 0
  if application.grinding_mode == :performative
    count = 2
  elsif application.grinding_mode == :real
    count = 1
  end

  count += 2 if application.founders_hustling?
  count += 2 if application.space == :ai || (application.space == :blockchain && blockchain_relevant?)
  count
end
