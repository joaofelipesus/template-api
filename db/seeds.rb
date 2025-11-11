# Belts
Belt.find_or_create_by(name: "White", presences_required: 0, sequence_index: 1)
Belt.find_or_create_by(name: "Blue", presences_required: 100, sequence_index: 2)
Belt.find_or_create_by(name: "Purple", presences_required: 250, sequence_index: 3)
Belt.find_or_create_by(name: "Brown", presences_required: 400, sequence_index: 4)
Belt.find_or_create_by(name: "Black", presences_required: 600, sequence_index: 5)

# Students
Student.create_new_student!(name: "Khabib", age: 18)
Student.create_new_student!(name: "Alex", age: 34)
