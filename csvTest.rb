@students = [{name: "Jim", cohort: "July"}, {name: "Kate", cohort: "July"}, {name: "George", cohort: "July"}]

require 'csv'
CSV.foreach("students.csv") do |line|
  name, cohort, hobby1, hobby2, hobby3, country_of_birth, height, weight = line[0], line[1], line[2],line[3],line[4],line[5],line[6],line[7]
  hobbies =[]
  hobbies << hobby1
  hobbies << hobby2
  hobbies << hobby3
  puts name+" "+cohort
end

CSV.open("studentsTest.csv", "wb") do |file|

  @students.each do |student|
    student = [student[:name], student[:cohort]]
    file << student
  end
end
