-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 06, 2025 at 02:35 PM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cart`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
CREATE TABLE IF NOT EXISTS `cart_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`id`, `session_id`, `product_id`, `quantity`, `added_at`) VALUES
(16, 'b59ssj36k0hh21bk9b3keni44m', 1, 1, '2025-03-06 09:39:31');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_email` varchar(255) DEFAULT NULL,
  `customer_address` text NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `order_date` datetime NOT NULL,
  `status` varchar(50) DEFAULT 'pending',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `session_id`, `customer_name`, `customer_email`, `customer_address`, `payment_method`, `total_amount`, `order_date`, `status`) VALUES
(1, '7fv1gpufbc71kshcmjq26kpmah', 'ibrahem ', 'Ibrahemalsaleh525@gmail.com', 'cdngukj', 'debit_card', 120.00, '2025-03-06 16:25:52', 'pending'),
(2, '7fv1gpufbc71kshcmjq26kpmah', 'ibrahem ', 'Ibrahemalsaleh525@gmail.com', 'cdngukj', 'paypal', 275.00, '2025-03-06 16:27:13', 'pending'),
(3, '7fv1gpufbc71kshcmjq26kpmah', 'ibrahem ', 'Ibrahemalsaleh525@gmail.com', 'cdngukj', 'paypal', 360.00, '2025-03-06 16:42:23', 'pending'),
(4, '7fv1gpufbc71kshcmjq26kpmah', 'ibrahem ', 'Ibrahemalsaleh525@gmail.com', 'cdngukj', 'debit_card', 112.00, '2025-03-06 17:25:28', 'pending'),
(5, '7fv1gpufbc71kshcmjq26kpmah', 'ibrahem ', 'Ibrahemalsaleh525@gmail.com', 'DCWE', 'credit_card', 252.00, '2025-03-06 17:26:42', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE IF NOT EXISTS `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 1, 1, 120.00),
(2, 2, 4, 5, 55.00),
(3, 3, 1, 3, 120.00),
(4, 4, 11, 4, 28.00),
(5, 5, 6, 2, 126.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `image_url`) VALUES
(1, 'Handmade Leather Bag', 'Luxurious handmade leather bag with high quality.', 120.00, 'https://i.etsystatic.com/22964628/r/il/e3d818/2632644809/il_570xN.2632644809_pbh8.jpg'),
(2, 'Soft Wool Scarf', 'Warm and soft wool scarf, perfect for cold winter days.', 35.00, 'https://shopipersia.com/wp-content/uploads/2023/03/White-Dishdasha-Arab-Wear-For-Men-768x768.jpg'),
(3, 'Ceramic Coffee Mug', 'Elegant ceramic coffee mug with a unique design.', 15.50, 'https://m.media-amazon.com/images/I/51z0yJizU5L._SL500_.jpg'),
(4, 'Wooden Table Lamp', 'Table lamp made of natural wood with a modern design.', 55.00, 'https://www.relicmilitaria.com/wp-content/uploads/2020/01/dsc00475-1304x2048.jpg'),
(5, 'Embroidered Vest', 'A vest with traditional Jordanian embroidery, worn over a thobe or other clothing.', 42.00, 'https://gomagcdn.ro/domains2/evastore.ro/files/product/large/vesta-traditionala-copii-ioana-054634.jpg'),
(6, 'Handcrafted Embroidered Dress', 'A dress featuring decorative embroidery panels known as Tatreez', 126.00, 'https://i.etsystatic.com/25884206/c/1477/1172/0/393/il/ec9593/5212349050/il_680x540.5212349050_5570.jpg'),
(7, 'Silver Jewelry', 'Handcrafted silver necklaces, bracelets, and earrings with traditional designs.', 70.00, 'https://th.bing.com/th/id/R.0334edc5ad34bc873746ec2b317b5ab9?rik=nnTguFXNWu4YnA&pid=ImgRaw&r=0'),
(8, 'Beaded Bracelets', 'Colorful bracelets made with beads and traditional patterns', 14.00, 'https://i.etsystatic.com/7212853/r/il/9ffc57/3006339332/il_1588xN.3006339332_70vx.jpg'),
(9, 'Leather Sandals', 'Handmade leather sandals with traditional designs', 35.00, 'https://th.bing.com/th/id/OIP.RfqPQAiBTssEKSPaC63UZgHaHa?rs=1&pid=ImgDetMain'),
(10, 'Embroidered Handbags', 'Handbags with traditional Jordanian embroidery and patterns', 49.00, 'https://th.bing.com/th/id/OIP.gCtT2tEFqgPF07gfGIuk1wHaLH?rs=1&pid=ImgDetMain'),
(11, 'Copper Coffee Pots', 'Traditional copper pots used for making Arabic coffee', 28.00, 'https://a.1stdibscdn.com/middle-eastern-dallah-arabic-copper-coffee-pot-for-sale/1121189/f_112644511530691529574/11264451_master.jpg'),
(12, 'Handcrafted Keychains', 'Keychains with traditional Jordanian symbols and designs', 7.00, 'https://thumbs.dreamstime.com/b/baguio-city-philippines-december-baguio-city-public-market-main-local-market-philippines-baguio-city-public-market-main-local-157178219.jpg'),
(13, 'Dead Sea Mud Mask', 'A facial mask made from Dead Sea mud, known for its therapeutic properties.', 21.00, 'https://m.media-amazon.com/images/I/71XrQwT4AKL.jpg'),
(14, 'Dead Sea Salt Scrub', 'A body scrub made with Dead Sea salts to exfoliate and rejuvenate the skin.', 17.50, 'https://m.media-amazon.com/images/I/71x-OOFR42L.jpg'),
(15, 'Olive Oil Soap', 'Natural soap made with olive oil, known for its moisturizing', 7.00, 'https://th.bing.com/th/id/R.edfd03b0a246b98f1bbc987b5e707d89?rik=VBHGHkaI0DJYJA&pid=ImgRaw&r=0'),
(16, 'Mineral Face Cream', 'A face cream enriched with minerals from the Dead Sea', 24.50, 'https://th.bing.com/th/id/OIP.MntRJWczuiueBcIlswDSmAHaE1?rs=1&pid=ImgDetMain'),
(17, 'Herbal Body Lotion', 'A body lotion made with natural herbs and essential oils', 14.00, 'https://cdn.cliqueinc.com/posts/303022/best-natural-body-lotions-303022-1665692014755-main.1200x0c.jpg?interlace=true&quality=70\r\n '),
(18, 'Rose Water Toner', 'A toner made with rose water to refresh and hydrate the skin', 10.50, 'https://th.bing.com/th/id/R.2d1708565f2f0ae56cf0a67b5ea8aa2d?rik=l4zgYWD%2fxLNt8w&riu=http%3a%2f%2fwww.thenaturalwash.com%2fcdn%2fshop%2fproducts%2fproduct_ingredients_22.jpg%3fv%3d1677754317&ehk=p%2bl0BOYyX6maD299cZP4h1lqZWJruN9dvCOdfb1Vf78%3d&risl=&pid='),
(19, 'Kimono', ' A traditional Japanese garment, often made from silk or cotton, worn on formal occasions.\r\n', 120.00, 'https://i.pinimg.com/originals/be/77/9d/be779d880e37566cdb849ce9cc03146d.jpg'),
(20, 'Yukata (Summer Kimono)', ' A lighter, more casual version of the kimono, often worn in summer or at festivals.\r\n', 60.00, 'https://i.etsystatic.com/16977663/r/il/522b30/2214195685/il_fullxfull.2214195685_mzgr.jpg'),
(21, 'Obi (Kimono Belt)', ' A wide belt worn with the kimono to secure it in place, available in various colors and patterns.', 20.00, 'https://img0.etsystatic.com/000/0/5404298/il_fullxfull.340593558.jpg'),
(22, 'Hakama (Traditional Japanese Pants)', ' A traditional wide-legged garment, often worn by samurai.', 90.00, 'https://m.media-amazon.com/images/I/61eJHgkJ13L.jpg'),
(23, 'Tabi (Japanese Socks)', ' Traditional Japanese socks that separate the big toe, worn with sandals or as part of the kimono.', 8.00, 'https://cb-contents.s3-ap-northeast-1.amazonaws.com/articles/images/gyoda/story.jpg'),
(24, 'Zori (Wooden Sandals)', ' Traditional sandals worn with a kimono, usually made from wood or straw.', 30.00, 'https://www.wikihow.com/images/8/88/Make-a-Pair-of-Geta-(Wooden-Sandals)-Step-13.jpg'),
(25, 'Tea Cups', 'Traditional ceramic cups used for drinking green tea or other Japanese teas.', 12.00, 'https://i.etsystatic.com/19942793/r/il/d7ce26/2909001132/il_1140xN.2909001132_dgl2.jpg'),
(26, 'Sushi Plates', 'Small plates specifically designed for serving sushi, usually made from porcelain or ceramic.', 10.00, 'https://www.takaski.com/wp-content/uploads/2016/10/Wooden-Zen-Sushi-Plate2.jpg'),
(27, 'Chopsticks', 'Traditional Japanese utensils used for eating, available in different materials like wood, bamboo, or plastic.', 5.00, 'https://th.bing.com/th/id/OIP.0Wbqcdx7inuJxqbZlmSQxwHaEz?w=1400&h=907&rs=1&pid=ImgDetMain'),
(28, 'Ramen Bowls', 'Large bowls used to serve ramen, often made from ceramic or porcelain.', 15.00, 'https://m.media-amazon.com/images/I/81eUUYqqTIS.jpg'),
(29, 'Bento Box', 'A lunchbox used to store and carry a variety of foods, often with separate compartments.', 10.00, 'https://www.hitpromo.net/imageManager/show/75004_group.jpg'),
(30, 'Soy Sauce Dish', 'Small dishes specifically used for serving soy sauce, often found as part of a sushi set.', 4.00, 'https://www.nishikidori.com/5243-large_default/soy-sauce-dish.jpg'),
(31, 'Matcha Green Tea Powder', ' High-quality powdered green tea used in the traditional Japanese tea ceremony or for making beverages.', 15.00, 'https://media1.popsugar-assets.com/files/thumbor/fEIPzXMyHRwgR4SFDiwbzN6Bcqw/fit-in/1024x1024/filters:format_auto-!!-:strip_icc-!!-/2019/05/28/949/n/1922729/cb6fbfb85bd7961f_netimgg2xq4D/i/Organic-Matcha-Green-Tea-Powder.jpg'),
(32, 'Wasabi Paste', 'A pungent paste made from the wasabi root, typically served with sushi.', 5.00, 'https://th.bing.com/th/id/R.5c23e51366805ec8436bfd8f2763b748?rik=Rd8LLXho8%2bo3oA&riu=http%3a%2f%2fwww.iguaria.com%2fwp-content%2fuploads%2f2015%2f02%2fAsia-Green-Garden-Wasabi-Paste.jpg&ehk=aHwZ%2fi%2bfuXtW1Su58rOc0WTzVQibPrhNisra%2bQxnkPk%3d&risl=&pid=I'),
(33, 'Nori Seaweed Sheets', 'Thin sheets of dried seaweed used to wrap sushi or rice balls.', 3.00, 'https://m.media-amazon.com/images/I/91B8FWYbmfL.jpg'),
(34, 'Pocky Sticks', 'A popular Japanese snack consisting of biscuit sticks dipped in various flavored coatings.', 4.00, 'https://th.bing.com/th/id/OIP.5rm4vRr6U8Rowl5IFahksAHaFj?rs=1&pid=ImgDetMain'),
(35, 'Mochi (Rice Cake)', 'A chewy Japanese rice cake made from glutinous rice, often filled with sweet fillings like red bean paste.', 8.00, 'https://th.bing.com/th/id/R.ba3c8c52e4bce23a3e0d9dea3be1b4b9?rik=RpE1GZYiuoQTcw&riu=http%3a%2f%2fjapanese999.com%2fwp-content%2fuploads%2f2014%2f01%2fmochi-rice-cake.jpg&ehk=s1G4f8O%2fFs3CfivmMT6Qav1vLJP7c5kG7SnwQCoRiow%3d&risl=&pid=ImgRaw&r=0'),
(36, 'Kit-Kat (Japanese Flavors)', 'Japanese Kit-Kat bars with unique flavors like matcha, sweet potato, and red bean.', 6.00, 'https://www.tokyoweekender.com/wp-content/uploads/2022/10/shutterstock_1582403740.jpg'),
(37, 'Anime Action Figures', 'Collectible figures of characters from popular anime series, often highly detailed and painted.', 25.00, 'https://th.bing.com/th/id/OIP.8DHgwoZa0DlCjrEZ-NL4SAAAAA?rs=1&pid=ImgDetMain'),
(38, 'Manga Books', ' Japanese graphic novels, often serialized, containing different genres like shonen, shojo, and more.', 10.00, 'https://jw-webmagazine.com/wp-content/uploads/2020/05/Best-Manga-of-All-Time.jpg'),
(39, 'Anime Posters', 'High-quality posters of anime characters or scenes, perfect for decorating a room or office.', 8.00, 'https://i.pinimg.com/originals/f8/6c/c3/f86cc358c2f65afc5cc2472f9ec2bcc4.jpg'),
(40, 'Cosplay Costumes', 'Costumes designed to replicate anime or manga character outfits, used for cosplay events.', 50.00, 'https://th.bing.com/th/id/OIP.C9QRUxUH7HPzbFztr4-S6QHaHp?rs=1&pid=ImgDetMain'),
(41, 'Anime T-Shirts', ' T-shirts printed with anime character designs or logos.', 15.00, 'https://down-ph.img.susercontent.com/file/sg-11134201-23020-hy9k7sr1h2nv2b'),
(42, 'Manga Art Prints', 'Printed artwork featuring manga-style illustrations, often signed or limited edition.', 20.00, 'https://m.media-amazon.com/images/I/71kpSj5RU+L._AC_SL1100_.jpg'),
(43, 'Caftan', 'A long, loose-fitting dress with intricate embroidery and decorations, often worn by women on special occasions.', 126.00, 'https://www.moroccoworldnews.com/wp-content/uploads/2020/07/Caftans-Morocco%E2%80%99s-Treasured-Traditional-Garments-Hit-the-Global-Stage.jpg'),
(44, 'Djellaba', 'A long, loose robe worn by both men and women, made from cotton or wool.', 70.00, 'https://th.bing.com/th/id/OIP.cFhUpunaz2RZq28vbDR-6gAAAA?rs=1&pid=ImgDetMain'),
(45, 'Burnous', 'A long woolen cloak worn by men during winter', 105.00, 'https://www.chezpakane.com/images/Image/Burnous-de-Spahis-Marocain-Drap-ecarlate.jpg'),
(46, 'Chachia', 'A traditional Moroccan hat made of wool, available in various colors', 18.00, 'https://th.bing.com/th/id/R.6f0839e489eae27763b07ca6ddb10dda?rik=Nn58%2broARTVcFQ&pid=ImgRaw&r=0'),
(47, 'Babouche', 'Traditional soft leather slippers worn by both men and women', 35.00, 'https://th.bing.com/th/id/R.7165578e0564107de8cc13e253ca474e?rik=WkBNO0eu05ynxw&riu=http%3a%2f%2fwww.caftan-catalogue.com%2fwp-content%2fuploads%2f2016%2f01%2fbabouche-marocain-de-marrakech.jpg&ehk=vv227JvHKFtkETF%2fxaaMqrdIleJrHxAZlx4lXF4Cr9k%3d&risl=&pi'),
(48, 'Kandora', 'A simple and elegant long robe worn by men', 56.00, 'https://i.pinimg.com/736x/fc/02/8e/fc028e4e66699a9af685c60fa6a062e2.jpg'),
(49, 'Silver Jewelry', 'Handcrafted silver necklaces, bracelets, and earrings with traditional Moroccan designs.', 70.00, 'https://s-media-cache-ak0.pinimg.com/736x/96/b1/8f/96b18f1b930af232f94f42e0924386ab.jpg'),
(50, 'Beaded Bracelets', 'Colorful bracelets made with beads and traditional Moroccan patterns.', 14.00, 'https://i.pinimg.com/736x/2d/69/b8/2d69b815a64a4c19a5a043df8625f391--bellydance.jpg'),
(51, 'Leather Handbags\r\n\r\n', 'Handcrafted leather handbags with traditional embroidery and decorations.', 49.00, 'https://i.pinimg.com/originals/62/39/f7/6239f751b375c7191008ac38086028b6.jpg'),
(52, 'Copper Teapots', 'Traditional copper teapots used for brewing and serving Moroccan tea.', 40.00, 'https://thumbs.dreamstime.com/z/moroccan-teapot-copper-glasses-tray-tea-one-traditions-middle-east-north-africa-specially-morocco-79610135.jpg'),
(53, 'Souvenirs Keychains', 'Keychains with traditional Moroccan symbols and designs', 7.00, 'https://thumbs.dreamstime.com/b/souvenirs-marrakech-morocco-north-africa-137562708.jpg'),
(54, 'Hand Fans', 'Hand fans decorated with traditional Moroccan patterns', 14.00, 'https://th.bing.com/th/id/R.7f12ef12fc064014f0db1c01b4a2d3e4?rik=oJOxMhE3yctDog&pid=ImgRaw&r=0'),
(55, 'Argan Oil', 'Natural oil extracted from the argan tree, used for moisturizing and nourishing skin and hair.', 21.00, 'https://th.bing.com/th/id/R.7adcad23c3b200c7e4308fe0bd8b2fe7?rik=r2liXy34JM%2bMiw&pid=ImgRaw&r=0'),
(56, 'Rhassoul Clay', 'Natural clay used for cleansing and purifying skin and hair', 17.50, 'https://th.bing.com/th/id/OIP.7IoNFS02Ikd6t155_3qDLQHaHa?rs=1&pid=ImgDetMain'),
(57, 'Rose Water', 'Natural toner made from rose water used to refresh and hydrate the skin.', 10.50, 'https://shafeeca.com/wp-content/uploads/2020/12/rose-water-510x510.jpeg'),
(58, 'Beldi Soap', 'Traditional soap made from olive oil, used for exfoliating and softening the skin.', 10.00, 'https://th.bing.com/th/id/R.8f5eac748569fdd8615ea9f452f70de8?rik=hfH4ni8kus%2f5ww&pid=ImgRaw&r=0'),
(59, 'Kohl Cream', 'Cream containing natural extracts used for nourishing and beautifying the skin.', 24.50, 'https://macoiffeuseafro.com/blog/wp-content/uploads/2018/06/2347edf746cfacfbabece50bf4c4da69.jpg'),
(60, 'Amber Perfume', 'Natural perfume made from amber, used for fragrancing the body', 14.00, 'https://cdn2.jomashop.com/media/catalog/product/s/w/swiss-arabian-unisex-amber-01-edp-spray-169-oz-fragrances-6295124036781.jpg'),
(61, 'Traditional Italian Suit', 'Elegant suit made from high-quality fabrics, typically worn by men on formal occasions.', 210.00, 'https://i.pinimg.com/originals/be/f2/39/bef239f9cab86b7354f83ea676af9f7f.jpg'),
(62, 'Italian Dresses', 'Stylish and intricately designed dresses worn by women on special occasions.', 140.00, 'https://th.bing.com/th/id/OIP.kv_m6CH9Z_Rpiis3SWoa_QHaJ1?rs=1&pid=ImgDetMain'),
(63, 'Silk Scarves', 'Luxurious silk scarves featuring classic and contemporary designs', 49.00, 'https://cdn.shopify.com/s/files/1/0026/1124/9241/products/Oksana-Fine-Art-Design-Italian-silk-scarf-Lavender-Dream-side-90-cm_2000x.jpg?v=1613959970'),
(64, 'Berets', 'Elegant woolen hats often adorned with traditional designs', 28.00, 'https://th.bing.com/th/id/OIP.C0Uz8_1ZRx5DvX0kLsgg0gHaHS?rs=1&pid=ImgDetMain'),
(65, 'Italian Leather Shoes', 'Handcrafted shoes made from fine Italian leather, known for their high quality.', 98.00, 'https://th.bing.com/th/id/OIP.Y7UpJuTRIsGdKe6FHXo9YwHaE8?rs=1&pid=ImgDetMain'),
(66, 'Italian Winter Coats', 'Elegant winter coats made from luxurious fabrics like cashmere', 175.00, 'https://media.neimanmarcus.com/f_auto,q_auto/w_1200,h_1500/01/nm_4449684_100273_m'),
(67, 'Pasta', 'Various types of pasta made from durum wheat, available in different shapes and sizes.', 5.00, 'https://th.bing.com/th/id/OIP.ZzLmsM8tGLUPv8Yr6uPARgHaJl?rs=1&pid=ImgDetMain'),
(68, 'Virgin Olive Oil', 'Natural oil extracted from high-quality Italian olives, used in cooking and salads.', 21.00, 'https://m.media-amazon.com/images/I/71jIFAOBBRL._SL1000_.jpg'),
(69, 'Balsamic Vinegar', 'Vinegar made from Trebbiano grapes, used in salads and Italian dishes.', 14.00, 'https://i.pinimg.com/originals/8a/4a/b1/8a4ab11a59028ca7766808c6dd121ec4.jpg'),
(70, 'Parmigiano Reggiano Cheese', 'Hard Italian cheese made from cow\'s milk, often grated over dishes', 49.00, 'https://th.bing.com/th/id/OIP.D4JGvvCutPbKQtpgIQDn8AAAAA?rs=1&pid=ImgDetMain'),
(71, 'Espresso Coffee', 'Rich and aromatic coffee that is an essential part of Italian culture', 14.00, 'https://m.media-amazon.com/images/I/51LdiDlXKLL._SL1080_.jpg'),
(72, 'Italian Wine', 'Wine made from grapes grown in various Italian regions, known for its high quality.', 35.00, 'https://www.christies.com/img/LotImages/2017/CKS/2017_CKS_14895_0200_000(mixed_italian_red_wines_11_bottles_per_lot031200).jpg?mode=max'),
(73, 'Handcrafted Furniture', 'Furniture pieces made by hand, featuring traditional and contemporary Italian designs.', 39.00, 'https://th.bing.com/th/id/R.594dc2ac11a5ab14a3926c0142f38e75?rik=2hGn0d8%2fM96LfQ&pid=ImgRaw&r=0'),
(74, 'Italian Pottery', 'Handmade pottery with traditional designs and vibrant colors', 30.00, 'https://th.bing.com/th/id/R.24b04c14966042f898484801ec0f8f7b?rik=%2bRRbLukDwMdWRw&riu=http%3a%2f%2fitalymagazine.com%2fsites%2fdefault%2ffiles%2ffeature-story%2fgallery%2fclassic_designs_from_deruta.jpg&ehk=cB9QBL7kkFxehSjTKDikrK6AA8qubYaRpqhNb1GYMm0%3d&r'),
(75, 'Murano Glass', 'Hand-blown glass from the island of Murano, known for its unique colors and shapes.', 140.00, 'https://as1.ftcdn.net/v2/jpg/03/34/85/50/1000_F_334855034_tu2tX9HfWq7xyNDSqDD9zsBPIWYJOcH7.jpg'),
(76, 'Italian Marble Tables', 'Elegant tables made from high-quality Italian marble', 350.00, 'https://i.pinimg.com/originals/ef/5d/97/ef5d97f3ad2bb7cf64cb1c599b53eed3.png'),
(77, 'Tuscan Leather Sofas', 'Luxurious sofas made from fine Tuscan leather', 700.00, 'https://th.bing.com/th/id/OIP.qWEJCGU9IRwMo5oCLW6unwHaEp?rs=1&pid=ImgDetMain'),
(78, 'Venetian Mirrors', 'Decorative mirrors with intricate Venetian designs', 280.00, 'https://a.1stdibscdn.com/archivesE/upload/8595/03_15/14e36antiquevenetianglassmirro1/14E36antiquevenetianglassmirrorc_l.jpeg'),
(79, 'Thobe', 'An embroidered dress with intricate designs, especially in red and black. ', 50.00, 'https://th.bing.com/th/id/OIP.RcdoWaUNXCTTJemLNDNKBgHaMy?rs=1&pid=ImgDetMain'),
(80, 'Keffiyeh', 'The famous black-and-white checkered scarf, symbolizing Palestinian heritage.', 5.00, 'https://th.bing.com/th/id/OIP.cetml6ha-mrx4vFIpBQjlgAAAA?rs=1&pid=ImgDetMain'),
(81, 'Abaya', ' A long black robe, sometimes decorated with embroidery.', 65.00, 'https://th.bing.com/th/id/OIP.WiIy-DpzUz16HEjdRXFq2gHaI-?rs=1&pid=ImgDetMain'),
(84, 'Tarboush (Fez Hat)', 'A black or red cylindrical hat, historically worn by men.', 25.00, 'https://cdn.webshopapp.com/shops/29471/files/166365446/650x650x2/fez-hat-in-black-tarboush-fes-oriental-headgear-ca.jpg'),
(85, 'Palestinian Vest (Sidari)', 'A sleeveless vest often worn over a thobe.', 70.00, 'https://th.bing.com/th/id/OIP.z1Om_K9hg_NMMQzfdTH-0gHaLG?rs=1&pid=ImgDetMain'),
(86, 'Nabulsi Sandals', 'Handmade leather sandals known for their high quality and traditional, comfortable design', 33.00, 'https://http2.mlstatic.com/D_NQ_NP_862063-MLB52578762647_112022-O.webp'),
(87, 'Arabic Coffee (Qahwa)', 'Strong black coffee with cardamom', 7.00, 'https://th.bing.com/th/id/OIP.Mqj_vaaRDyDIKx-wWvwYDgHaHa?w=720&h=720&rs=1&pid=ImgDetMain'),
(88, 'Shay bil Maramiya (Sage Tea)', 'Black tea brewed with sage leaves', 6.00, 'https://th.bing.com/th/id/OIP.BC1FgQnvfqTmAkQgeI7J1QHaHa?rs=1&pid=ImgDetMain'),
(89, 'Qamar al-Din (Apricot Drink)', 'A traditional Ramadan drink made from dried apricot paste.', 5.00, 'https://i.etsystatic.com/31513351/r/il/16d39e/4734241113/il_1588xN.4734241113_lhw6.jpg'),
(90, 'Jallab', 'A sweet drink made from grape molasses, dates, and rose water.', 3.00, 'https://minbaladeh.world/storage/16172725640.jpg'),
(91, 'Mate ', 'A popular herbal drink consumed in Palestinian communities, often shared in social gatherings.', 5.50, 'https://th.bing.com/th/id/OIP.ZY9WOUT-8byS2Sa9c6OtFQHaLH?rs=1&pid=ImgDetMain'),
(92, 'Carob Juice (Kharoob) ', 'A refreshing, naturally sweet drink made from carob pods.', 4.00, 'https://img.freepik.com/premium-photo/photo-some-carob-juice-drink-elegantly-plated-table_847439-39120.jpg'),
(93, 'Hand-Carved Wooden Chairs', 'Chairs made from olive wood, often decorated with traditional carvings.', 35.00, 'https://th.bing.com/th/id/R.c6613dae6fb7a4b8499869822135ba06?rik=aJkLup8DomT5DA&riu=http%3a%2f%2fmedia-cache-ak0.pinimg.com%2f736x%2f48%2fae%2fe1%2f48aee1d65bceeedb82ef356a1daed446.jpg&ehk=euUDYl7LN65p8%2feErX140tDPX%2b9t7tFptyqcxeAUGLA%3d&risl=&pid=ImgRa'),
(94, 'Mosaic Coffee Table', 'Tables with intricate mosaic designs, reflecting Palestinian artistic heritage.', 130.00, 'https://wallsdesk.com/wp-content/uploads/2016/04/Mosaic-Coffee-Table-Special-Form.jpg'),
(95, 'Olive Wood Cabinets', 'Storage units crafted from olive wood, durable and beautifully finished.', 370.00, 'https://th.bing.com/th?id=OIF.QIJRDx1r0SJB%2fv%2fCmb7aKg&rs=1&pid=ImgDetMain'),
(96, 'Sadu-Woven Cushions', 'Handwoven cushions with vibrant Palestinian Bedouin patterns. ', 43.00, 'https://th.bing.com/th/id/R.e70635b7c3b2434e0adb9373819b5cca?rik=iHrZPwi4q6Q5Tg&pid=ImgRaw&r=0'),
(97, 'Hand-Painted Ceramic Plates', 'Decorative plates featuring Palestinian motifs, often used for display or dining.', 12.00, 'https://th.bing.com/th/id/OIP.L9S-VoPcx8mjXDj3BrnBywHaIm?rs=1&pid=ImgDetMain'),
(98, 'Low Seating Majlis Set', 'Traditional floor seating with cushions, ideal for social gatherings.', 270.00, 'https://th.bing.com/th/id/OIP.7wifytn4_fu4q-5-vc4aiQHaFj?rs=1&pid=ImgDetMain');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
