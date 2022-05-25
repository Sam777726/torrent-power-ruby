require_relative 'conv.rb' 

class Glp < Convert 
  def initialize(energy_units,phase)
    @energy_units=energy_units
    @phase=phase
  end 

  def glp
    tariff=0
    fixed_price = @phase==1 ? 30 : 70 
    if @energy_units>=200
      tariff+=410*200
      @energy_units-=200
      if @energy_units>0
        tariff+=@energy_units*480
      end
    else
      tariff+=410*@energy_units
    end
    tariff=paisa_to_rupee(tariff)
    tariff+=fixed_price
  end
end