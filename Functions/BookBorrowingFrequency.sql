create or replace function fn_bookborrowingfrequency(fn_book_id int)
returns int
language plpgsql
as $$
declare
    borrowing_count int;
begin
    select count(*) into borrowing_count
    from loans
    where book_id = fn_bookborrowingfrequency.fn_book_id;

    return borrowing_count;
end;
$$;

select fn_bookborrowingfrequency(27);

