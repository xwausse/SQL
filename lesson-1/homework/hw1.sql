Quyidagi tushunchalarni aniqlang: ma'lumotlar, ma'lumotlar bazasi, munosabatlar bazasi, va jadval.

Ma'lumotlar: Kompyuter tomonidan qayta ishlanadigan yoki saqlanadigan axborot. Bu matn, sonlar, rasmlar va boshqalar bo'lishi mumkin.

Ma'lumotlar bazasi: Elektron shaklda saqlanadigan ma'lumotlar to'plami. Misollar: SQL Server, MySQL va boshqalar.

Munosabatlar bazasi: Ma'lumotlarni jadvallarda oldindan belgilangan munosabatlar bilan saqlaydigan baza turi.

Jadval: Ma'lumotlar satrlar va ustunlar shaklida tartiblangan tuzilmadir. Har bir satr yozuv, har bir ustun maydon hisoblanadi.

SQL Serverning beshta asosiy funksiyalarini sanab bering:

Ma'lumotlarni shifrlash (xavfsizlik).

Yuqori uzluksizlik va avariya tiklash imkoniyati.

Ma'lumotlarni siqish (disk hajmini optimallashtirish).

SQL Server Agent yordamida vazifalarni avtomatlashtirish.

Murakkab ma'lumotlar tahlili va hisobotlar yaratish.

SQL Serverga ulanishda mavjud bo‘lgan autentifikatsiya rejimlari qanday? (Kamida 2 ta):

Windows autentifikatsiyasi

SQL Server autentifikatsiyasi

O‘rtacha

SSMS da SchoolDB nomli yangi ma'lumotlar bazasini yarating:

SSMS ni oching va SQL Server instance ga ulaning.

'Databases' ustida o'ng tugmani bosing > 'New Database'.

'SchoolDB' ni bazaning nomi sifatida kiriting va 'OK' tugmasini bosing.

Students nomli jadvalni yaratish uchun quyidagi ustunlar bilan SQL so‘rovini yozing va bajaring:

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);

SQL Server, SSMS va SQL o‘rtasidagi farqlarni tushuntiring:

SQL Server: Microsoft tomonidan ishlab chiqilgan munosabatlar bazasini boshqarish tizimi.

SSMS (SQL Server Management Studio): SQL Server bilan ishlash uchun grafik interfeys.

SQL: Munosabatlar bazasi bilan ishlash uchun mo'ljallangan so'rovlar tili.

Murakkab

SQL buyrug‘ining turli xil turlari haqida izlanish qiling va tushuntiring: DQL, DML, DDL, DCL, TCL (misollar bilan):

DQL (Data Query Language): Ma'lumotlarni so'rov qilish uchun ishlatiladi. Misol: SELECT * FROM Students;

DML (Data Manipulation Language): Ma'lumotlarni o'zgartirish uchun ishlatiladi. Misol: INSERT INTO Students (StudentID, Name, Age) VALUES (1, 'John', 20);

DDL (Data Definition Language): Ma'lumotlar bazasi tuzilmalarini yaratish yoki o'zgartirish uchun ishlatiladi. Misol: CREATE TABLE Courses (...);

DCL (Data Control Language): Ma'lumotlarga kirishni boshqarish uchun ishlatiladi. Misol: GRANT SELECT ON Students TO User1;

TCL (Transaction Control Language): Tranzaksiyalarni boshqarish uchun ishlatiladi. Misol: COMMIT;

Students jadvaliga uchta yozuv qo‘shish uchun SQL so‘rovini yozing:

INSERT INTO Students (StudentID, Name, Age) VALUES (1, 'John Doe', 20);
INSERT INTO Students (StudentID, Name, Age) VALUES (2, 'Jane Smith', 22);
INSERT INTO Students (StudentID, Name, Age) VALUES (3, 'Mike Johnson', 19);

AdventureWorksDW2022.bak faylini serveringizga tiklash bosqichlari:

Havoladan faylni yuklab oling.

SSMS ni oching va SQL Server instance ga ulaning.

'Databases' ustida o'ng tugmani bosing > 'Restore Database'.

'Device' ni tanlang va yuklab olingan .bak faylni tanlang.

Tiklash jarayonini tugating.


