require_relative 'conv.rb' 

class Rgp < Convert
  def initialize(energy_units,phase)
    @energy_units=energy_units
    @phase=phase
  end

  def rgp
    tariff=0
    fixed_price = @phase==1 ? 25 : 65 
    if @energy_units>=50
      tariff+=320*50
      @energy_units-=50
      if @energy_units>=150
        tariff+=395*150
        @energy_units-=150
        if @energy_units>0
          tariff+=500*@energy_units
        end
      else tariff+=395*@energy_units
      end
    else tariff+=320*@energy_units
    end
    tariff=paisa_to_rupee(tariff)
    tariff+=fixed_price
  end

  def bpl
    tariff=0
    fixed_price=5
    if @energy_units>=50
      tariff+=150*50
      @energy_units-=50
      if @energy_units>=150
        tariff+=395*150
        @energy_units-=150
        if @energy_units>0
          tariff+=500*@energy_units
        end
      else tariff+=395*@energy_units
      end
    else tariff+=320*@energy_units
    end
    tariff=paisa_to_rupee(tariff)
    tariff+=5
  end
end