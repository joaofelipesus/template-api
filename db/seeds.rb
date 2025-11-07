# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Cleaning database..."
ProjectUser.destroy_all
Task.destroy_all
Project.destroy_all
User.destroy_all
Company.destroy_all

puts "Creating companies..."
companies = [
  Company.create!(name: "Tech Innovations Inc"),
  Company.create!(name: "Digital Solutions Ltd"),
  Company.create!(name: "Cloud Systems Corp"),
  Company.create!(name: "Startup Ventures")
]
puts "Created #{companies.count} companies"

puts "Creating projects..."
projects = [
  Project.create!(name: "E-commerce Platform", company: companies[0]),
  Project.create!(name: "Mobile App Development", company: companies[0]),
  Project.create!(name: "CRM System", company: companies[1]),
  Project.create!(name: "Data Analytics Dashboard", company: companies[1]),
  Project.create!(name: "Cloud Migration", company: companies[2]),
  Project.create!(name: "API Gateway", company: companies[2]),
  Project.create!(name: "MVP Development", company: companies[3]),
  Project.create!(name: "Marketing Website", company: companies[3])
]
puts "Created #{projects.count} projects"

puts "Creating users..."
users = [
  User.create!(name: "Alice Johnson", email: "alice.johnson@example.com"),
  User.create!(name: "Bob Smith", email: "bob.smith@example.com"),
  User.create!(name: "Carol Williams", email: "carol.williams@example.com"),
  User.create!(name: "David Brown", email: "david.brown@example.com"),
  User.create!(name: "Emma Davis", email: "emma.davis@example.com"),
  User.create!(name: "Frank Miller", email: "frank.miller@example.com"),
  User.create!(name: "Grace Wilson", email: "grace.wilson@example.com"),
  User.create!(name: "Henry Moore", email: "henry.moore@example.com"),
  User.create!(name: "Iris Taylor", email: "iris.taylor@example.com"),
  User.create!(name: "Jack Anderson", email: "jack.anderson@example.com")
]
puts "Created #{users.count} users"

puts "Assigning users to projects..."
# E-commerce Platform - 4 users
projects[0].users << [users[0], users[1], users[2], users[3]]

# Mobile App Development - 3 users
projects[1].users << [users[1], users[4], users[5]]

# CRM System - 5 users
projects[2].users << [users[0], users[2], users[6], users[7], users[8]]

# Data Analytics Dashboard - 3 users
projects[3].users << [users[3], users[4], users[9]]

# Cloud Migration - 4 users
projects[4].users << [users[5], users[6], users[7], users[8]]

# API Gateway - 2 users
projects[5].users << [users[0], users[9]]

# MVP Development - 3 users
projects[6].users << [users[2], users[4], users[6]]

# Marketing Website - 2 users
projects[7].users << [users[1], users[3]]

puts "Users assigned to projects"

puts "Creating tasks..."
task_categories = ["Development", "Testing", "Design", "Documentation", "Bug Fix", "Research", "Deployment", "Review"]

# Tasks for E-commerce Platform
Task.create!(category: "Development", project: projects[0], user: users[0])
Task.create!(category: "Design", project: projects[0], user: users[2])
Task.create!(category: "Testing", project: projects[0], user: users[1])
Task.create!(category: "Documentation", project: projects[0], user: users[3])
Task.create!(category: "Bug Fix", project: projects[0], user: users[0])

# Tasks for Mobile App Development
Task.create!(category: "Development", project: projects[1], user: users[1])
Task.create!(category: "Design", project: projects[1], user: users[4])
Task.create!(category: "Testing", project: projects[1], user: users[5])
Task.create!(category: "Deployment", project: projects[1], user: users[1])

# Tasks for CRM System
Task.create!(category: "Development", project: projects[2], user: users[6])
Task.create!(category: "Research", project: projects[2], user: users[7])
Task.create!(category: "Testing", project: projects[2], user: users[8])
Task.create!(category: "Documentation", project: projects[2], user: users[0])
Task.create!(category: "Review", project: projects[2], user: users[2])

# Tasks for Data Analytics Dashboard
Task.create!(category: "Development", project: projects[3], user: users[3])
Task.create!(category: "Design", project: projects[3], user: users[4])
Task.create!(category: "Testing", project: projects[3], user: users[9])

# Tasks for Cloud Migration
Task.create!(category: "Research", project: projects[4], user: users[5])
Task.create!(category: "Development", project: projects[4], user: users[6])
Task.create!(category: "Testing", project: projects[4], user: users[7])
Task.create!(category: "Deployment", project: projects[4], user: users[8])
Task.create!(category: "Documentation", project: projects[4], user: users[5])

# Tasks for API Gateway
Task.create!(category: "Development", project: projects[5], user: users[0])
Task.create!(category: "Documentation", project: projects[5], user: users[9])
Task.create!(category: "Testing", project: projects[5], user: users[0])

# Tasks for MVP Development
Task.create!(category: "Development", project: projects[6], user: users[2])
Task.create!(category: "Design", project: projects[6], user: users[4])
Task.create!(category: "Testing", project: projects[6], user: users[6])
Task.create!(category: "Bug Fix", project: projects[6], user: users[2])

# Tasks for Marketing Website
Task.create!(category: "Design", project: projects[7], user: users[1])
Task.create!(category: "Development", project: projects[7], user: users[3])
Task.create!(category: "Review", project: projects[7], user: users[1])

total_tasks = Task.count
puts "Created #{total_tasks} tasks"

puts "\n" + "="*50
puts "SEED DATA SUMMARY"
puts "="*50
puts "Companies: #{Company.count}"
puts "Projects: #{Project.count}"
puts "Users: #{User.count}"
puts "Tasks: #{Task.count}"
puts "Project-User Assignments: #{ProjectUser.count}"
puts "="*50
puts "\nSample Data:"
puts "\nCompanies with their projects:"
Company.includes(:projects).each do |company|
  puts "  #{company.name} (#{company.projects.count} projects)"
  company.projects.each do |project|
    puts "    - #{project.name} (#{project.users.count} users, #{project.tasks.count} tasks)"
  end
end

puts "\nUsers and their project assignments:"
User.includes(:projects).limit(3).each do |user|
  puts "  #{user.name} - #{user.projects.count} project(s), #{user.tasks.count} task(s)"
end

puts "\n✅ Seeding completed successfully!"
