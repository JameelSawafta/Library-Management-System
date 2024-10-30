create table AuditLog (
    log_id serial primary key,
    book_id int not null references books(book_id) on delete cascade,
    status_change varchar(20) not null,
    change_date timestamp default current_timestamp
);


create or replace function log_status_change()
returns trigger
language plpgsql
as $$
begin
    if (new.current_status = 'borrowed' and old.current_status = 'available') or
       (new.current_status = 'available' and old.current_status = 'borrowed') then

        insert into AuditLog (book_id, status_change, change_date)
        values (new.book_id, concat(old.current_status, ' to ', new.current_status), current_timestamp);
    end if;

    return new;
end;
$$;

create trigger trg_status_change
after update of current_status on books
for each row
execute function log_status_change();

