Dir["/home/oem/Desktop/samyak/eval/lib/*.rb"].each {|file| require file }

class Main

  CATEGORIES = {"RGP" => "RGP : Residential Purpose (Up to & Including 15 KW)",
    "GLP" => "GLP : For Hospitals, Schools & Religious Purpose",
    "Non-RGP" => "Non-RGP : Commercial and Industrial Purpose (Up to & Including 15 KW)",
    "LTP-AG" => "LTP (AG) : For Agricultural Purpose",
    "LTMD-1" => "LTMD-1 : For Residential Purpose (Above 15 KW)",
    "LTMD-2"=> "LTMD-2 : For Commercial/Industrial Purpose (Above 15 KW)",
    "SL" => "SL : For Street Light",
    "LEV"=> "LEV : LT- Electric Vehicle Charging Stations",
    "TMP" => "TMP : For Temporary Supply (Below 100 kW)",
    "HTMD-1" => "HTMD-1 : For High Tension Load (100 kW & Above)",
    "HTMD-2" => "HTMD-2 : For High Tension AMC Pumping Stations",
    "HTMD-3" => "HTMD-3 : For Temporary Supply (100 kW & Above)",
    "EV"=> "EV : HT- Electric Vehicle Charging Stations",
    "HTMD" => "HTMD - Metro Traction",
    "exit" => "EXIT"
  }

  ERR_MSG = "Invalid input"
  attr_accessor:choice
  attr_reader :choice

  def initialize
    @choice="Y"
  end

  def validate_inputs(input)
    input > 0
  end

  def check_loop
    @choice == 'Y'
  end

  def print_menu
    CATEGORIES.map{|key, value| p value}
  end

  def err_msg
    p ERR_MSG
  end
end

