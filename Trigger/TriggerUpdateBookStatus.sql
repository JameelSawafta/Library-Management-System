create or replace function update_book_status_to_borrowed()
returns trigger
language plpgsql
as $$
begin
    update books
    set current_status = 'borrowed'
    where book_id = new.book_id
      and current_status = 'available';

    return new;
end;
$$;


create trigger trg_update_book_status
after insert on loans
for each row
execute function update_book_status_to_borrowed();

