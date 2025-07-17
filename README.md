# flutter_km_test

Aplikasi Flutter sesuai technical test Suitmedia, terdiri dari 3 halaman utama.  
Dibangun dengan **Flutter v3.32+** dan state management **GetX**.

## Demo

Cek Demo Aplikasi [disini](https://drive.google.com/file/d/1Bhwl6fq6HQULDGRWfK6qo1q-o-W-gqsO/view?usp=sharing)

## Fitur Aplikasi

1. **Halaman Pertama**
    - Input nama dan kalimat untuk dicek palindrome.
    - Tombol **Check** untuk validasi palindrome (dialog notifikasi hasil).
    - Tombol **Next** untuk pindah ke halaman kedua.

2. **Halaman Kedua**
    - Menampilkan teks "Welcome".
    - Menampilkan nama (dari halaman pertama) dan nama user terpilih.
    - Tombol **Choose a User** untuk menuju halaman ketiga.

3. **Halaman Ketiga**
    - Menampilkan list user dari API [reqres.in](https://reqres.in/api/users).
    - Fitur **pagination** (load next page saat scroll ke bawah).
    - **Pull-to-refresh** & empty state jika data kosong.
    - Klik user akan kembali ke halaman kedua dan menampilkan nama user terpilih.

## Tech Stack

- **Flutter** >=3.32.0
- **GetX** (State Management)
- **Dio** (HTTP request)
- **Android** min SDK 21, target SDK 34
- **iOS** min iOS 15

## Instalasi

1. Clone repo:
    ```bash
    git clone https://github.com/adamilham-dev/flutter_km_test.git
    cd flutter_km_test
    ```
2. Install dependencies:
    ```bash
    flutter pub get
    ```
3. Jalankan aplikasi:
    ```bash
    flutter run
    ```

## Struktur Folder

