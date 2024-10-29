select
    b.borrower_id, b.first_name, b.last_name, b.email,
    count(l.loan_id) as total_borrows,
    rank() over (order by count(l.loan_id) desc) as borrow_rank
from
    borrowers b
left join
    loans l on b.borrower_id = l.borrower_id
group by
    b.borrower_id, b.first_name, b.last_name, b.email
order by
    borrow_rank;
