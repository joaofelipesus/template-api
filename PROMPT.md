Adapt the application to handle users authentication and relate user and books.
1. configure the gem devise and auth using JWT, you can generate a token and fix the secret key as `token`;
2. create a route to authenticate user receiving email and password and returning the JWT token;
3. create a model to relate User and Book called UserBook, this model must have the columns user_id, book_id and progress_percentage(float 0-1);
4. create a rake task called `users:create` that creates the following users with the password `123123123`
    - user1@email.com
    - user2@email.com
5. create a rake task called `user_books:create` that creates three user_books records related to user1@email.com and two user_books records related to user2@email.com
6. configure JSONAPI;
7. create the following actions
  - POST /auth -> return a JWT token
  - GET /user_books -> return the current user related books (includes book)
  - GET /books/search -> this action must skip authentication

Follow the JSON api on every API response format.
Use the gem devise to implement authentication.
