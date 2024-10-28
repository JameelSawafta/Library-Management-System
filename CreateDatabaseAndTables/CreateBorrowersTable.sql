create table borrowers (
    borrower_id serial primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(255) unique not null,
    date_of_birth date,
    membership_date date default current_date
);
