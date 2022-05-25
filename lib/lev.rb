require_relative 'conv.rb' 

class Lev < Convert 
  def initialize(energy_units)
    @energy_units=energy_units
  end

  def lev
    tariff=0
    fixed_price=25
    tariff=420*@energy_units
    tariff+=fixed_price
  end
end