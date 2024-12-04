class Calculator
  attr_reader :name, :grades


  def initialize(name, grades)
    @name = name
    @grades = grades
    @gpa = 0
    @announcement = ''
  end

  def gpa
    total_points = 0
    valid_grades_count = 0

    base_grade_map = {
      "A" => 4.0,
      "B" => 3.0,
      "C" => 2.0,
      "D" => 1.0,
      "E" => 0.2,
      "F" => 0.0,
      "U" => -1.0
    }
    adjust_grade = lambda do |grade|
      base_grade = base_grade_map[grade[0]] # Get the base grade (e.g., A from A+) #0.5
      return nil if base_grade.nil? # Handle invalid grades

      if grade.include?("+")
        base_grade + 0.3 # Add 0.3 for +
      elsif grade.include?("-")
        if grade == "E-"
          base_grade = 0.1
        else
        base_grade - 0.3 # Subtract 0.3 for -
        end
      else
        base_grade # No adjustment
      end
    end
    @grades.each do |grade|
      adjusted_grade = adjust_grade.call(grade)
      puts adjusted_grade
      if adjusted_grade
        total_points += adjusted_grade
        valid_grades_count += 1
      else
        puts "Invalid grade encountered: #{grade}"
      end
    end

    @gpa = valid_grades_count > 0 ? (total_points / valid_grades_count).round(1) : "N/A"

 end

 def announcement
    if @gpa % 1 == 0
     @announcement = "#{@name} scored an average of #{@gpa.to_f}"
    else
     @announcement = "#{@name} scored an average of #{@gpa}"
    end
 end
end

## Do not edit below here ##################################################

tests = [
  { in: { name: 'Andy',  grades: ["A"] }, out: { gpa: 4, announcement: "Andy scored an average of 4.0"  } },
  { in: { name: 'Beryl',  grades: ["A", "B", "C"] }, out: { gpa: 3, announcement: "Beryl scored an average of 3.0"  } },
  { in: { name: 'Chris',  grades: ["B-", "C+"] }, out: { gpa: 2.5, announcement: "Chris scored an average of 2.5"  } },
  { in: { name: 'Dan',  grades: ["A", "A-", "B-"] }, out: { gpa: 3.5, announcement: "Dan scored an average of 3.5"  } },
  { in: { name: 'Emma',  grades: ["A", "B+", "F"] }, out: { gpa: 2.4, announcement: "Emma scored an average of 2.4"  } },
  { in: { name: 'Frida',  grades: ["E", "E-"] }, out: { gpa: 0.2, announcement: "Frida scored an average of 0.2"  } },
  { in: { name: 'Gary',  grades: ["U", "U", "B+"] }, out: { gpa: 0.4, announcement: "Gary scored an average of 0.4"  } },
]

# extension_for_more_advanced_error_handling = [
#   { in: { name: 'Non-grades',  grades: ["N"] } },
#   { in: { name: 'Non-strings',  grades: ["A", :B] } },
#   { in: { name: 'Empty',  grades: [] } },
#   { in: { name: 'Numbers',  grades: [1, 2] } },
#   { in: { name: 'Passed a string',  grades: "A A-" } },
# ]

tests.each do |test|
  user = Calculator.new(test[:in][:name], test[:in][:grades])

  puts "#{'-' * 10} #{user.name} #{'-' * 10}"

  [:gpa, :announcement].each do |method|
    result = user.public_send(method)
    expected = test[:out][method]

    if result == expected
      puts "✅ #{method.to_s.upcase}: #{result}"
    else
      puts "❌ #{method.to_s.upcase}: expected '#{expected}' but got '#{result}'"
    end
  end

  puts
end
