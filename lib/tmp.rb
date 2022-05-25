require_relative 'conv.rb' 

class Tmp < Convert
  def initialize(energy_units,bd)
    @energy_units=energy_units
    @bd=bd
  end

  def tmp
    tariff=0
    tariff+=510*@energy_units
    tariff=paisa_to_rupee(tariff)
    fixed_price=25*30*@bd
    tariff+=fixed_price
  end
end