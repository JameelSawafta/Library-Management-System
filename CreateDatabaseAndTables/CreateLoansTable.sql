create table loans (
    loan_id serial primary key,
    book_id int references books(book_id) on delete cascade,
    borrower_id int references borrowers(borrower_id) on delete cascade,
    date_borrowed date default current_date,
    due_date date not null,
    date_returned date
);
