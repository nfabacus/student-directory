require 'csv'

@students = []
@cohorts = [:January, :February, :March,
            :April, :May, :June,
            :July, :August, :September,
            :October, :November, :December]

def add_student_to_array (name, cohort, hobbies, country_of_birth, height, weight)
  @students << {name: name, cohort: cohort.to_sym, hobbies:hobbies, country_of_birth: country_of_birth, height: height, weight: weight}
end

def save_students (filename="students.csv")
  #open the file for writing
  CSV.open(filename, "wb") do |file|
    #iterate over the array of students
    @students.each do |student|
      student = [student[:name], student[:cohort], student[:hobbies][0], student[:hobbies][1], student[:hobbies][2],student[:country_of_birth], student[:height], student[:weight]]
      file << student
    end
  end
end

def load_students(filename= "students.csv")
  @students=[]
  CSV.foreach(filename) do |line|
    name, cohort, hobby1, hobby2, hobby3, country_of_birth, height, weight = line[0], line[1], line[2],line[3],line[4],line[5],line[6],line[7]
    hobbies =[]
    hobbies << hobby1
    hobbies << hobby2
    hobbies << hobby3
    add_student_to_array name, cohort, hobbies, country_of_birth, height, weight
  end
end

def input_students
  studentsAdded = 0
  while true
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"
    name = STDIN.gets.gsub(/\n/,"") #Used gsub instead of chomp

    if name.empty?
      break
    end

    if name.length >= 12
      puts "Name has to be shorter than 12 characters. This name will not be added."
      puts "Please enter a name under 12 characters."
      next
    end

    cohort = nil
    until !@cohorts.select{|month| month == cohort}.empty?
      puts "Which cohort is the student in? (January to December)"
      cohort = STDIN.gets.gsub(/\n/,"") #Used gsub instead of chomp
      cohort = "July" if cohort.empty?
      cohort = cohort.gsub(/\s+/,+"_").capitalize.to_sym
    end

    hobbies = []
    3.times do |x|
      puts "What is the student's hobby(#{x+1})?"
      hobby = STDIN.gets.chomp
      hobbies << hobby
    end

    puts "Where is the student's country of birth?"
    country_of_birth = STDIN.gets.chomp

    puts "What is the height of the student?"
    height = STDIN.gets.chomp

    puts "What is the weight of the student?"
    weight = STDIN.gets.chomp

    # add the student hash to the array
    add_student_to_array name, cohort, hobbies, country_of_birth, height, weight
    studentsAdded +=1
  end

  puts "#{studentsAdded} student(s) added."
  puts "Now we have #{@students.count} students"
  puts "Exiting to the main menu.."

end

def print_header
  puts " The students of Villains Academy ".center(120, "xxx")
  puts "-------------".center(120)
end

def print_students_list
  if @students.count == 0
    puts "No list to print.".center(120)
    return
  end

  selectedStudents = []
  puts "Student Search (Type 'quit' to quit)".center(120)
  while true
    puts "Please input the first letter of the students'name you want to search for:".center(120)
    firstLetter = STDIN.gets.chomp.downcase
    if firstLetter == "quit"
      puts "quitting.."
      exit
    elsif firstLetter.length >1
      puts "Please type in only one letter."
      next
    end
    break

  end

  index = 0
  until index > @students.count-1
    student = @students[index]
    if student[:name][0].downcase==firstLetter || firstLetter.empty?
      selectedStudents.push(student)

    end
    puts
    index +=1
  end

  for i in 0..@cohorts.length-1
    selectedStudents.map do |student|
      if student[:cohort]==@cohorts[i]
        puts "#{student[:name]} (#{student[:cohort]} cohort)".center(120)
        puts "Hobbies: #{student[:hobbies].join(', ')}.".center(120)
        puts "Country of birth: #{student[:country_of_birth]}".center(120)
        puts " Height: #{student[:height]} Weight: #{student[:weight]}".center(120)
        puts
      end
    end
  end
end

def print_footer()
  if @students.count ==1
    puts "Now we have #{@students.count} great student.".center(120)
  else
    puts "Overall, we have #{@students.count} great students.".center(120)
  end
end

def print_menu
  # 1. print the menu and ask the user what to do.
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items.
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
    puts "Displayed the student list successfully..back to the main menu.".center(120)
    puts
  when "3"
    filename = ask_filename "save"
    save_students(filename)
    puts "Saved students successfully..back to the main menu.".center(120)
    puts
  when "4"
    filename = ask_filename "load"
    load_students(filename)
    puts "Loaded students successfully..back to the main menu.".center(120)
    puts
  when "9"
    puts "Exiting the program...".center(120)
    puts
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again.".center(120)
  end
end

def ask_filename param
  loop do
    puts "Please type in the CSV file name (e.g. students.csv) Type q to quit."
    filename = STDIN.gets.chomp
    if filename == "q"
      puts "Exiting the program..."
      puts
      exit
    end
    next if filename.empty?

    if param =="save"
        return filename
    end

    if param == "load"
      if File.exists?(filename)
        return filename
      else
        puts "Sorry, #{filename} doesn't exist."
      end
    end
  end
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  if filename.nil?
    filename = "students.csv"
  end
  if File.exists?(filename) #if it exists
    load_students(filename)
  else #if it does not exist
    puts "Sorry, #{filename} doesn't exist."
    exit #quit the program
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu
