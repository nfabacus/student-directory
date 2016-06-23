
def input_students ()
  students = []
  cohorts = [:January, :February, :March,
              :April, :May, :June,
              :July, :August, :September,
              :October, :November, :December]
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

    cohort = nil
    until !cohorts.select{|month| month == cohort}.empty?
      puts "Which cohort is the student in? (January to December)"
      cohort = gets.chomp
      cohort = "July" if cohort.empty?
      cohort = cohort.gsub(/\s+/,+"_").capitalize.to_sym
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
    students << {name: name, cohort: cohort, hobbies: hobbies, country_of_birth: cOBirth, height: height, weight: weight  }
    puts "Now we have #{students.count} students"
    puts
  end
  # return the array of students
  students
end

def print_header
  puts " The students of Villains Academy ".center(120, "xxx")
  puts "-------------".center(120)
end

def print(students)
  puts "Student Search (Type 'quit' to quit)".center(120)
  while true
    puts "Please input the first letter of the students'name you want to search for:".center(120)
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
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)".center(120)
      puts "Hobbies: #{student[:hobbies].join(', ')}.".center(120)
      puts "Country of birth: #{student[:country_of_birth]}".center(120)
      puts " Height: #{student[:height]} Weight: #{student[:weight]}".center(120)
    end
    puts
    index +=1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(120)
end

students = input_students
print_header
print(students)
print_footer(students)
