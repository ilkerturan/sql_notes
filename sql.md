SQL (Structured Query Language), veritabanları üzerinde işlem yapmak için kullanılan bir dildir. SQL, temel olarak DDL (Data Definition Language), DML (Data Manipulation Language) ve DQL (Data Query Language) olarak üç ana kategoriye ayrılır. Bu kategoriler, veritabanı nesnelerinin tanımlanması, verilerin manipüle edilmesi ve sorgulanması gibi farklı işlemleri içerir. Aşağıda bu konular hakkında detaylı bir eğitim dokümanı bulabilirsiniz.

---

### 1. **DDL (Data Definition Language)**
DDL, veritabanı nesnelerinin (tablolar, indeksler, view'lar vb.) oluşturulması, değiştirilmesi ve silinmesi için kullanılan SQL komutlarını içerir.

#### Temel DDL Komutları:
- **CREATE**: Yeni bir veritabanı nesnesi oluşturur.
  ```sql
  CREATE TABLE Ogrenciler (
      OgrenciID INT PRIMARY KEY,
      Ad VARCHAR(50),
      Soyad VARCHAR(50),
      DogumTarihi DATE
  );
  ```

- **ALTER**: Varolan bir veritabanı nesnesinin yapısını değiştirir.
  ```sql
  ALTER TABLE Ogrenciler ADD Email VARCHAR(100);
  ```

- **DROP**: Bir veritabanı nesnesini siler.
  ```sql
  DROP TABLE Ogrenciler;
  ```

- **TRUNCATE**: Bir tablodaki tüm verileri siler, ancak tablo yapısını korur.
  ```sql
  TRUNCATE TABLE Ogrenciler;
  ```

---

### 2. **DML (Data Manipulation Language)**
DML, veritabanındaki verilerin eklenmesi, güncellenmesi ve silinmesi gibi işlemleri gerçekleştirmek için kullanılan SQL komutlarını içerir.

#### Temel DML Komutları:
- **INSERT**: Tabloya yeni veri ekler.
  ```sql
  INSERT INTO Ogrenciler (OgrenciID, Ad, Soyad, DogumTarihi)
  VALUES (1, 'Ahmet', 'Yılmaz', '2000-01-15');
  ```

- **UPDATE**: Tablodaki mevcut verileri günceller.
  ```sql
  UPDATE Ogrenciler
  SET Soyad = 'Kaya'
  WHERE OgrenciID = 1;
  ```

- **DELETE**: Tablodan veri siler.
  ```sql
  DELETE FROM Ogrenciler
  WHERE OgrenciID = 1;
  ```

---

### 3. **DQL (Data Query Language)**
DQL, veritabanındaki verileri sorgulamak için kullanılan SQL komutlarını içerir. Temel komutu `SELECT`'tir.

#### Temel DQL Komutları:
- **SELECT**: Veritabanından veri sorgular.
  ```sql
  SELECT * FROM Ogrenciler;
  ```

- **WHERE**: Belirli bir koşula göre veri filtreler.
  ```sql
  SELECT * FROM Ogrenciler WHERE DogumTarihi > '2000-01-01';
  ```

- **ORDER BY**: Sorgu sonuçlarını sıralar.
  ```sql
  SELECT * FROM Ogrenciler ORDER BY Soyad ASC;
  ```

- **GROUP BY**: Verileri gruplar.
  ```sql
  SELECT COUNT(*), DogumTarihi FROM Ogrenciler GROUP BY DogumTarihi;
  ```

- **JOIN**: İki veya daha fazla tabloyu birleştirir.
  ```sql
  SELECT Ogrenciler.Ad, Notlar.Not
  FROM Ogrenciler
  INNER JOIN Notlar ON Ogrenciler.OgrenciID = Notlar.OgrenciID;
  ```

---

### 4. **Örnek Senaryolar**
#### Senaryo 1: Tablo Oluşturma ve Veri Ekleme
```sql
CREATE TABLE Ogrenciler (
    OgrenciID INT PRIMARY KEY,
    Ad VARCHAR(50),
    Soyad VARCHAR(50),
    DogumTarihi DATE
);

INSERT INTO Ogrenciler (OgrenciID, Ad, Soyad, DogumTarihi)
VALUES (1, 'Ahmet', 'Yılmaz', '2000-01-15');
```

#### Senaryo 2: Veri Güncelleme ve Sorgulama
```sql
UPDATE Ogrenciler
SET Soyad = 'Kaya'
WHERE OgrenciID = 1;

SELECT * FROM Ogrenciler WHERE OgrenciID = 1;
```

#### Senaryo 3: Tablo Birleştirme
```sql
CREATE TABLE Notlar (
    NotID INT PRIMARY KEY,
    OgrenciID INT,
    Not INT
);

INSERT INTO Notlar (NotID, OgrenciID, Not)
VALUES (1, 1, 85);

SELECT Ogrenciler.Ad, Notlar.Not
FROM Ogrenciler
INNER JOIN Notlar ON Ogrenciler.OgrenciID = Notlar.OgrenciID;
```

---

### 5. **SQL Best Practices**
- **Tablo İsimlendirme**: Anlamlı ve tutarlı isimler kullanın.
- **Veri Tipleri**: Doğru veri tiplerini seçin (örneğin, tarih için `DATE`, metin için `VARCHAR`).
- **Primary Key**: Her tabloda bir birincil anahtar (Primary Key) tanımlayın.
- **Index Kullanımı**: Sık sorgulanan sütunlar için indeks oluşturun.
- **SQL Injection**: Kullanıcı girdilerini temizleyerek SQL Injection saldırılarından korunun.
