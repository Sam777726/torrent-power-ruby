require_relative 'conv.rb' 

class Sl < Convert
  def initialize(energy_units)
    @energy_units=energy_units
  end

  def sl
    tariff=0
    tariff=430*@energy_units
    tariff=paisa_to_rupee(tariff)
  end
end