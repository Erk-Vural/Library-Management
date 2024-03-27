# Library Management System

The Library Management System is a C# application that utilizes PostgreSQL for database management. It provides functionalities for managing books, borrowers, and transactions within a library setting.

## Features

- **Book Management**: Add, edit, and delete books from the library collection.
- **Borrower Management**: Manage borrower information and memberships.
- **Transaction Tracking**: Keep track of borrowing and returning transactions.
- **Database Integration**: Utilize PostgreSQL for efficient and scalable database management.

## Technologies Used

- C#
- PostgreSQL

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your_username/library-management.git
   ```

2. Set up the PostgreSQL database:
   - Install PostgreSQL if not already installed.
   - Create a new database for the library management system.
   - Import the database schema from the provided SQL file (`libraryDB[1].sql`).

3. Open the project in Visual Studio or your preferred C# IDE.

4. Configure the database connection:
   - Modify the connection string in the C# code to match your PostgreSQL database credentials.

5. Build and run the application.

## Usage

1. Launch the application.
2. Use the provided interface to add books, manage borrowers, and track transactions.
3. Perform CRUD (Create, Read, Update, Delete) operations on books and borrowers as needed.
4. Record borrowing and returning transactions for library materials.
