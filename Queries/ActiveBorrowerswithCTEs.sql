with borrowed_books as (
    select
        borrower_id,
        count(*) as books_borrowed
    from
        loans
    where
        date_returned is null
    group by
        borrower_id
)

select b.borrower_id, b.first_name, b.last_name, b.email, b.membership_date, br.books_borrowed
from
    borrowers b
join
    borrowed_books br on b.borrower_id = br.borrower_id
where
    br.books_borrowed >= 2;

