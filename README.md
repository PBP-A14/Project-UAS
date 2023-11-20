# elibrary

A new Flutter project.

TK PBP A-14 (E-Library) 
#
<details>
<Summary>Anggota Kelompok :</summary>
<br>

Aliyah Faza Qinthara - 2206024726  

Fatih Raditya Pratama - 2206083520

Mika Ahmad Al Husseini - 2206826476

Nibras Itqon Ihsani - 2206083350

Sarah Nazly Nuraya - 2206082581
</br>
</details>

#
<details>
<Summary>Link Deployment :</summary>
<br>

</br>
</details>

#
<details>
<Summary>Link Berita Acara :</summary>
<br>

https://docs.google.com/spreadsheets/d/1PBvFeQFRPb2Yx03UilZUCdc5kyhGaUSZKtycV1gVDAM/edit?usp=sharing

</br>
</details>

#
<details>
<Summary>Aplikasi dan manfaatnya</Summary>
<br>
Aplikasi E-Library merupakan aplikasi perpustakaan online yang dapat diakses oleh masyarakat dari mana saja. Aplikasi ini dapat memberikan pilihan bacaan kepada user dan juga memberikan rekomendasi buku yang paling populer untuk dibaca. Dengan memanfaatkan aplikasi ini, user dapat meningkatkan minat literasi dan juga dapat mengetahui progress dari literasi yang dimiliki dengan fitur track jumlah buku yang sudah dibaca dan waktu baca buku dalam 1 hari. 

Aplikasi ini juga dapat membantu user untuk mengetahui buku mana yang sekiranya cocok untuk dibaca dengan fitur review buku dan sinopsis, sehingga user akan mendapatkan gambaran dari bahasan buku yang ingin dibaca.
</br>
</details>

#
<details>
<Summary>Modules</summary>
<br>

**_Modul Aplikasi_**

##
**Modul Profile :**
### 

a.) History Bacaan

b.) Progress Literasi
##
**Modul Authentication :**
###
a.) Data Akun User dan Admin

b.) Login

c.) Register
##
**Modul Home :**
###
a.) List Buku

b.) Search Bar
##
**Modul Admin :**
###
a.) Add, Remove, dan Edit Buku

b.) Melihat Data dan Hapus Akun User

c.) Melihat Log

d.) Modul Admin hanya dapat diakses oleh Admin
##
**Modul Literasi :**
###
a.) Jumlah Buku yang dibaca

b.) Waktu Baca Perhari
##
**Modul Detail Buku :**
###
a.) Views, Likes

b.) Review Buku

c.) Add Bookmark (button-nya)

d.) Rating Buku

e.) Sinopsis Buku
</br>
</details>

#
<details>
<summary>Datasets</summary>

**Sumber Dataset :**

1.) https://www.kaggle.com/datasets?search=book (Kaggle)


</details>

#
<details>
<Summary>Role User</summary>
<br>


**User:**

User merupakan pengguna yang sudah melakukan registrasi dan login akun pada aplikasi ini. User memiliki akses penuh terhadap fitur-fitur berikut yang terdapat dalam aplikasi.

***Fitur User***

****Home Page****

List Buku

Jumlah Buku yang Sudah dibaca

Jumlah Waktu Membaca

Search User Lain

****Detail Buku Page****

Review Buku

Views, Like Buku, dan Add Comment

Rating Buku

Sinopsis Buku

Add Bookmark

****Profile Page****

Detail Akun

History Bacaan

Progress Literasi

****Library (Bookmark)****

Isinya adalah buku-buku yang telah ditambahkan oleh user ke dalam bookmark.
##
**Admin :**

Admin e-library memiliki akses untuk menambahkan buku pada sistem, menghapus buku, melakukan pengubahan terhadap detail buku, melihat list akun yang terdaftar dalam sistem, menghapus akun dari sistem, dan juga dapat melihat log.

##
**Guest :** 

Guest merupakan pengguna yang belum melakukan login. Guest hanya dapat mengakses beberapa fitur dalam sistem, yaitu:

***Register***

***Login***

***Home Page***

List Buku

Ketika guest ingin mengakses fitur lainnya, maka sistem akan meminta guest untuk melakukan register atau login terlebih dahulu.
##
</br>
</details>

#
<details>
<Summary>Alur Integrasi Aplikasi Web</summary>
<br>

<h2>Setup Authentication pada Django untuk FLutter</h2>

1. Membuat `django-app` bernama `authentication` pada project Django yang telah dibuat.
2. Menambahkan `authentication` ke `INSTALLED_APPS` pada *main project* `settings.py` di aplikasi Django.
3. Menjalankan perintah `pip install django-cors-headers` untuk melakukan install *library* yang dibutuhkan.
4. Menambahkan `corsheaders` ke `INSTALLED_APPS` pada *main project* `settings.py` di aplikai Django.
5. Menambahkan `corsheaders.middleware.CorsMiddleware` pada *main project* `settings.py` di aplikasi Django.
6. Menambahkan variabel berikut pada *main project* `settings.py` di aplikasi Django.
7. Membuat metode *view* untuk melakukan login pada `authentication/views.py`.
8. Membuat *file* `urls.py` pada folder `authentication` dan menambahkan URL untuk *routing* terhadap fungsi yang sudah dibuat dengan *endpoint* `login/`.
9. Menambahkan `path('auth/', include('authentication.urls')),` pada *file* `elibrary/urls.py`.

<h2>Integrasi Sistem Authentication pada Flutter</h2>

1. Install *package* dari pbp yang sudah tersedia
2. Melakukan modifikasi *root widget* untuk menyediakan `CookieRequest` dengan `Provider`.
3. Membuat kode dart untuk halaman login.

<h2>Integrasi Form Flutter dengan Django</h2>

1. Menambahkan fungsi *view* baru pada `main/views.py` di aplikasi Django.
2. Menambahkan *path* baru pada `main/urls.py`.
3. Pada flutter menghubungkan halaman form dengan `CookieRequest`.

</br>
</details>
