-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 07, 2025 at 04:55 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cerdik`
--

-- --------------------------------------------------------

--
-- Table structure for table `jadwal`
--

CREATE TABLE `jadwal` (
  `IDJadwal` int(11) NOT NULL,
  `IDPasien` int(11) NOT NULL,
  `IDObat` int(11) NOT NULL,
  `Gejala` varchar(255) NOT NULL,
  `Dosis` varchar(255) NOT NULL,
  `Start_Date` date NOT NULL,
  `End_Date` date NOT NULL,
  `IsConfirmedNakes` int(11) DEFAULT 0,
  `NamaObat` varchar(255) NOT NULL,
  `Deskripsi` text DEFAULT NULL,
  `JenisObat` varchar(255) DEFAULT NULL,
  `WaktuKonsumsi` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jadwal`
--

INSERT INTO `jadwal` (`IDJadwal`, `IDPasien`, `IDObat`, `Gejala`, `Dosis`, `Start_Date`, `End_Date`, `IsConfirmedNakes`, `NamaObat`, `Deskripsi`, `JenisObat`, `WaktuKonsumsi`) VALUES
(6, 2, 1, 'Infeksi Virus', '2 Buah', '2025-04-14', '2025-05-16', 0, 'Isoprinosine', 'Setelah Makan', 'Tablet', '1:00 AM'),
(7, 1, 2, 'Untuk Penyakit GERD', '1/2 Tablet', '2025-04-14', '2025-06-12', 0, 'Esomeprazole', 'Sebelum Makan', 'Tablet', '12:00 PM'),
(8, 1, 3, 'Gatal-gatal', '1 Tablet', '2025-04-14', '2025-12-02', 0, 'Cetirizine', 'Sebelum Makan', 'Tablet', '1:00 PM');

-- --------------------------------------------------------

--
-- Table structure for table `nakes`
--

