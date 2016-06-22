
def input_students
  # create an empty array
  students = []
  # get the first name

  while true
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"
    name = gets.chomp

    if name.empty?
      break
    end

    if name.length >= 12
      puts "Name has to be shorter than 12 characters. This name will not be added."
      puts "Please enter a name under 12 characters."
      next
    end

    hobbies = []
    3.times do |x|
      puts "What is the student's hobby(#{x+1})?"
      hobby = gets.chomp
      hobbies << hobby unless hobby.empty?
    end

    puts "Where is the student's country of birth?"
    cOBirth = gets.chomp

    puts "What is the height of the student?"
    height = gets.chomp

    puts "What is the weight of the student?"
    weight = gets.chomp

    # add the student hash to the array
    students << {name: name, cohort: :november, hobbies: hobbies, country_of_birth: cOBirth, height: height, weight: weight  }
    puts "Now we have #{students.count} students"
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
      puts "  Hobbies: #{student[:hobbies].join(', ')}."
      puts "  Country of birth: #{student[:country_of_birth]}. Height: #{student[:height]}. Weight: #{student[:weight]}."
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
