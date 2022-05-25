require_relative 'conv.rb' 

class Ltmd1 < Convert
  def initialize(energy_units,cd,pf)
    @energy_units=energy_units
    @cd=cd
    @pf=pf
  end

  def ltmd_1 
    tariff=0
    bd = @cd*0.85 > 6 ? @cd*0.85 : 6
    if(bd<=50)
      tariff+=465*@energy_units
    else 
      tariff+=480*@energy_units
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
    tariff=paisa_to_rupee(tariff)
    fixed_price=0
  
    if bd>50 
      fixed_price+=150*50
      bd-=50
      if bd>30
        fixed_price+=185*30
        bd-=30
        fixed_price+=245*bd
      else 
        fixed_price+=185*bd
      end
    else
      fixed_price+=150*bd
      if bd>@cd
        fixed_price+=350*(bd-@cd)
      end
    end
  
    tariff+=fixed_price
  end
end