CREATE TABLE `nakes` (
  `idnakes` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `namalengkap` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nomorSTR` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nakes`
--

INSERT INTO `nakes` (`idnakes`, `username`, `namalengkap`, `email`, `password`, `nomorSTR`) VALUES
(1, 'SRIAR123', 'Sri Ardiyati Apriani', 'sriar123@yahoo.com', '$2a$10$Tg5mRWjsMPpMS9IJCvsT2e5t69X9jJgVfLf1ub80fcq3taHlYglo2', '2738499'),
(2, 'Nurhaxkes', 'Muhammad Iqbal Nurhaq', 'iqbalnur2003@gmail.com', '$2a$10$CehJHVLgGFm8HzQcmI8a9etfBlY8t3a78kbvM8wLzCq9gjv5meWeW', '2938475'),
(6, 'Alifkes', 'Alif Adani Rahmat', 'Alifadanir23@yahoo.com', '$2a$10$6z9iUbSuKFB3aHr0KuK1EepgVYXtTOMwnj7DCAD0g4tTlUxjVV1Sq', '9230487'),
(7, 'GabrielleKes', 'Gabrielle AdSense Felime', 'GabsAds123@yahoo.com', '$2a$10$L4Vf2yS7pJeejgirFxYQa.up3.Vqv77chdM72Wx9ra3jRMi5qUoyK', '9283456'),
(8, 'Raruyo123A', 'Amira Parsa Nasution', 'Amiraprsa123@yahoo.com', '$2a$10$2sOl.EypcXii31H2nzqaau8S0t6L9c22vbu8E7fQGb0oLRxDtjtc2', '2928122');

-- --------------------------------------------------------

--
-- Table structure for table `obat`
--

CREATE TABLE `obat` (
  `idobat` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `jenis` varchar(255) NOT NULL,
  `dosisobat` varchar(255) NOT NULL,
  `GejalaObat` varchar(255) DEFAULT NULL,
  `ukuran` varchar(255) DEFAULT NULL,
  `deskripsi` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `obat`
--

INSERT INTO `obat` (`idobat`, `nama`, `jenis`, `dosisobat`, `GejalaObat`, `ukuran`, `deskripsi`) VALUES
(1, 'Isoprinosine', 'Syrup', '1 Sendok Makan', 'Infeksi Virus', 'Mg', 'Isoprinosine adalah obat dengan kandungan methisoprinol.'),
(2, 'Esomeprazole', 'Tablet', '1/2 Tablet', 'Untuk penyakit GERD', 'Mg', 'Esomeprazole adalah obat untuk mengatasi asam lambung berlebih, seperti pada kondisi gastroesophageal reflux disease (GERD) dan sindrom Zollinger-Ellison. '),
(3, 'Cetirizine', 'Tablet', '1 Tablet', 'Gatal-Gatal', 'Mg', 'Cetirizine adalah obat untuk meredakan gejala akibat reaksi alergi, seperti mata berair, bersin-bersin, hidung meler, atau gatal di kulit, tenggorokan, maupun hidung. Obat ini tersedia dalam bentuk tablet, kaplet, kapsul, sirop, atau obat tetes oral (drop');

-- --------------------------------------------------------

--
-- Table structure for table `pasien`
--

CREATE TABLE `pasien` (
  `idpasien` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `usia` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `idnakes` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pasien`
--

INSERT INTO `pasien` (`idpasien`, `username`, `password`, `email`, `usia`, `nama`, `gender`, `idnakes`) VALUES
(1, 'Nurhax', '$2a$10$tKbaQibGrYMRKVXSYNKNm.jyAk7UV2WUP.F/T8UgbNu.3ownOqLPu', 'iqbalnur2009@gmail.com', '12/12/2003', 'Muhammad Iqbal Nurhaq', 'L', 2),
(2, 'Raruyo', '$2a$10$lps54e9vXYk.xPgjBImQ0u2ySVQ7WrvFe0MkjQ7rHVKIy6gDyWISy', 'amira123@gmail.com', '12/12/2003', 'Amira Parsa Nasution', 'P', 2),
(3, 'alifadanizir', '$2a$10$QH8TPI8SrBzygERpl1E9cu/rUnYcGWWy57c/8mBJNCIl6vn0TvuWG', 'alifadanir23@gmail.com', '12/23/2003', 'Alif Adani Rahmat', 'L', 2),
(4, 'GabAds', '$2a$10$fVlyMwjn2lMOcPRFt/qrueinyF0ZcjVl/tYMZTixKWdxQC2lysViW', 'GabrielleAds123@yahoo.com', '12/12/2001', 'Gabrielle AdSense Felime', 'L', 2),
(5, 'Iqbales123', '$2a$10$VqRMFprHhgualad83uCRMegYXTdn4mNR.lPBaZN.64SmAsB79MJdO', 'Balelo@gmail.com', '12/12/2005', 'Muhammad Iqbals Nurhasq', 'P', NULL),
(13, 'nasyaiphone', '$2a$10$PyyvM/fCsUILcuc27brXheDS5AKnO76/T4IUqdw58mIAptDW4Zr0y', 'nasyamacbook@jarwo.com', '01-01-2000', 'zabrina', 'P', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD PRIMARY KEY (`IDJadwal`),
  ADD KEY `FK_PASIEN` (`IDPasien`),
  ADD KEY `FK_OBAT` (`IDObat`);

--
-- Indexes for table `nakes`
--
ALTER TABLE `nakes`
  ADD PRIMARY KEY (`idnakes`);

--
-- Indexes for table `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`idobat`);

--
-- Indexes for table `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`idpasien`),
  ADD KEY `fk_idnakes` (`idnakes`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `jadwal`
--
ALTER TABLE `jadwal`
  MODIFY `IDJadwal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `nakes`
--
ALTER TABLE `nakes`
  MODIFY `idnakes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `obat`
--
ALTER TABLE `obat`
  MODIFY `idobat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `pasien`
--
ALTER TABLE `pasien`
  MODIFY `idpasien` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD CONSTRAINT `FK_OBAT` FOREIGN KEY (`IDObat`) REFERENCES `obat` (`idobat`),
  ADD CONSTRAINT `FK_PASIEN` FOREIGN KEY (`IDPasien`) REFERENCES `pasien` (`idpasien`);

--
-- Constraints for table `pasien`
--
ALTER TABLE `pasien`
  ADD CONSTRAINT `fk_idnakes` FOREIGN KEY (`idnakes`) REFERENCES `nakes` (`idnakes`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
