Application = Struct.new(:founders_hustling?, :grinding_mode)

def millions_to_invest(application)
  if application.grinding_mode == :performative
    count = 2
  elsif application.grinding_mode == :real
    count = 1
  end

  count += 2 if application.founders_hustling?
  count
end
