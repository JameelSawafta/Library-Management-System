create or replace procedure sp_borrowedbooksreport(
    start_date date,
    end_date date
)
language plpgsql
as $$
declare
    borrowed_book record;
begin
    raise notice 'Borrowed Books Report:';

    for borrowed_book in
        select
            b.book_id,
            b.title,
            b.author,
            br.borrower_id, concat(br.first_name, ' ', br.last_name) as borrower_name,
            l.date_borrowed
        from
            loans l
        join
            books b on l.book_id = b.book_id
        join
            borrowers br on l.borrower_id = br.borrower_id
        where
            l.date_borrowed between start_date and end_date
        order by
            l.date_borrowed
    loop
        raise notice 'Book ID: %, Title: %, Author: %, Borrower ID: %, Borrower Name: %, Date Borrowed: %',
            borrowed_book.book_id,
            borrowed_book.title,
            borrowed_book.author,
            borrowed_book.borrower_id,
            borrowed_book.borrower_name,
            borrowed_book.date_borrowed;
    end loop;

end;
$$;


call sp_borrowedbooksreport('2024-01-01', '2024-12-31');