if __FILE__== $0
  main = Main.new
  
  while main.check_loop do

    puts "\n\n#----------------------------------\nENTER CATEGORY:"
    main.print_menu
    cat = gets.chomp

    case cat.upcase
    when "RGP"
      puts "ENTER RGP for Residential General Purpose or BPL for Below Poverty Line"
      subcat = gets.chomp
      if subcat != nil
        if(subcat.upcase=="RGP")
          puts "ENTER ENERGY CONSUMPTIOPN IN UNITS: "
          energy_units = gets.chomp.to_f
          if main.validate_inputs(energy_units)
            puts "ENTER NUMBER OF PHASES(1 or 3): "
            phase = gets.chomp.to_i
            if(phase==1 or phase==3)
              puts "YOUR TARIFF IS Rs. #{Rgp.new(energy_units, phase).rgp}"
            else 
              puts main.err_msg
            end
          else 
            puts main.err_msg
          end
        elsif subcat.upcase=="BPL"
          puts "ENTER ENERGY CONSUMPTIOPN IN UNITS: "
          energy_units = gets.chomp.to_f
          if main.validate_inputs(energy_units)
            puts "YOUR TARIFF IS Rs. #{Rgp.new(energy_units).bpl}"
          else
            puts main.err_msg
          end
        else 
          puts main.err_msg
        end
      else 
        puts main.err_msg
      end

    when "GLP"
      puts "ENTER ENERGY CONSUMPTION IN UNITS: "
      energy_units = gets.chomp.to_f
      if main.validate_inputs(energy_units)
        puts "ENTER NUMBER OF PHASES(1 or 3): "
        phase = gets.chomp.to_i
        if(phase==1 or phase==3)
          puts "YOUR TARIFF IS Rs. #{Glp.new(energy_units,phase).glp}"
        else 
          puts main.err_msg
        end
      else 
        puts main.err_msg
      end


    when "NON-RGP"
      puts "ENTER ENERGY CONSUMPTION IN UNITS"
      energy_units = gets.chomp.to_f
      if main.validate_inputs(energy_units)
        puts "ENTER BILLING DEMAND"
        bd = gets.chomp.to_f
        if bd>15 or bd<0
          puts main.err_msg
        else
          puts "YOUR TARIFF IS Rs. #{NonRGP.new(energy_units, bd).non_rgp}"
        end
      else 
        puts main.err_msg
      end

    when "LTP"
      puts "ENTER ENERGY CONSUMPTION IN UNITS: "
      energy_units = gets.chomp.to_f
      if(main.validate_inputs(energy_units))
        puts "ENTER BHP"
        bhp = gets.chomp.to_f
        if( main.validate_inputs(bhp))
          puts "YOUR TARIFF IS Rs. #{Ltp.new(energy_units,bhp).ltp_ag}"
        else
          puts main.err_msg
        end
      else 
        puts main.err_msg
      end

    when "LTMD-1"
      puts "ENTER ENERGY CONSUMPTION IN UNITS: "
      energy_units = gets.chomp.to_f
      if(main.validate_inputs(energy_units))
        puts "ENTER CONTRACT DEMAND"
        cd = gets.chomp.to_f
        if main.validate_inputs(cd)
          puts "ENTER POWER FACTOR"
          pf = gets.chomp.to_f
          if main.validate_inputs(pf)
            puts "YOUR TARIFF IS Rs. #{Ltmd1.new(energy_units, cd, pf).ltmd_1}"
          else
            puts main.err_msg
          end
        else
          puts main.err_msg
        end
      else 
        puts main.err_msg
      end

    when "LTMD-2"
      puts "ENTER ENERGY CONSUMPTION IN UNITS: "
      energy_units = gets.chomp.to_f
      if main.validate_inputs(energy_units)
        puts "ENTER CONTRACT DEMAND"
        cd = gets.chomp.to_f
        if main.validate_inputs(cd)
        puts "ENTER POWER FACTOR"
        pf = gets.chomp.to_f
        if main.validate_inputs(pf)
          puts "YOUR TARIFF IS Rs. #{Ltmd2.new(energy_units, cd, pf).ltmd_2}"
        else puts main.err_msg
        end
      else puts main.err_msg
      end
    else puts main.err_msg
    end

    when "SL" 
      puts "ENTER ENERGY CONSUMPTION IN UNITS"
      energy_units = gets.chomp.to_f
      puts main.validate_inputs(energy_units) ? "YOUR TARIFF IS Rs. #{Sl.new(energy_units).sl}" : main.err_msg

    when "LEV" 
      puts "ENTER ENERGY CONSUMPTION IN UNITS"
      energy_units = gets.chomp.to_f
      puts main.validate_inputs(energy_units) ? "YOUR TARIFF IS Rs. #{Lev.new(energy_units).lev}" : main.err_msg

    when "TMP"
      puts "ENTER ENERGY CONSUMPTION IN UNITS"
      energy_units = gets.chomp.to_f
      if main.validate_inputs(energy_units)
        puts "ENTER BILLING DEMAND (in kW)"
        bd = gets.chomp.to_f
        if main.validate_inputs(bd)
          puts "YOUR TARIFF IS Rs. #{Tmp.new(energy_units,bd).tmp}"
        else puts main.err_msg
        end
      else puts main.err_msg
      end

    when "HTMD-1"
      puts "ENTER ENERGY CONSUMPTION IN UNITS: "
      energy_units = gets.chomp.to_f
      if main.validate_inputs(energy_units)
        puts "ENTER CONTRACT DEMAND"
        cd = gets.chomp.to_f
        if main.validate_inputs(cd)
          puts "ENTER POWER FACTOR"
          pf = gets.chomp.to_f
          if main.validate_inputs(pf)
            puts "ENTER UNITS CONSUMED DURING 10.00PM TO 06.00AM"
            nc = gets.chomp.to_f
            if main.validate_inputs (nc)
              puts "YOUR TARIFF IS Rs. #{Htmd1.new(energy_units, cd, pf, nc).htmd_1}"
            else puts main.err_msg
            end
          else puts main.err_msg
          end
        else puts main.err_msg
        end
      else puts main.err_msg
      end

    when "HTMD-2"
      puts "ENTER ENERGY CONSUMPTION IN UNITS: "
      energy_units = gets.chomp.to_f
      if main.validate_inputs(energy_units)
        puts "ENTER CONTRACT DEMAND"
        cd = gets.chomp.to_f
        if main.validate_inputs(cd)
          puts "ENTER POWER FACTOR"
          pf = gets.chomp.to_f
          if main.validate_inputs(pf)
            puts "ENTER UNITS CONSUMED DURING 10.00PM TO 06.00AM"
            nc = gets.chomp.to_f
            if main.validate_inputs (nc)
              puts "YOUR TARIFF IS Rs. #{Htmd2.new(energy_units, cd, pf, nc).htmd_2}"
            else puts main.err_msg
            end
          else puts main.err_msg
          end
        else puts main.err_msg
        end
      else puts main.err_msg
      end

    when "HTMD-3"
      puts "ENTER ENERGY CONSUMPTION IN UNITS: "
      energy_units = gets.chomp.to_f
      if main.validate_inputs(energy_units)
        puts "ENTER CONTRACT DEMAND"
        cd = gets.chomp.to_f
        if main.validate_inputs(cd)
          puts "ENTER POWER FACTOR"
          pf = gets.chomp.to_f
          if main.validate_inputs(pf)
            puts "YOUR TARIFF IS Rs. #{Htmd3.new(energy_units, cd, pf).htmd_3}"
          else puts main.err_msg
          end
        else puts main.err_msg
        end
      else puts main.err_msg
      end

    when "EV"
      puts "ENTER ENERGY CONSUMPTION IN UNITS"
      energy_units = gets.chomp.to_f
      if main.validate_inputs(energy_units)
        puts "ENTER CONTRACT DEMAND"
        cd = gets.chomp.to_f
        if main.validate_inputs(cd)
          puts "THE TARIFF IS Rs. #{Ev.new(energy_units,cd).ev}"
        else puts main.err_msg
        end
      else puts main.err_msg
      end

    when "HTMD"
      puts "ENTER ENERGY CONSUMPTION IN UNITS: "
      energy_units = gets.chomp.to_f
      if main.validate_inputs(energy_units)
        puts "ENTER CONTRACT DEMAND"
        cd = gets.chomp.to_f
        if main.validate_inputs(cd)
          puts "ENTER POWER FACTOR"
          pf = gets.chomp.to_f
          if main.validate_inputs(pf)
            puts "ENTER UNITS CONSUMED DURING 10.00PM TO 06.00AM"
            nc = gets.chomp.to_f
            if main.validate_inputs (nc)
              puts "YOUR TARIFF IS Rs. #{Htmd.new(energy_units, cd, pf, nc).htmd}"
            else puts main.err_msg
            end
          else puts main.err_msg
          end
        else puts main.err_msg
        end
      else puts main.err_msg
      end

    when "EXIT"
      puts "Do you really want to exit? (Y / N): "
      exit_choice = gets.chomp
      if(exit_choice[0].upcase=='Y')
        main.choice='N'
      end

    else 
      puts "invaliud"
    end

  end
end
