
def input_students (existingList)
  students = existingList
  cohorts = [:January, :February, :March,
              :April, :May, :June,
              :July, :August, :September,
              :October, :November, :December]
  while true
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"
    name = gets.gsub(/\n/,"") #Used gsub instead of chomp

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
      cohort = gets.gsub(/\n/,"") #Used gsub instead of chomp
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
  if students.count == 0
    puts "No list to print.".center(120)
    return
  end

  selectedStudents = []
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
      selectedStudents.push(student)

    end
    puts
    index +=1
  end

  cohorts = [:January, :February, :March,
              :April, :May, :June,
              :July, :August, :September,
              :October, :November, :December]

  for i in 0..cohorts.length-1
    selectedStudents.map do |student|
      if student[:cohort]==cohorts[i]
        puts "#{student[:name]} (#{student[:cohort]} cohort)".center(120)
        puts "Hobbies: #{student[:hobbies].join(', ')}.".center(120)
        puts "Country of birth: #{student[:country_of_birth]}".center(120)
        puts " Height: #{student[:height]} Weight: #{student[:weight]}".center(120)
        puts
      end
    end
  end
end

def print_footer(names)
  if names.count ==1
    puts "Now we have #{names.count} great student.".center(120)
  else
    puts "Overall, we have #{names.count} great students.".center(120)
  end
end

def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do.
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items.
    #2. read the input and save it into a variable.
    selection = gets.chomp
    #3. do what the user has asked.
    case selection
    when "1"
      students = input_students(students)
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again."
    end
  end
end

interactive_menu
