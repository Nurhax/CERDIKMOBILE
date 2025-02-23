-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 18, 2025 at 03:37 AM
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
(6, 2, 1, 'Infeksi Virus', '2 Buah', '2024-12-03', '2024-12-09', 0, 'Isoprinosine', 'Setelah Makan', 'Tablet', '1:00 AM'),
(17, 1, 2, 'buk', '2', '2025-01-02', '2025-01-02', 0, 'Esomeprazole', 'jbjbjbjbj', 'botol', '4:00 PM'),
(19, 5, 9, 'Pusing', '2', '2025-01-06', '2025-01-11', 0, 'Sakatonik', '13213', 'krim', '3:30 AM');

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
(1, 'SRIAR123', 'Sri Ardiyati Apriani', 'sriar123@yahoo.com', 'minimoys1823', '2738499'),
(2, 'Nurhaxkes', 'Muhammad Iqbal Nurhaq', 'iqbalnur2003@gmail.com', 'MenikoMyBeloved123', '2938475'),
(6, 'Alifkes', 'Alif Adani Rahmat', 'Alifadanir23@yahoo.com', 'Alif123#', '9230487'),
(7, 'GabrielleKes', 'Gabrielle AdSense Felime', 'GabsAds123@yahoo.com', 'GABSADS123#', '9283456'),
(8, 'Raruyo123A', 'Amira Parsa Nasution', 'Amiraprsa123@yahoo.com', 'Amira123', '2928122'),
(9, 'FarrelParrarelUniverse', 'TIDAK Tahu', 'Siapa@gmail.com', 'pengikutbunda', '1234567');

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
(3, 'Cetirizine', 'Tablet', 'Unknown Dosis', 'Gatal-Gatal', 'Mg', 'Cetirizine adalah obat untuk meredakan gejala akibat reaksi alergi, seperti mata berair, bersin-bersin, hidung meler, atau gatal di kulit, tenggorokan, maupun hidung. Obat ini tersedia dalam bentuk tablet, kaplet, kapsul, sirop, atau obat tetes oral (drop'),
(9, 'Sakatonik', 'Siirup', '5', 'Pusing', 'mg', 'ada');

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
(1, 'Nurhax', 'AkuSayangMeniko123#', 'iqbalnur2009@gmail.com', '12/12/2003', 'Muhammad Iqbal Nurhaq', 'L', 2),
(2, 'Raruyo', 'Raruyo123@', 'amira123@gmail.com', '12/12/2003', 'Amira Parsa Nasution', 'P', 2),
(3, 'alifadanizir', 'Alif123#!', 'alifadanir23@gmail.com', '12/23/2003', 'Alif Adani Rahmat', 'L', 2),
(4, 'GabAds', 'Gabrielle1294#', 'GabrielleAds123@yahoo.com', '12/12/2001', 'Gabrielle AdSense Felime', 'L', 2),
(5, 'Farrel', 'terserahaku', 'alexdong@gmail.com', '09/08/2005', 'TIDAK TAHU', 'L', NULL);

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
  MODIFY `IDJadwal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `nakes`
--
ALTER TABLE `nakes`
  MODIFY `idnakes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `obat`
--
ALTER TABLE `obat`
  MODIFY `idobat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `pasien`
--
ALTER TABLE `pasien`
  MODIFY `idpasien` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
