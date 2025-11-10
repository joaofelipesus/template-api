namespace :user_books do
  desc "Create user_books records"
  task create: :environment do
    # Find users
    user1 = User.find_by(email: 'user1@email.com')
    user2 = User.find_by(email: 'user2@email.com')

    unless user1 && user2
      puts "Users not found. Please run 'rake users:create' first."
      exit
    end

    # Get or create some books
    books = Book.limit(5)
    if books.count < 5
      puts "Not enough books in the database. Creating sample books..."
      5.times do |i|
        Book.create!(
          title: "Sample Book #{i + 1}",
          subtitle: "Subtitle #{i + 1}",
          description: "Description for sample book #{i + 1}",
          pages: 100 + (i * 50),
          isbn: "978-0-#{i}#{i}#{i}-#{i}#{i}#{i}#{i}-#{i}"
        )
      end
      books = Book.limit(5)
    end

    # Create user_books for user1 (3 records)
    3.times do |i|
      user_book = UserBook.find_or_create_by(user: user1, book: books[i]) do |ub|
        ub.progress_percentage = (i + 1) * 0.25
      end
      puts "Created user_book for #{user1.email} - Book: #{books[i].title}, Progress: #{user_book.progress_percentage}"
    end

    # Create user_books for user2 (2 records)
    2.times do |i|
      user_book = UserBook.find_or_create_by(user: user2, book: books[i + 3]) do |ub|
        ub.progress_percentage = (i + 1) * 0.5
      end
      puts "Created user_book for #{user2.email} - Book: #{books[i + 3].title}, Progress: #{user_book.progress_percentage}"
    end

    puts "User books created successfully!"
  end
end
