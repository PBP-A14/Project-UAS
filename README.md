[![Staging](https://github.com/PBP-A14/elibrary/actions/workflows/staging.yml/badge.svg)](https://github.com/PBP-A14/elibrary/actions/workflows/staging.yml/badge.svg)
[![Pre-Release](https://github.com/PBP-A14/elibrary/actions/workflows/pre-release.yml/badge.svg)](https://github.com/PBP-A14/elibrary/actions/workflows/pre-release.yml/badge.svg)
[![Release](https://github.com/PBP-A14/elibrary/actions/workflows/release.yml/badge.svg)](https://github.com/PBP-A14/elibrary/actions/workflows/release.yml/badge.svg)
[![Build status](https://build.appcenter.ms/v0.1/apps/7260b95e-f6d9-46ac-9045-9efb3c159e08/branches/main/badge)](https://appcenter.ms)

# elibrary Project UAS

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

install.appcenter.ms/orgs/elibrary/apps/elibrary/distribution_groups/public

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
**Modul Profile : Fatih Raditya Pratama**
### 

a.) History Bacaan

b.) Progress Literasi
##
**Modul Authentication : Nibras Itqon Ihsani**
###
a.) Data Akun User dan Admin

b.) Login

c.) Register
##
**Modul Home : Nibras Itqon Ihsani**
###
a.) List Buku

b.) Search Bar
##
**Modul Admin : Mika Ahmad Al Husseini**
###
a.) Add Buku

b.) Menampilkan data user

c.) Menghapus akun user

d.) Modul Admin hanya dapat diakses oleh Admin
##
**Modul Literasi : Sarah Nazly Nuraya**
###
a.) Jumlah Buku yang dibaca

b.) Waktu Baca Perhari
##
**Modul Detail Buku : Aliyah Faza Qinthara**
###
a.) Views, Likes

b.) Review Buku

c.) Rating Buku

d.) Sinopsis Buku
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

Langkah-langkah yang dapat dilakukan untuk mengintegrasikan aplikasi flutter dengan aplikasi web :

1. Mengimplementasikan sebuah *wrapper class* dengan menggunakan library *http* dan *map* untuk mendukung penggunaan *cookie-based authentication* pada aplikasi.
2. Mengimplementasikan REST API pada Django (views.py) dengan menggunakan JsonResponse atau Django JSON Serializer.
3. Mengimplementasikan desain *front-end* untuk aplikasi berdasarkan desain *website* yang sudah ada sebelumnya.
4. Melakukan integrasi antara *front-end* dengan *back-end* dengan menggunakan konsep *asynchronous* HTTP.

</br>
</details>
