# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
["Fiction", "Non-Fiction", "Mystery", "Romance", "Science Fiction", "Fantasy", "Biography", "History", "Self-Help", "Cooking"].each do |subject_name|
  Subject.find_or_create_by!(name: subject_name)
end

# Create authors
authors_data = [
  "Jane Austen", "Charles Dickens", "Mark Twain", "Virginia Woolf", "Ernest Hemingway",
  "F. Scott Fitzgerald", "George Orwell", "Harper Lee", "J.K. Rowling", "Stephen King",
  "Agatha Christie", "Arthur Conan Doyle", "Margaret Atwood", "Toni Morrison", "Maya Angelou",
  "Gabriel García Márquez", "Leo Tolstoy", "William Shakespeare", "Emily Dickinson", "Edgar Allan Poe"
]

authors = authors_data.map do |author_name|
  Author.find_or_create_by!(name: author_name)
end

# Create books
books_data = [
  { title: "Pride and Prejudice", subtitle: "", author: "Jane Austen", subject: "Fiction", isbn: "9780141439518", pages: 432, description: "A romantic novel following Elizabeth Bennet as she deals with issues of manners, upbringing, morality, education, and marriage." },
  { title: "Great Expectations", subtitle: "", author: "Charles Dickens", subject: "Fiction", isbn: "9780141439563", pages: 544, description: "The story of Pip, an orphan who rises from humble beginnings to discover that life's greatest wealth is found in the friends we make and the love we share." },
  { title: "The Adventures of Tom Sawyer", subtitle: "", author: "Mark Twain", subject: "Fiction", isbn: "9780486400778", pages: 272, description: "The adventures of a mischievous boy growing up along the Mississippi River in the 1840s." },
  { title: "Mrs. Dalloway", subtitle: "", author: "Virginia Woolf", subject: "Fiction", isbn: "9780156628709", pages: 194, description: "A day in the life of Clarissa Dalloway, a fictional upper-class woman in post-World War I England." },
  { title: "The Sun Also Rises", subtitle: "", author: "Ernest Hemingway", subject: "Fiction", isbn: "9780743297332", pages: 251, description: "A group of American and British expatriates travel from Paris to Pamplona to watch the running of the bulls and the bullfights." },
  { title: "The Great Gatsby", subtitle: "", author: "F. Scott Fitzgerald", subject: "Fiction", isbn: "9780743273565", pages: 180, description: "A critique of the American Dream set in the Jazz Age, following the mysterious millionaire Jay Gatsby and his obsession with Daisy Buchanan." },
  { title: "1984", subtitle: "", author: "George Orwell", subject: "Fiction", isbn: "9780451524935", pages: 328, description: "A dystopian social science fiction novel about totalitarian control and the consequences of mass surveillance." },
  { title: "To Kill a Mockingbird", subtitle: "", author: "Harper Lee", subject: "Fiction", isbn: "9780061120084", pages: 376, description: "A coming-of-age story dealing with serious issues of rape and racial inequality through the eyes of young Scout Finch." },
  { title: "Harry Potter and the Sorcerer's Stone", subtitle: "", author: "J.K. Rowling", subject: "Fantasy", isbn: "9780439708180", pages: 309, description: "An orphaned boy discovers he's a wizard and begins his magical education at Hogwarts School of Witchcraft and Wizardry." },
  { title: "The Shining", subtitle: "", author: "Stephen King", subject: "Fiction", isbn: "9780307743657", pages: 447, description: "A psychological horror novel about a writer who becomes the winter caretaker of an isolated hotel and descends into madness." },
  { title: "Murder on the Orient Express", subtitle: "", author: "Agatha Christie", subject: "Mystery", isbn: "9780062693662", pages: 256, description: "Detective Hercule Poirot investigates a murder aboard the famous Orient Express train." },
  { title: "The Hound of the Baskervilles", subtitle: "", author: "Arthur Conan Doyle", subject: "Mystery", isbn: "9780486282145", pages: 176, description: "Sherlock Holmes investigates the legend of a supernatural hound on the moors of Devonshire." },
  { title: "The Handmaid's Tale", subtitle: "", author: "Margaret Atwood", subject: "Fiction", isbn: "9780385490818", pages: 311, description: "A dystopian novel set in a near-future totalitarian society where women have lost all their rights." },
  { title: "Beloved", subtitle: "", author: "Toni Morrison", subject: "Fiction", isbn: "9781400033416", pages: 324, description: "A powerful story about an escaped slave haunted by the ghost of her dead daughter." },
  { title: "I Know Why the Caged Bird Sings", subtitle: "", author: "Maya Angelou", subject: "Biography", isbn: "9780345514400", pages: 289, description: "An autobiographical account of the author's childhood and coming of age in the American South." },
  { title: "One Hundred Years of Solitude", subtitle: "", author: "Gabriel García Márquez", subject: "Fiction", isbn: "9780060883287", pages: 417, description: "A multi-generational story of the Buendía family in the fictional town of Macondo." },
  { title: "War and Peace", subtitle: "", author: "Leo Tolstoy", subject: "Fiction", isbn: "9780199232765", pages: 1392, description: "An epic novel chronicling the French invasion of Russia and its impact on Tsarist society." },
  { title: "Romeo and Juliet", subtitle: "", author: "William Shakespeare", subject: "Fiction", isbn: "9780743477116", pages: 304, description: "The tragic story of two young star-crossed lovers whose deaths ultimately unite their feuding families." },
  { title: "The Complete Poems", subtitle: "", author: "Emily Dickinson", subject: "Fiction", isbn: "9780316184137", pages: 770, description: "A collection of poetry exploring themes of death, immortality, and nature with innovative style and form." },
  { title: "The Complete Tales and Poems", subtitle: "", author: "Edgar Allan Poe", subject: "Fiction", isbn: "9780394604237", pages: 1026, description: "A comprehensive collection of Poe's haunting tales of mystery and macabre poetry." }
]

books_data.each do |book_data|
  author = authors.find { |a| a.name == book_data[:author] }
  subject = Subject.find_by(name: book_data[:subject])

  book = Book.find_or_create_by!(
    title: book_data[:title],
    subtitle: book_data[:subtitle],
    description: book_data[:description],
    isbn: book_data[:isbn],
    pages: book_data[:pages],
  )

  book.authors << author
  book.subjects << subject
  book.save!
end
