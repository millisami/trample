

input_row = []
10000.times do |t|
  input_row << "794828#{t},,#{t} Touch Marketing,123#{t} NW 13th St Ste 300,#{t}Boca Raton,#{t}FL,#{t}123 NW 13th St Ste 300,#{t}United States,#{t}561-368-5067,#{t}MANAGEMENT CONSULTING SERVICES,\"#{t}202,800,000\""
end

puts input_row

File.open('data.csv', 'w') { |f|
  input_row.each do |line|
    f.write(line + "\n") 
  end
}