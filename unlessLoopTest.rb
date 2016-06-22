students = [
  {name: "tony"},{name: "John"},{name: "Daisy"},{name: "Bob"}
]
index = 0
until index > students.count-1
  student = students[index]
  puts "index is #{index} name is #{student[:name]}"
  index +=1
end
