create or replace procedure sp_AddNewBorrower(
    sp_first_name varchar(50),
    sp_last_name varchar(50),
    sp_email varchar(255),
    sp_date_of_birth date,
    sp_membership_date date default current_date
)
language plpgsql
as $$
declare
    existing_borrower_id int;
begin
    select borrower_id into existing_borrower_id
    from borrowers
    where borrowers.email = sp_email;

    if existing_borrower_id is not null then
        raise exception 'A borrower with this email already exists';
    else
        insert into borrowers (first_name, last_name, email, date_of_birth, membership_date)
        values (sp_first_name, sp_last_name, sp_email, sp_date_of_birth, sp_membership_date)
        returning borrower_id into existing_borrower_id;

        raise notice 'New borrower added with ID: %', existing_borrower_id;
    end if;
end;
$$;

call sp_AddNewBorrower('romeo', 'alfredo', 'romeo.alfredo@sawafta.com', '2000-08-04');

