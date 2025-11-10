namespace :users do
  desc "Create default users"
  task create: :environment do
    users_data = [
      { email: 'user1@email.com', password: '123123123' },
      { email: 'user2@email.com', password: '123123123' }
    ]

    users_data.each do |user_data|
      user = User.find_or_initialize_by(email: user_data[:email])
      if user.new_record?
        user.password = user_data[:password]
        user.password_confirmation = user_data[:password]
        user.save!
        puts "Created user: #{user.email}"
      else
        puts "User already exists: #{user.email}"
      end
    end
  end
end
