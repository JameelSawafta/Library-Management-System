select
    b.genre,
    count(l.loan_id) as borrow_count,
    rank() over (order by count(l.loan_id) desc) as popularity_rank
from
    books b
join
    loans l on b.book_id = l.book_id
where
    date_trunc('month', l.date_borrowed) = '2002-09-01'::date
group by
    b.genre
order by
    popularity_rank;
