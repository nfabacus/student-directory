cohorts = [:January, :February, :March,
            :April, :May, :June,
            :July, :August, :September,
            :October, :November, :December]

students = [

  {name: "Dr. Hannibal Lecter", cohort: :november},
  {name: "Darth Vader", cohort: :december},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :january},
  {name: "Alex DeLarge", cohort: :november},
  {name: "The Wicked Witch of the West", cohort: :march},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :march},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november},
  {name: "Norman Bates", cohort: :january}
]

studentsByCohorts =[]
for i in 0..cohorts.length-1
studentsByCohorts = students.map{|student| student if student[:cohort].capitalize==cohorts[i]}
puts studentsByCohorts
end
