create index index_loans_book_id on loans(book_id);
create index index_loans_borrower_id on loans(borrower_id);
create index index_loans_due_date on loans(due_date);
create index index_loans_date_returned on loans(date_returned);
create index index_loans_borrower_date_returned on loans(borrower_id, date_returned);

