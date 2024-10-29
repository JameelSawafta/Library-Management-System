select
    b.author,
    count(l.loan_id) as borrowing_frequency
from
    books b
left join
    loans l on b.book_id = l.book_id
group by
    b.author
order by
    borrowing_frequency desc;


