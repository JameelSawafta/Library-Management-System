select
    b.title, b.author, b.isbn, b.published_date,
    br.first_name, br.last_name, br.email,
    l.date_borrowed, l.due_date
from
    loans l
join
    books b on l.book_id = b.book_id
join
    borrowers br on l.borrower_id = br.borrower_id
where
    l.due_date < current_date - interval '30 days'
    and l.date_returned is null;

