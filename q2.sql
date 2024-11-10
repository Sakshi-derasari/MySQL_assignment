create database q2;
use q2;
create table info (
    FirstName varchar(50) not null primary key,
    LastName varchar(50) not null,
    Address varchar(100),
    City varchar(50),
    Age int
);
insert into info values("Mickey","Mouse","123 Fantasy Way","Anaheim",73),("Bat","Man","321 Canvern Ave","Gotham",53),("Wonder","woman","987 Truth Way","Paradise",39),("Donald","Duck","555 Quack street","Mallard",65),("Bugs","Bunny","567 Carrot Street","Rascal",58),("Wiley","Coyote","999 Acme Way","Canyon",61),("Cat","Woman","234 Purrfect Street","Hairball",32),("Tweety","Bird","543","Itotltow",28);
select * from info;