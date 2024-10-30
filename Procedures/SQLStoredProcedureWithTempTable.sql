create or replace procedure sp_overdue_borrowers_report()
language plpgsql
as $$
declare
    record_row record;
begin
    create temporary table temp_overdue_borrowers (
        borrower_id int primary key
    ) on commit drop;

    insert into temp_overdue_borrowers (borrower_id)
    select distinct l.borrower_id
    from loans l
    where l.due_date < current_date
      and l.date_returned is null;

    raise notice 'Overdue Books Report:';
    for record_row in
        select
            br.borrower_id,
            concat(br.first_name, ' ', br.last_name) as borrower_name,
            b.book_id,
            b.title,
            b.author,
            l.due_date
        from
            temp_overdue_borrowers tob
        join
            loans l on tob.borrower_id = l.borrower_id
        join
            books b on l.book_id = b.book_id
        join
            borrowers br on l.borrower_id = br.borrower_id
        where
            l.due_date < current_date
            and l.date_returned is null
    loop
        raise notice 'Borrower ID: %, Borrower Name: %, Book ID: %, Title: %, Author: %, Due Date: %',
            record_row.borrower_id,
            record_row.borrower_name,
            record_row.book_id,
            record_row.title,
            record_row.author,
            record_row.due_date;
    end loop;
end;
$$;


call sp_overdue_borrowers_report();

