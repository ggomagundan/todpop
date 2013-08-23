-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2
-- http://www.phpmyadmin.net
--
-- 호스트: localhost
-- 처리한 시간: 13-08-23 09:55 
-- 서버 버전: 5.5.31
-- PHP 버전: 5.4.4-14+deb7u3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 데이터베이스: `app_salty`
--

-- --------------------------------------------------------

--
-- 테이블 구조 `WORDS`
--

CREATE TABLE IF NOT EXISTS `WORDS` (
  `no` int(11) NOT NULL AUTO_INCREMENT COMMENT '단어번호',
  `name` varchar(100) NOT NULL COMMENT '영어 단어',
  `mean` varchar(255) NOT NULL COMMENT '영어 단어 뜻',
  `example_en` text COMMENT '예시 영어',
  `example_ko` text COMMENT '예시 한글',
  `phonetics` varchar(100) DEFAULT NULL COMMENT '발음 기호',
  `picture` int(1) DEFAULT NULL COMMENT '단어 사진 유/무',
  `date` datetime DEFAULT NULL COMMENT '그림을 수장한 날짜',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='영어 단어' AUTO_INCREMENT=361 ;

--
-- 테이블의 덤프 데이터 `WORDS`
--

INSERT INTO `WORDS` (`no`, `name`, `mean`, `example_en`, `example_ko`, `phonetics`, `picture`, `date`) VALUES
(1, 'afraid', '두려워하다', '단어테스트1', NULL, '', 1, '2013-08-06 02:31:31'),
(2, 'afternoon', '오후', '단어테스트2', NULL, '', 0, '0000-00-00 00:00:00'),
(3, 'again', '다시', '단어테스트3', NULL, '', 0, '0000-00-00 00:00:00'),
(4, 'ago', '전에', '단어테스트4', NULL, '', 0, '0000-00-00 00:00:00'),
(5, 'air', '공기', '단어테스트5', NULL, '', 0, '0000-00-00 00:00:00'),
(6, 'all', '모두 모든', '단어테스트6', NULL, '', 0, '0000-00-00 00:00:00'),
(7, 'almost', '거의', '단어테스트7', NULL, '', 0, '0000-00-00 00:00:00'),
(8, 'already', '이미', '단어테스트8', NULL, '', 0, '0000-00-00 00:00:00'),
(9, 'also', '역시', '단어테스트9', NULL, '', 0, '0000-00-00 00:00:00'),
(10, 'always', '언제나', '단어테스트10', NULL, '', 0, '0000-00-00 00:00:00'),
(11, 'animal', '동물', '단어테스트11', NULL, '', 1, '2013-08-14 02:33:06'),
(12, 'another', '또다른', '단어테스트12', NULL, '', 0, '0000-00-00 00:00:00'),
(13, 'answer', '답변', '단어테스트13', NULL, '', 0, '0000-00-00 00:00:00'),
(14, 'any', '어떠한', '단어테스트14', NULL, '', 0, '0000-00-00 00:00:00'),
(15, 'apple', '사과', '단어테스트15', NULL, '', 1, '2013-07-30 11:41:02'),
(16, 'ask', '묻다 질문하다', '단어테스트16', NULL, '', 1, '2013-07-29 12:19:38'),
(17, 'aunt', '아주머니', '단어테스트17', NULL, '', 0, '0000-00-00 00:00:00'),
(18, 'away', '멀리', '단어테스트18', NULL, '', 0, '0000-00-00 00:00:00'),
(19, 'baby', '아기', '단어테스트19', NULL, '', 0, '0000-00-00 00:00:00'),
(20, 'back', '뒤 등', '단어테스트20', NULL, '', 0, '0000-00-00 00:00:00'),
(21, 'bad', '나쁜', '단어테스트21', NULL, '', 0, '0000-00-00 00:00:00'),
(22, 'bag', '가방', '단어테스트22', NULL, '', 1, '2013-07-29 13:09:37'),
(23, 'ball', '공기', '단어테스트23', NULL, '', 1, '2013-08-06 02:23:46'),
(24, 'baseball', '야구', '단어테스트24', NULL, '', 1, '2013-08-09 07:13:28'),
(25, 'basketball', '농구', '단어테스트25', NULL, '', 1, '2013-08-09 07:15:43'),
(26, 'be', '이다 있다', '단어테스트26', NULL, '', 0, '0000-00-00 00:00:00'),
(27, 'beautiful', '아름다운', '단어테스트27', NULL, '', 0, '0000-00-00 00:00:00'),
(28, 'become', '되다', '단어테스트28', NULL, '', 0, '0000-00-00 00:00:00'),
(29, 'bed', '침대', '단어테스트29', NULL, '', 1, '2013-08-14 02:39:05'),
(30, 'begin', '시작하다', '단어테스트30', NULL, '', 1, '2013-08-10 23:14:08'),
(31, 'believe', '믿다', '단어테스트31', NULL, '', 1, '2013-08-10 23:17:10'),
(32, 'big', '큰', '단어테스트32', NULL, '', 1, '2013-07-30 11:54:01'),
(33, 'bike', '자전거', '단어테스트33', NULL, '', 1, '2013-07-29 13:07:36'),
(34, 'bill', '영수증', '단어테스트34', NULL, '', 0, '0000-00-00 00:00:00'),
(35, 'bird', '새', '단어테스트35', NULL, '', 1, '2013-07-30 11:37:54'),
(36, 'birthday', '생일', '단어테스트36', NULL, '', 1, '2013-07-29 13:06:30'),
(37, 'body', '몸', '단어테스트37', NULL, '', 0, '0000-00-00 00:00:00'),
(38, 'book', '책', '단어테스트38', NULL, '', 0, '0000-00-00 00:00:00'),
(39, 'both', '둘다', '단어테스트39', NULL, '', 0, '0000-00-00 00:00:00'),
(40, 'boy', '소년', '단어테스트40', NULL, '', 1, '2013-08-09 07:53:32'),
(41, 'breakfast', '아침식사', '단어테스트41', NULL, '', 1, '2013-07-29 11:23:12'),
(42, 'brother', '남자형제', '단어테스트42', NULL, '', 1, '2013-07-29 11:30:31'),
(43, 'brown', '갈색', '단어테스트43', NULL, '', 0, '0000-00-00 00:00:00'),
(44, 'building', '건물', '단어테스트44', NULL, '', 1, '2013-07-29 11:01:02'),
(45, 'bus', '버스', '단어테스트45', NULL, '', 1, '2013-08-09 07:11:19'),
(46, 'busy', '바쁜', '단어테스트46', NULL, '', 0, '0000-00-00 00:00:00'),
(47, 'buy', '사다 구입하다', '단어테스트47', NULL, '', 0, '0000-00-00 00:00:00'),
(48, 'cake', '케익', '단어테스트48', NULL, '', 1, '2013-08-09 06:02:36'),
(49, 'call', '부르다 전화하다', '단어테스트49', NULL, '', 0, '0000-00-00 00:00:00'),
(50, 'can', '할수있다', '단어테스트50', NULL, '', 0, '0000-00-00 00:00:00'),
(51, 'car', '자동차', '단어테스트51', NULL, '', 1, '2013-08-09 07:27:40'),
(52, 'care', '돌보다 신경쓰다', '단어테스트52', NULL, '', 0, '0000-00-00 00:00:00'),
(53, 'certainly', '확실히', '단어테스트53', NULL, '', 0, '0000-00-00 00:00:00'),
(54, 'change', '바꾸다', '단어테스트54', NULL, '', 0, '0000-00-00 00:00:00'),
(55, 'child', '어린이', '단어테스트55', NULL, '', 1, '2013-07-30 11:41:17'),
(56, 'city', '도시', '단어테스트56', NULL, '', 1, '2013-07-29 11:00:34'),
(57, 'class', '급 학급', '단어테스트57', NULL, '', 1, '2013-07-29 10:56:37'),
(58, 'clean', '깨끗한', '단어테스트58', NULL, '', 0, '0000-00-00 00:00:00'),
(59, 'clock', '시계', '단어테스트59', NULL, '', 1, '2013-07-29 11:22:45'),
(60, 'clothes', '옷', '단어테스트60', NULL, '', 1, '2013-08-05 01:12:58'),
(61, 'club', '동아리 클럽', '단어테스트61', NULL, '', 0, '0000-00-00 00:00:00'),
(62, 'cold', '차가운', '단어테스트62', NULL, '', 0, '0000-00-00 00:00:00'),
(63, 'come', '오다', '단어테스트63', NULL, '', 0, '0000-00-00 00:00:00'),
(64, 'computer', '컴퓨터', '단어테스트64', NULL, '', 1, '2013-07-30 11:33:28'),
(65, 'country', '나라 시골', '단어테스트65', NULL, '', 1, '2013-08-09 06:22:28'),
(66, 'course', '경로 코스', '단어테스트66', NULL, '', 1, '2013-08-11 13:04:28'),
(67, 'daughter', '딸', '단어테스트67', NULL, '', 1, '2013-08-09 06:14:54'),
(68, 'day', '날', '단어테스트68', NULL, '', 0, '0000-00-00 00:00:00'),
(69, 'dear', '친애하는', '단어테스트69', NULL, '', 0, '0000-00-00 00:00:00'),
(70, 'desk', '책상', '단어테스트70', NULL, '', 1, '2013-07-29 10:51:35'),
(71, 'dialog', '대화', '단어테스트71', NULL, '', 1, '2013-07-29 12:39:18'),
(72, 'diary', '일기장', '단어테스트72', NULL, '', 1, '2013-07-29 11:12:58'),
(73, 'different', '다른', '단어테스트73', NULL, '', 0, '0000-00-00 00:00:00'),
(74, 'dinner', '저녁식사', '단어테스트74', NULL, '', 0, '0000-00-00 00:00:00'),
(75, 'do', '하다', '단어테스트75', NULL, '', 0, '0000-00-00 00:00:00'),
(76, 'doctor', '의사', '단어테스트76', NULL, '', 0, '0000-00-00 00:00:00'),
(77, 'dog', '개', '단어테스트77', NULL, '', 1, '2013-08-09 07:23:30'),
(78, 'donkey', '당나귀', '단어테스트78', NULL, '', 1, '2013-07-29 12:12:45'),
(79, 'door', '문', '단어테스트79', NULL, '', 1, '2013-07-29 12:25:02'),
(80, 'down', '아래로', '단어테스트80', NULL, '', 0, '0000-00-00 00:00:00'),
(81, 'dream', '꿈', '단어테스트81', NULL, '', 0, '0000-00-00 00:00:00'),
(82, 'dress', '옷 옷을입다', '단어테스트82', NULL, '', 1, '2013-08-11 13:16:47'),
(83, 'driver', '운전사', '단어테스트83', NULL, '', 1, '2013-08-06 02:23:20'),
(84, 'each', '각각의', '단어테스트84', NULL, '', 0, '0000-00-00 00:00:00'),
(85, 'early', '이른', '단어테스트85', NULL, '', 1, '2013-08-09 07:17:06'),
(86, 'earth', '지구', '단어테스트86', NULL, '', 1, '2013-07-29 12:23:41'),
(87, 'easy', '쉬운', '단어테스트87', NULL, '', 1, '2013-07-29 12:26:47'),
(88, 'eat', '먹다', '단어테스트88', NULL, '', 0, '0000-00-00 00:00:00'),
(89, 'end', '끝 끝나다', '단어테스트89', NULL, '', 0, '0000-00-00 00:00:00'),
(90, 'enough', '충분한', '단어테스트90', NULL, '', 0, '0000-00-00 00:00:00'),
(91, 'evening', '저녁', '단어테스트91', NULL, '', 1, '2013-07-30 05:17:27'),
(92, 'every', '모든', '단어테스트92', NULL, '', 0, '0000-00-00 00:00:00'),
(93, 'everybody', '모든사람', '단어테스트93', NULL, '', 0, '0000-00-00 00:00:00'),
(94, 'example', '예시', '단어테스트94', NULL, '', 0, '0000-00-00 00:00:00'),
(95, 'excuse', '사과하다', '단어테스트95', NULL, '', 0, '0000-00-00 00:00:00'),
(96, 'eye', '눈', '단어테스트96', NULL, '', 1, '2013-07-29 10:56:02'),
(97, 'family', '가족', '단어테스트97', NULL, '', 1, '2013-07-29 11:30:08'),
(98, 'far', '먼', '단어테스트98', NULL, '', 0, '0000-00-00 00:00:00'),
(99, 'farmer', '농부', '단어테스트99', NULL, '', 1, '2013-07-29 10:50:02'),
(100, 'fast', '빠른', '단어테스트100', NULL, '', 0, '0000-00-00 00:00:00'),
(101, 'father', '아버지', '단어테스트101', NULL, '', 0, '0000-00-00 00:00:00'),
(102, 'feel', '느끼다 느낌', '단어테스트102', NULL, '', 0, '0000-00-00 00:00:00'),
(103, 'few', '거의없는', '단어테스트103', NULL, '', 0, '0000-00-00 00:00:00'),
(104, 'field', '들판 장 필드', '단어테스트104', NULL, '', 0, '0000-00-00 00:00:00'),
(105, 'find', '찾다', '단어테스트105', NULL, '', 0, '0000-00-00 00:00:00'),
(106, 'fine', '좋은 미세한', '단어테스트106', NULL, '', 0, '0000-00-00 00:00:00'),
(107, 'fire', '불', '단어테스트107', NULL, '', 1, '2013-07-29 11:29:45'),
(108, 'first', '첫번째', '단어테스트108', NULL, '', 0, '0000-00-00 00:00:00'),
(109, 'fish', '물고기', '단어테스트109', NULL, '', 1, '2013-08-09 07:49:30'),
(110, 'flower', '꽃', '단어테스트110', NULL, '', 1, '2013-08-09 07:30:51'),
(111, 'food', '음식', '단어테스트111', NULL, '', 1, '2013-08-09 07:11:58'),
(112, 'friend', '친구', '단어테스트112', NULL, '', 1, '2013-07-30 11:59:19'),
(113, 'front', '앞의', '단어테스트113', NULL, '', 0, '0000-00-00 00:00:00'),
(114, 'fun', '재미있는', '단어테스트114', NULL, '', 1, '2013-07-29 13:08:31'),
(115, 'futher', '먼', '단어테스트115', NULL, '', 0, '0000-00-00 00:00:00'),
(116, 'game', '경기', '단어테스트116', NULL, '', 1, '2013-07-29 12:30:42'),
(117, 'gesture', '제스쳐 몸동작', '단어테스트117', NULL, '', 1, '2013-07-29 11:23:45'),
(118, 'get', '얻다', '단어테스트118', NULL, '', 0, '0000-00-00 00:00:00'),
(119, 'girl', '소녀', '단어테스트119', NULL, '', 1, '2013-08-09 07:27:22'),
(120, 'give', '주다', '단어테스트120', NULL, '', 0, '0000-00-00 00:00:00'),
(121, 'glad', '기쁜', '단어테스트121', NULL, '', 0, '0000-00-00 00:00:00'),
(122, 'gold', '금', '단어테스트122', NULL, '', 1, '2013-07-29 11:26:46'),
(123, 'good', '좋은', '단어테스트123', NULL, '', 0, '0000-00-00 00:00:00'),
(124, 'grandfather', '할아버지', '단어테스트124', NULL, '', 0, '0000-00-00 00:00:00'),
(125, 'grandparent', '조부모', '단어테스트125', NULL, '', 1, '2013-07-29 12:40:45'),
(126, 'great', '훌륭한', '단어테스트126', NULL, '', 0, '0000-00-00 00:00:00'),
(127, 'hand', '손', '단어테스트127', NULL, '', 1, '2013-07-29 11:13:22'),
(128, 'happy', '행복한', '단어테스트128', NULL, '', 1, '2013-08-06 02:24:24'),
(129, 'hard', '어려운', '단어테스트129', NULL, '', 0, '0000-00-00 00:00:00'),
(130, 'have', '가지다', '단어테스트130', NULL, '', 0, '0000-00-00 00:00:00'),
(131, 'he', '그 그남자', '단어테스트131', NULL, '', 0, '0000-00-00 00:00:00'),
(132, 'health', '건강', '단어테스트132', NULL, '', 1, '2013-07-29 12:12:07'),
(133, 'hear', '듣다', '단어테스트133', NULL, '', 0, '0000-00-00 00:00:00'),
(134, 'help', '도와주다', '단어테스트134', NULL, '', 1, '2013-08-09 07:50:10'),
(135, 'here', '여기', '단어테스트135', NULL, '', 0, '0000-00-00 00:00:00'),
(136, 'high', '높은', '단어테스트136', NULL, '', 0, '0000-00-00 00:00:00'),
(137, 'history', '역사', '단어테스트137', NULL, '', 1, '2013-08-09 06:01:33'),
(138, 'hobby', '취미', '단어테스트138', NULL, '', 1, '2013-08-09 09:54:36'),
(139, 'home', '집 가정', '단어테스트139', NULL, '', 0, '0000-00-00 00:00:00'),
(140, 'hometown', '고향', '단어테스트140', NULL, '', 0, '0000-00-00 00:00:00'),
(141, 'homework', '숙제', '단어테스트141', NULL, '', 1, '2013-08-09 07:16:49'),
(142, 'hope', '희망하다 희망', '단어테스트142', NULL, '', 0, '0000-00-00 00:00:00'),
(143, 'hot', '뜨거운', '단어테스트143', NULL, '', 1, '2013-08-11 13:12:06'),
(144, 'hour', '시간', '단어테스트144', NULL, '', 1, '2013-08-09 05:43:32'),
(145, 'house', '집', '단어테스트145', NULL, '', 1, '2013-07-30 11:54:40'),
(146, 'however', '그러나', '단어테스트146', NULL, '', 0, '0000-00-00 00:00:00'),
(147, 'hurry', '서두르는', '단어테스트147', NULL, '', 0, '0000-00-00 00:00:00'),
(148, 'idea', '생각 아이디어', '단어테스트148', NULL, '', 0, '0000-00-00 00:00:00'),
(149, 'important', '중요한', '단어테스트149', NULL, '', 0, '0000-00-00 00:00:00'),
(150, 'interesting', '재미있는', '단어테스트150', NULL, '', 0, '0000-00-00 00:00:00'),
(151, 'it', '그것', '단어테스트151', NULL, '', 0, '0000-00-00 00:00:00'),
(152, 'job', '직업', '단어테스트152', NULL, '', 0, '0000-00-00 00:00:00'),
(153, 'just', '단지', '단어테스트153', NULL, '', 0, '0000-00-00 00:00:00'),
(154, 'keep', '유지하다', '단어테스트154', NULL, '', 0, '0000-00-00 00:00:00'),
(155, 'kind', '친절한 종류', '단어테스트155', NULL, '', 0, '0000-00-00 00:00:00'),
(156, 'king', '왕', '단어테스트156', NULL, '', 1, '2013-08-10 23:19:33'),
(157, 'know', '알다', '단어테스트157', NULL, '', 0, '0000-00-00 00:00:00'),
(158, 'land', '땅', '단어테스트158', NULL, '', 1, '2013-08-09 07:09:42'),
(159, 'language', '언어', '단어테스트159', NULL, '', 1, '2013-08-11 13:09:52'),
(160, 'large', '큰', '단어테스트160', NULL, '', 0, '0000-00-00 00:00:00'),
(161, 'last', '마지막 지속하다', '단어테스트161', NULL, '', 0, '0000-00-00 00:00:00'),
(162, 'late', '늦은', '단어테스트162', NULL, '', 0, '0000-00-00 00:00:00'),
(163, 'later', '나중에', '단어테스트163', NULL, '', 0, '0000-00-00 00:00:00'),
(164, 'leaf', '나뭇잎', '단어테스트164', NULL, '', 1, '2013-07-30 11:32:40'),
(165, 'learn', '배우다', '단어테스트165', NULL, '', 0, '0000-00-00 00:00:00'),
(166, 'lesson', '레슨', '단어테스트166', NULL, '', 1, '2013-08-09 07:12:51'),
(167, 'let', '시키다 하게하다', '단어테스트167', NULL, '', 0, '0000-00-00 00:00:00'),
(168, 'letter', '편지', '단어테스트168', NULL, '', 1, '2013-08-11 12:43:56'),
(169, 'life', '삶', '단어테스트169', NULL, '', 0, '0000-00-00 00:00:00'),
(170, 'light', '빛 가벼운', '단어테스트170', NULL, '', 1, '2013-07-30 12:01:02'),
(171, 'like', '좋아하다', '단어테스트171', NULL, '', 0, '0000-00-00 00:00:00'),
(172, 'line', '선', '단어테스트172', NULL, '', 1, '2013-07-29 11:19:29'),
(173, 'listen', '듣다 (귀기울여)', '단어테스트173', NULL, '', 1, '2013-08-10 23:33:36'),
(174, 'little', '작은', '단어테스트174', NULL, '', 1, '2013-07-29 10:54:50'),
(175, 'live', '살다 살아있는', '단어테스트175', NULL, '', 0, '0000-00-00 00:00:00'),
(176, 'long', '긴', '단어테스트176', NULL, '', 1, '2013-07-29 11:29:09'),
(177, 'look', '보다', '단어테스트177', NULL, '', 1, '2013-08-09 06:03:05'),
(178, 'lot', '많은', '단어테스트178', NULL, '', 0, '0000-00-00 00:00:00'),
(179, 'love', '사랑하다 사랑', '단어테스트179', NULL, '', 1, '2013-07-30 11:57:21'),
(180, 'lunch', '점심식사', '단어테스트180', NULL, '', 1, '2013-08-09 07:50:50'),
(181, 'make', '만들다', '단어테스트181', NULL, '', 0, '0000-00-00 00:00:00'),
(182, 'man', '남자 사람', '단어테스트182', NULL, '', 1, '2013-08-10 23:12:28'),
(183, 'manner', '매너 행동양식', '단어테스트183', NULL, '', 0, '0000-00-00 00:00:00'),
(184, 'many', '많은 (셀수있는)', '단어테스트184', NULL, '', 1, '2013-08-09 07:43:06'),
(185, 'matter', '문제', '단어테스트185', NULL, '', 0, '0000-00-00 00:00:00'),
(186, 'maybe', '어쩌면 아마', '단어테스트186', NULL, '', 0, '0000-00-00 00:00:00'),
(187, 'mean', '의미하다 평균의', '단어테스트187', NULL, '', 0, '0000-00-00 00:00:00'),
(188, 'meet', '만나다', '단어테스트188', NULL, '', 0, '0000-00-00 00:00:00'),
(189, 'middle', '가운데', '단어테스트189', NULL, '', 0, '0000-00-00 00:00:00'),
(190, 'mind', '마음 꺼리다', '단어테스트190', NULL, '', 0, '0000-00-00 00:00:00'),
(191, 'minute', '분 (시간)', '단어테스트191', NULL, '', 0, '0000-00-00 00:00:00'),
(192, 'miss', '그리워하다', '단어테스트192', NULL, '', 1, '2013-07-29 11:27:15'),
(193, 'money', '돈', '단어테스트193', NULL, '', 1, '2013-08-09 06:12:35'),
(194, 'month', '달 (날짜)', '단어테스트194', NULL, '', 1, '2013-08-09 05:36:59'),
(195, 'moon', '달 (하늘에 있는)', '단어테스트195', NULL, '', 1, '2013-07-30 11:57:51'),
(196, 'morning', '아침', '단어테스트196', NULL, '', 1, '2013-08-09 07:52:22'),
(197, 'mother', '어머니', '단어테스트197', NULL, '', 1, '2013-07-29 11:08:32'),
(198, 'mountain', '산', '단어테스트198', NULL, '', 0, '0000-00-00 00:00:00'),
(199, 'mouse', '쥐', '단어테스트199', NULL, '', 1, '2013-08-11 11:41:33'),
(200, 'movie', '영화', '단어테스트200', NULL, '', 1, '2013-08-10 23:16:22'),
(201, 'much', '많은 (셀수없는)', '단어테스트201', NULL, '', 0, '0000-00-00 00:00:00'),
(202, 'music', '음악', '단어테스트202', NULL, '', 1, '2013-08-10 23:13:42'),
(203, 'name', '이름', '단어테스트203', NULL, '', 1, '2013-08-14 02:33:44'),
(204, 'nature', '자연', '단어테스트204', NULL, '', 1, '2013-08-11 13:08:08'),
(205, 'never', '결코 아닌', '단어테스트205', NULL, '', 0, '0000-00-00 00:00:00'),
(206, 'new', '새로운', '단어테스트206', NULL, '', 0, '0000-00-00 00:00:00'),
(207, 'newspaper', '신문', '단어테스트207', NULL, '', 0, '0000-00-00 00:00:00'),
(208, 'next', '다음의 다음', '단어테스트208', NULL, '', 0, '0000-00-00 00:00:00'),
(209, 'nice', '좋은 훌륭한', '단어테스트209', NULL, '', 0, '0000-00-00 00:00:00'),
(210, 'night', '밤', '단어테스트210', NULL, '', 1, '2013-07-30 11:30:46'),
(211, 'north', '북쪽 북쪽의', '단어테스트211', NULL, '', 0, '0000-00-00 00:00:00'),
(212, 'now', '지금', '단어테스트212', NULL, '', 0, '0000-00-00 00:00:00'),
(213, 'number', '숫자', '단어테스트213', NULL, '', 0, '0000-00-00 00:00:00'),
(214, 'office', '사무실', '단어테스트214', NULL, '', 1, '2013-07-29 11:09:11'),
(215, 'often', '종종', '단어테스트215', NULL, '', 0, '0000-00-00 00:00:00'),
(216, 'old', '오래된', '단어테스트216', NULL, '', 1, '2013-08-11 12:03:51'),
(217, 'once', '한번', '단어테스트217', NULL, '', 0, '0000-00-00 00:00:00'),
(218, 'oneself', '자기자신', '단어테스트218', NULL, '', 0, '0000-00-00 00:00:00'),
(219, 'only', '단지 그것뿐인', '단어테스트219', NULL, '', 0, '0000-00-00 00:00:00'),
(220, 'other', '다른', '단어테스트220', NULL, '', 0, '0000-00-00 00:00:00'),
(221, 'outside', '바깥의', '단어테스트221', NULL, '', 0, '0000-00-00 00:00:00'),
(222, 'owl', '올빼미', '단어테스트222', NULL, '', 1, '2013-07-29 11:30:58'),
(223, 'paper', '종이', '단어테스트223', NULL, '', 1, '2013-07-29 12:35:29'),
(224, 'parent', '부모님', '단어테스트224', NULL, '', 0, '0000-00-00 00:00:00'),
(225, 'park', '공원 주차하다', '단어테스트225', NULL, '', 1, '2013-07-30 11:56:42'),
(226, 'part', '조각 부분', '단어테스트226', NULL, '', NULL, '0000-00-00 00:00:00'),
(227, 'party', '파티 일행 정당', '단어테스트227', NULL, '', 1, '2013-07-29 12:17:30'),
(228, 'pen', '펜', '단어테스트228', NULL, '', 1, '2013-08-05 01:12:33'),
(229, 'people', '사람들 민족', '단어테스트229', NULL, '', 1, '2013-08-09 07:10:46'),
(230, 'person', '사람', '단어테스트230', NULL, '', 0, '0000-00-00 00:00:00'),
(231, 'picture', '그림', '단어테스트231', NULL, '', 0, '0000-00-00 00:00:00'),
(232, 'place', '장소', '단어테스트232', NULL, '', 1, '2013-08-09 06:04:26'),
(233, 'plane', '평명', '단어테스트233', NULL, '', 1, '2013-07-29 11:11:45'),
(234, 'play', '놀다 운동하다', '단어테스트234', NULL, '', 1, '2013-07-29 10:55:35'),
(235, 'please', '기쁜 기쁘게하다 제발', '단어테스트235', NULL, '', 0, '0000-00-00 00:00:00'),
(236, 'policeman', '경찰관', '단어테스트236', NULL, '', 1, '2013-07-29 13:09:12'),
(237, 'pollution', '오염', '단어테스트237', NULL, '', 1, '2013-07-29 12:09:49'),
(238, 'present', '선물 오늘 현재', '단어테스트238', NULL, '', 0, '0000-00-00 00:00:00'),
(239, 'pretty', '귀여운 꽤', '단어테스트239', NULL, '', 1, '2013-08-09 05:57:02'),
(240, 'prince', '왕자', '단어테스트240', NULL, '', 1, '2013-08-09 06:10:36'),
(241, 'problem', '문제', '단어테스트241', NULL, '', 0, '0000-00-00 00:00:00'),
(242, 'question', '문제', '단어테스트242', NULL, '', 1, '2013-07-29 11:06:43'),
(243, 'quickly', '재빠르게', '단어테스트243', NULL, '', 0, '0000-00-00 00:00:00'),
(244, 'race', '경주 인종', '단어테스트244', NULL, '', 1, '2013-07-29 11:10:39'),
(245, 'rain', '비', '단어테스트245', NULL, '', 1, '2013-08-09 07:19:21'),
(246, 'read', '읽다', '단어테스트246', NULL, '', 1, '2013-08-10 23:21:04'),
(247, 'really', '정말로', '단어테스트247', NULL, '', 0, '0000-00-00 00:00:00'),
(248, 'refrigerator', '냉장고', '단어테스트248', NULL, '', 1, '2013-07-29 13:06:48'),
(249, 'remember', '기억하다', '단어테스트249', NULL, '', 0, '0000-00-00 00:00:00'),
(250, 'rice', '쌀', '단어테스트250', NULL, '', 1, '2013-08-11 13:11:36'),
(251, 'right', '오른쪽 올바른', '단어테스트251', NULL, '', 0, '0000-00-00 00:00:00'),
(252, 'river', '강', '단어테스트252', NULL, '', 1, '2013-07-29 13:20:26'),
(253, 'room', '방', '단어테스트253', NULL, '', 1, '2013-07-29 12:48:36'),
(254, 'rule', '규칙', '단어테스트254', NULL, '', 0, '0000-00-00 00:00:00'),
(255, 'sad', '슬픈', '단어테스트255', NULL, '', 1, '2013-08-09 07:15:19'),
(256, 'same', '같은', '단어테스트256', NULL, '', 0, '0000-00-00 00:00:00'),
(257, 'Saturday', '토요일', '단어테스트257', NULL, '', 0, '0000-00-00 00:00:00'),
(258, 'say', '말하다', '단어테스트258', NULL, '', 1, '2013-08-09 05:33:16'),
(259, 'school', '학교', '단어테스트259', NULL, '', 0, '0000-00-00 00:00:00'),
(260, 'science', '과학', '단어테스트260', NULL, '', 1, '2013-07-29 12:46:08'),
(261, 'sea', '바다', '단어테스트261', NULL, '', 1, '2013-07-29 11:21:08'),
(262, 'season', '계절 시즌', '단어테스트262', NULL, '', 1, '2013-07-29 12:43:08'),
(263, 'second', '두번째 초(시간)', '단어테스트263', NULL, '', 0, '0000-00-00 00:00:00'),
(264, 'see', '보다', '단어테스트264', NULL, '', 0, '0000-00-00 00:00:00'),
(265, 'September', '9월', '단어테스트265', NULL, '', 1, '2013-08-10 23:11:35'),
(266, 'she', '그녀', '단어테스트266', NULL, '', 1, '2013-08-10 23:32:04'),
(267, 'ship', '배', '단어테스트267', NULL, '', 1, '2013-08-09 07:14:21'),
(268, 'shoe', '신발', '단어테스트268', NULL, '', 1, '2013-08-09 06:15:22'),
(269, 'show', '보여주다 쇼', '단어테스트269', NULL, '', 0, '0000-00-00 00:00:00'),
(270, 'side', '옆', '단어테스트270', NULL, '', 0, '0000-00-00 00:00:00'),
(271, 'sign', '사인 부호', '단어테스트271', NULL, '', 0, '0000-00-00 00:00:00'),
(272, 'sing', '노래부르다', '단어테스트272', NULL, '', 1, '2013-08-10 23:38:23'),
(273, 'sister', '자매 여형제', '단어테스트273', NULL, '', 1, '2013-07-29 10:40:15'),
(274, 'sky', '하늘', '단어테스트274', NULL, '', 1, '2013-07-29 13:06:00'),
(275, 'small', '작은', '단어테스트275', NULL, '', 0, '0000-00-00 00:00:00'),
(276, 'snow', '눈(하늘에서 날리는)', '단어테스트276', NULL, '', 1, '2013-07-29 10:50:43'),
(277, 'soccer', '축구', '단어테스트277', NULL, '', 1, '2013-07-30 05:14:10'),
(278, 'some', '어느정도의', '단어테스트278', NULL, '', 0, '0000-00-00 00:00:00'),
(279, 'something', '어떤것', '단어테스트279', NULL, '', 0, '0000-00-00 00:00:00'),
(280, 'sometimes', '때때로', '단어테스트280', NULL, '', 0, '0000-00-00 00:00:00'),
(281, 'son', '아들', '단어테스트281', NULL, '', 0, '0000-00-00 00:00:00'),
(282, 'song', '노래', '단어테스트282', NULL, '', 1, '2013-07-30 11:35:56'),
(283, 'soon', '곧', '단어테스트283', NULL, '', 0, '0000-00-00 00:00:00'),
(284, 'sorry', '미안한', '단어테스트284', NULL, '', 0, '0000-00-00 00:00:00'),
(285, 'sound', '소리', '단어테스트285', NULL, '', 0, '0000-00-00 00:00:00'),
(286, 'south', '남쪽 남쪽의', '단어테스트286', NULL, '', 1, '2013-07-29 11:33:27'),
(287, 'space', '공간', '단어테스트287', NULL, '', 1, '2013-07-29 10:59:07'),
(288, 'speak', '말하다', '단어테스트288', NULL, '', 1, '2013-08-10 23:18:29'),
(289, 'sport', '운동', '단어테스트289', NULL, '', 0, '0000-00-00 00:00:00'),
(290, 'spring', '봄 스프링', '단어테스트290', NULL, '', 1, '2013-08-09 06:12:12'),
(291, 'still', '여전히', '단어테스트291', NULL, '', 0, '0000-00-00 00:00:00'),
(292, 'stone', '돌맹이', '단어테스트292', NULL, '', 0, '0000-00-00 00:00:00'),
(293, 'stop', '멈추다', '단어테스트293', NULL, '', 1, '2013-07-29 11:22:12'),
(294, 'store', '상점', '단어테스트294', NULL, '', 1, '2013-07-29 12:29:34'),
(295, 'street', '거리', '단어테스트295', NULL, '', 1, '2013-07-29 11:07:37'),
(296, 'student', '학생', '단어테스트296', NULL, '', 1, '2013-08-11 13:11:04'),
(297, 'subway', '지하철', '단어테스트297', NULL, '', 1, '2013-07-29 12:23:18'),
(298, 'such', '그런', '단어테스트298', NULL, '', 0, '0000-00-00 00:00:00'),
(299, 'summer', '여름', '단어테스트299', NULL, '', 1, '2013-08-09 07:48:40'),
(300, 'sun', '태양', '단어테스트300', NULL, '', 1, '2013-07-29 10:54:20'),
(301, 'Sunday', '일요일', '단어테스트301', NULL, '', 0, '0000-00-00 00:00:00'),
(302, 'sure', '확실한', '단어테스트302', NULL, '', 0, '0000-00-00 00:00:00'),
(303, 'table', '테이블 탁자', '단어테스트303', NULL, '', 0, '0000-00-00 00:00:00'),
(304, 'talk', '대화하다', '단어테스트304', NULL, '', 1, '2013-08-09 06:02:16'),
(305, 'tall', '키가큰', '단어테스트305', NULL, '', 1, '2013-07-29 11:16:49'),
(306, 'teacher', '선생님', '단어테스트306', NULL, '', 1, '2013-07-29 12:29:54'),
(307, 'team', '팀', '단어테스트307', NULL, '', 0, '0000-00-00 00:00:00'),
(308, 'tell', '말하다', '단어테스트308', NULL, '', 0, '0000-00-00 00:00:00'),
(309, 'tennis', '테니스', '단어테스트309', NULL, '', 1, '2013-07-29 12:52:53'),
(310, 'thank', '감사하다', '단어테스트310', NULL, '', 0, '0000-00-00 00:00:00'),
(311, 'that', '저것', '단어테스트311', NULL, '', 0, '0000-00-00 00:00:00'),
(312, 'there', '거기', '단어테스트312', NULL, '', 1, '2013-08-09 07:52:49'),
(313, 'they', '그들', '단어테스트313', NULL, '', 0, '0000-00-00 00:00:00'),
(314, 'think', '생각하다', '단어테스트314', NULL, '', 0, '0000-00-00 00:00:00'),
(315, 'this', '이것', '단어테스트315', NULL, '', 0, '0000-00-00 00:00:00'),
(316, 'time', '시간', '단어테스트316', NULL, '', 1, '2013-07-29 13:00:07'),
(317, 'tired', '지친', '단어테스트317', NULL, '', 1, '2013-07-29 12:50:08'),
(318, 'today', '오늘', '단어테스트318', NULL, '', 0, '0000-00-00 00:00:00'),
(319, 'together', '함께', '단어테스트319', NULL, '', 1, '2013-08-09 04:52:02'),
(320, 'tomorrow', '내일', '단어테스트320', NULL, '', 0, '0000-00-00 00:00:00'),
(321, 'too', '역시', '단어테스트321', NULL, '', 0, '0000-00-00 00:00:00'),
(322, 'tower', '타워', '단어테스트322', NULL, '', 1, '2013-07-29 12:26:24'),
(323, 'town', '마을', '단어테스트323', NULL, '', 1, '2013-08-10 23:09:35'),
(324, 'train', '기차', '단어테스트324', NULL, '', 1, '2013-07-29 11:07:07'),
(325, 'tree', '나무', '단어테스트325', NULL, '', 0, '0000-00-00 00:00:00'),
(326, 'trip', '여행', '단어테스트326', NULL, '', 1, '2013-08-09 07:32:02'),
(327, 'try', '시도하다', '단어테스트327', NULL, '', 1, '2013-08-09 07:43:55'),
(328, 'uncle', '삼촌', '단어테스트328', NULL, '', 1, '2013-07-29 11:16:24'),
(329, 'up', '위로', '단어테스트329', NULL, '', 0, '0000-00-00 00:00:00'),
(330, 'use', '사용하다', '단어테스트330', NULL, '', 0, '0000-00-00 00:00:00'),
(331, 'usually', '보통', '단어테스트331', NULL, '', 0, '0000-00-00 00:00:00'),
(332, 'vacation', '방학', '단어테스트332', NULL, '', 0, '0000-00-00 00:00:00'),
(333, 'very', '매우', '단어테스트333', NULL, '', 0, '0000-00-00 00:00:00'),
(334, 'village', '마을', '단어테스트334', NULL, '', 1, '2013-07-29 10:44:26'),
(335, 'walk', '걷다', '단어테스트335', NULL, '', 0, '0000-00-00 00:00:00'),
(336, 'want', '원하다', '단어테스트336', NULL, '', 0, '0000-00-00 00:00:00'),
(337, 'warm', '따뜻한', '단어테스트337', NULL, '', 0, '0000-00-00 00:00:00'),
(338, 'waste', '낭비하다', '단어테스트338', NULL, '', 1, '2013-08-09 06:25:03'),
(339, 'watch', '주시하다 시계', '단어테스트339', NULL, '', 1, '2013-07-30 11:34:46'),
(340, 'water', '물', '단어테스트340', NULL, '', 1, '2013-08-09 06:03:28'),
(341, 'way', '길', '단어테스트341', NULL, '', 1, '2013-08-10 23:32:50'),
(342, 'we', '우리', '단어테스트342', NULL, '', 1, '2013-07-29 10:47:11'),
(343, 'week', '주 (일주일)', '단어테스트343', NULL, '', 0, '0000-00-00 00:00:00'),
(344, 'welcome', '환영하다', '단어테스트344', NULL, '', 0, '0000-00-00 00:00:00'),
(345, 'well', '좋은', '단어테스트345', NULL, '', 0, '0000-00-00 00:00:00'),
(346, 'white', '하얀', '단어테스트346', NULL, '', 1, '2013-07-29 13:16:23'),
(347, 'wife', '아내', '단어테스트347', NULL, '', 0, '0000-00-00 00:00:00'),
(348, 'will', '할것이다', '단어테스트348', NULL, '', 1, '2013-08-09 06:16:08'),
(349, 'window', '창문', '단어테스트349', NULL, '', 1, '2013-07-29 11:12:22'),
(350, 'winter', '겨울', '단어테스트350', NULL, '', 1, '2013-08-05 01:13:32'),
(351, 'wish', '소망하다', '단어테스트351', NULL, '', 0, '0000-00-00 00:00:00'),
(352, 'woman', '여자', '단어테스트352', NULL, '', 1, '2013-08-10 23:14:45'),
(353, 'wonderful', '훌륭한', '단어테스트353', NULL, '', 1, '2013-08-09 07:30:33'),
(354, 'word', '단어', '단어테스트354', NULL, '', 1, '2013-08-11 13:14:00'),
(355, 'world', '세계 세상', '단어테스트355', NULL, '', 0, '0000-00-00 00:00:00'),
(356, 'write', '글을쓰다', '단어테스트356', NULL, '', 1, '2013-08-14 02:39:47'),
(357, 'year', '년(일년)', '단어테스트357', NULL, '', 0, '0000-00-00 00:00:00'),
(358, 'yesterday', '어제', '단어테스트358', NULL, '', 0, '0000-00-00 00:00:00'),
(359, 'you', '당신', '단어테스트359', NULL, '', 0, '0000-00-00 00:00:00'),
(360, 'young', '어린', '단어테스트360', NULL, '', 0, '0000-00-00 00:00:00');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
