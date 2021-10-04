select * from parts
limit 10;

--make code not nullable
alter table parts
alter column code set not null ;

--add unique constraint to code column
alter table parts
add unique(code);

--backfilling
update parts
set description='Not Available'
where description is null;

--set not nullable constraints
alter table parts
alter column description set not null;

--testing not nullable constraints on description 
insert into parts(id,code,manufacturer_id)  
values(54 ,'V1-009', 9);

/*
add not null constraints to price_usd and quantity columns in reorder_options tabel
*/
alter table reorder_options
alter column price_usd set not null;

alter table reorder_options
alter column quantity set not null;

--adding check const. on price.& qnt columns
alter table reorder_options
add check(price_usd>0 and quantity>0);

--const. on price per unit
alter table reorder_options
add check(price_usd/quantity >0.02 and price_usd/quantity<25);

--adding primary key to parts table
alter table parts
add primary key(id);

--specifying a foreign key or reorder_op.
alter table reorder_options
add foreign key(part_id)
references parts(id) on delete cascade;

--check constr. on qty in locations table
alter table locations
add check(qty >0);

--unique const on a part and it location
alter table locations
add unique(part_id,location);

--foreign to point to part primary key in locat.
alter table locations
add foreign key(part_id)
references parts(id) on delete cascade;

--const. to check integrity btn parts & manufcters.
alter table manufacturers
add primary key(id);

alter table parts
add foreign key(manufacturer_id)
references manufacturers(id) on delete cascade;

--testing constrainst on manufacturers n parts
insert into manufacturers values(11, 'Pip-NNC');

select * from manufacturers;

update parts
set manufacturer_id=11
where manufacturer_id in(1,2)
