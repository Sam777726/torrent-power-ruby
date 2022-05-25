require_relative 'conv.rb' 

class Ev < Convert
  def initialize(energy_units,cd)
    @energy_units=energy_units
    @cd=cd
  end

  def ev
    tariff=0
    demand_charges=0
    bd = @cd > 100 ? @cd : 100
    tariff+=410*@energy_units
    tariff=paisa_to_rupee(tariff)
    if(bd>@cd)
      demand_charges += 25*@cd
      bd-=@cd
      demand_charges+=50*bd
    else 
      demand_charges += 25*bd
    end
    tariff+=demand_charges
  end
end
