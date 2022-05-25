require_relative 'conv.rb' 

class Htmd1 < Convert
  def initialize(energy_units,cd,pf,nc)
    @energy_units=energy_units
    @cd=cd
    @pf=pf
    @nc=nc
  end

  def htmd_1 
    tariff=0
    bd = @cd*0.85 > 100 ? @cd*0.85 : 100
    if(@energy_units>=400)
      tariff+=455*400
      tariff+=445*(@energy_units-400)
    else 
      tariff+=455*@energy_units
    end
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
    tou_charge = bd<=300 ? 80*@energy_units : 100*@energy_units 
    tariff+=tou_charge
    night_charge = 30*@nc
  
    tariff+=night_charge
    
    tariff=paisa_to_rupee(tariff)
    fixed_price=0
  
    if bd<1000
      if bd>@cd
        fixed_price+=385*(bd-@cd)
      end 
      fixed_price+=260*bd
    else bd>1000 
      fixed_price+=335*bd
    end
    tariff+=fixed_price
  end
end