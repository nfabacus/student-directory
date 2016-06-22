
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    if name.length < 12
      # add the student hash to the array
      students << {name: name, cohort: :november}
      puts "Now we have #{students.count} students"
    else
      puts "Name has to be shorter than 12 characters. This name will not be added."
    end
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  puts "Student Search (Type 'quit' to quit)"
  while true
    puts "Please input the first letter of the students'name you want to search for:"
    firstLetter = gets.chomp.downcase
    if firstLetter == "quit"
      puts "quitting.."
      exit
    elsif firstLetter.length >1
      puts "Please type in only one letter."
      next
    elsif firstLetter.length <=0
      next
    end
    break
  end

  index = 0
  until index > students.count-1
    student = students[index]
    if student[:name][0].downcase==firstLetter
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
    index +=1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
