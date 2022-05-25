require_relative 'conv.rb' 

class Htmd3 < Convert
  def initialize(energy_units,cd,pf)
    @energy_units=energy_units
    @cd=cd
    @pf=pf
  end
  def htmd_3 
    tariff=0
    bd = @cd*0.85 > 6 ? @cd*0.85 : 6
    tariff+=705*@energy_units
    @pf-=90
    if @pf<0 
      tariff+=@pf.abs*3
    elsif @pf>5
      tariff+=0.15*@energy_units*5
      @pf-=5
      tariff+=0.27*@energy_units*@pf
    else
      tariff+=0.15*@energy_units*@pf
    end
  
    tou_charge = 60*@energy_units
    tariff+=tou_charge
  
    tariff=paisa_to_rupee(tariff)
    fixed_price=0
  
    if bd>@cd
      fixed_price+=25*30*@cd
      fixed_price+=30*30*(bd-@cd)
    else 
      fixed_price+=25*30*bd
    end  
    
    tariff+=fixed_price
  end
end