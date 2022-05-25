require_relative 'conv.rb' 

class Ltp < Convert
  def initialize(energy_units, bhp)
    @energy_units=energy_units
    @bhp=bhp
  end

  def ltp_ag
    tariff=0
    tariff+=340*@energy_units
    tariff=paisa_to_rupee(tariff)
    tariff+=10*@bhp
  end
end