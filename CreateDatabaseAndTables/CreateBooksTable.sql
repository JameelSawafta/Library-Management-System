create table books (
    book_id serial primary key,
    title varchar(255) not null,
    author varchar(255) not null,
    isbn varchar(20) unique not null,
    published_date date,
    genre varchar(50),
    shelf_location varchar(50),
    current_status varchar(10) default 'available' check (current_status in ('available', 'borrowed'))
);
