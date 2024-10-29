create or replace function fn_calculateoverduefees(fn_loan_id int)
returns numeric
language plpgsql
as $$
declare
    overdue_days int;
    fee numeric := 0;
begin
    select greatest(0, date_returned - due_date) into overdue_days
    from loans
    where loan_id = fn_calculateoverduefees.fn_loan_id;

    if overdue_days > 0 then
        if overdue_days <= 30 then
            fee := overdue_days * 1; -- $1 per day for the first 30 days
        else
            fee := (30 * 1) + ((overdue_days - 30) * 2); -- $2 per day after 30 days
        end if;
    end if;

    return fee;
end;
$$;

select fn_calculateoverduefees(123);

