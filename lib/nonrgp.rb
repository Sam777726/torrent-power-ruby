require_relative 'conv.rb' 

class NonRGP < Convert
  def initialize(energy_units,bd)
    @energy_units=energy_units
    @bd=bd
  end

  def non_rgp
    tariff=0
    fixed_price=0
    if(@bd<=5)
      fixed_price=70*@bd
    elsif @bd>5 and @bd<=15
      fixed_price=90*@bd
    end
    tariff=@energy_units*460
    tariff=paisa_to_rupee(tariff)
    tariff+=fixed_price
  end
end