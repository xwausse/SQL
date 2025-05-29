--Define the following terms: data, database, relational database, and table.
1)Ma’lumot — bu xom holatdagi faktlar, raqamlar yoki belgilar bo‘lib, ular o‘z-o‘zidan ma’no anglatmaydi, lekin qayta ishlanganda foydali axborotga aylanishi mumkin.
Misol: “Ali”, “25”, “500 000 so‘m” — bu oddiy ma’lumotlar.

2) Ma’lumotlar bazasi — bu ma’lumotlarni tartibli tarzda saqlash va ulardan samarali foydalanish imkonini beruvchi tizimdir. U elektron ko‘rinishda bo‘ladi.
Misol: Mijozlarning ism-familiyasi, telefon raqami va manzili saqlanadigan tizim.

3) Relatsion ma’lumotlar bazasi — bu ma’lumotlar jadval ko‘rinishida saqlanadigan tizim bo‘lib, jadvallar kalitlar (keys) orqali bir-biriga bog‘lanadi.
Misol: “Mijozlar”, “Buyurtmalar” va “Mahsulotlar” jadvallari o‘zaro bog‘langan holatda ishlatiladi.

4) Jadval — bu relatsion ma’lumotlar bazasida ma’lumotlarni satr (qator) va ustun (kolonka) shaklida saqlashga mo‘ljallangan tuzilma.

--List five key features of SQL Server.
1) sql server malumotlarni bazasi bilan ishlash uchun qulay.
2)sql serverda bir nechta user foydalansa bolad.
3) sql server katta kichik harflar rol oynamaydi
4) sql server Integratsiya va tahliliy vositalar
5) sql server  Kengaytirilgan xavfsizlik tizimi

--What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
1) Windows orqali autentifikatsiya
2) SQL Server orqali autentifikatsiya

--Create a new database in SSMS named SchoolDB.
CREATE database SchoolDB

--Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).
CREATE TABLE Students (StudentID INT PRIMARY KEY, Name VARCHAR(50), Age INT)

--Describe the differences between SQL Server, SSMS, and SQL.
1)SQL Server — bu Microsoft tomonidan yaratilgan ma’lumotlar bazasini boshqarish tizimi (DBMS).
2)SSMS — bu SQL Server bilan ishlash uchun mo‘ljallangan grafik dastur (foydalanuvchi interfeysi)

--Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
 1. DQL – Data Query Language

Ma’lumotlarni so‘rash tili
Bu bo‘limda ma’lumotlarni bazasidan izlab topish uchun ishlatiladigan buyruq mavjud.

 Asosiy buyruq:
SELECT – ma’lumotni tanlab olish
Misol:
SELECT * FROM Mijozlar WHERE Yosh > 30;
30 yoshdan katta mijozlar haqida ma’lumot chiqaradi.
 2. DML – Data Manipulation Language

Ma’lumotlarni boshqarish tili
Bu toifada ma’lumotlar bilan ishlov berish (qo‘shish, o‘zgartirish, o‘chirish) buyruqlari mavjud.

 Asosiy buyruqlar:
INSERT – ma’lumot qo‘shish
UPDATE – ma’lumotni o‘zgartirish
DELETE – ma’lumotni o‘chirish
 Misollar:
INSERT INTO Mijozlar (Ism, Yosh) VALUES ('Ali', 25);
UPDATE Mijozlar SET Yosh = 26 WHERE Ism = 'Ali';
DELETE FROM Mijozlar WHERE Ism = 'Ali';
 3. DDL – Data Definition Language

Ma’lumotlar tuzilmasini aniqlovchi til
Bu buyruqlar jadval yoki obyekt yaratish, o‘zgartirish, o‘chirish uchun ishlatiladi.

 Asosiy buyruqlar:
CREATE – yangi jadval yoki obyekt yaratish
ALTER – mavjud jadvalni o‘zgartirish
DROP – obyektni (jadvalni) o‘chirish
Misollar:
CREATE TABLE Mijozlar (ID INT, Ism VARCHAR(50));
ALTER TABLE Mijozlar ADD Manzil VARCHAR(100);
DROP TABLE Mijozlar;
4. DCL – Data Control Language

Ma’lumotlarga ruxsat nazorati tili
Bu buyruqlar orqali foydalanuvchilarga ruxsat berish yoki olib tashlash mumkin.

 Asosiy buyruqlar:
GRANT – ruxsat berish
REVOKE – ruxsatni bekor qilish
 Misollar:
GRANT SELECT ON Mijozlar TO Foydalanuvchi1;
REVOKE SELECT ON Mijozlar FROM Foydalanuvchi1;
 5. TCL – Transaction Control Language

Tranzaktsiyalarni boshqarish tili
Bu buyruqlar ma’lumotlar bazasidagi o‘zgarishlarni saqlash yoki bekor qilish uchun ishlatiladi.

 Asosiy buyruqlar:
COMMIT – o‘zgarishlarni saqlash
ROLLBACK – o‘zgarishlarni bekor qilish
SAVEPOINT – oraliq saqlash nuqtasi yaratish
 Misollar:
BEGIN TRANSACTION;
UPDATE Hisoblar SET Balans = Balans - 100 WHERE ID = 1;
UPDATE Hisoblar SET Balans = Balans + 100 WHERE ID = 2;
COMMIT;
Agar xatolik yuz bersa:
ROLLBACK;
