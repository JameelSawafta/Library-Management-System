select b.book_id, b.title, b.author, b.isbn, b.genre, b.shelf_location, l.date_borrowed, l.due_date, l.date_returned
from loans l
join books b ON l.book_id = b.book_id
where l.borrower_id = 84;

