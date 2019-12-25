drop TABLE "MANF" CASCADE CONSTRAINTS;
drop TABLE "CUSTOMER" CASCADE CONSTRAINTS;
drop TABLE "EMPLOYEE" CASCADE CONSTRAINTS;
drop TABLE "CAR" CASCADE CONSTRAINTS;
drop TABLE "ORDERS" CASCADE CONSTRAINTS;
drop TABLE "PAYMENT" CASCADE CONSTRAINTS;
drop TABLE "LOAN" CASCADE CONSTRAINTS;
drop TABLE "PRODUCT" CASCADE CONSTRAINTS;
drop TABLE "ORDER_ITEMS" CASCADE CONSTRAINTS;
drop TABLE "BAD_ORDERS" CASCADE CONSTRAINTS;
drop TABLE "BILLS" CASCADE CONSTRAINTS;

CREATE TABLE manf
(  manfid NUMBER(4,0) NOT NULL,
   manfname VARCHAR2(20) NOT NULL,
   contactname VARCHAR2(20) NOT NULL,
   contacttitle VARCHAR2(20) NOT NULL,
   address VARCHAR2(45) NOT NULL,
   city VARCHAR2(15) NOT NULL,
   phone NUMBER(13,0) NOT NULL,
   CONSTRAINT manf_pk PRIMARY KEY(manfid) );

CREATE TABLE customer
(  customerid NUMBER(4,0) NOT NULL,
   companyname VARCHAR2(20) NOT NULL,
   contactname VARCHAR2(20) NOT NULL,
   contacttitle VARCHAR2(20) NOT NULL,
   address VARCHAR2(45) NOT NULL,
   city VARCHAR2(15) NOT NULL,
   phone NUMBER(13,0) NOT NULL,
   CONSTRAINT customer_pk PRIMARY KEY(customerid) );

CREATE TABLE employee
(  employeeid NUMBER(4,0) NOT NULL,
   firstname VARCHAR2(15) NOT NULL,
   lastname VARCHAR2(15) NOT NULL,
   hireddate DATE NOT NULL,
   occupation VARCHAR2(15) NOT NULL,
   monthlysalary NUMBER(4,0) NOT NULL,
   address VARCHAR2(45) NOT NULL,
   city VARCHAR2(15) NOT NULL,
   phone NUMBER(13,0) NOT NULL,
   CONSTRAINT employee_pk PRIMARY KEY(employeeid) );
   
CREATE TABLE car
(  carid NUMBER(2,0) NOT NULL,
   carbrand VARCHAR2(10) NOT NULL,
   carmodel VARCHAR2(15) NOT NULL,
   carweight NUMBER(4,0) NOT NULL,
   caryear NUMBER(4,0) NOT NULL,
   employeeid NUMBER(4,0) NOT NULL,
   CONSTRAINT car_pk PRIMARY KEY(carid),
   CONSTRAINT car_fk FOREIGN KEY(employeeid) REFERENCES employee(employeeid) ON DELETE CASCADE);
   
CREATE TABLE orders
(  orderid NUMBER(4,0) NOT NULL,
   orderdate DATE NOT NULL,
   requireddate DATE NOT NULL,
   shippeddate DATE NOT NULL,
   orderweight NUMBER(5,0),
   orderprice NUMBER(5,0),
   customerid NUMBER(4,0) NOT NULL,
   carid NUMBER(2,0),
   CONSTRAINT order_pk PRIMARY KEY(orderid),
   CONSTRAINT order_fk FOREIGN KEY(customerid) REFERENCES customer(customerid) ON DELETE CASCADE,
   CONSTRAINT order_fk2 FOREIGN KEY(carid) REFERENCES car(carid) ON DELETE CASCADE );

CREATE TABLE product
(  productid NUMBER(4,0) NOT NULL,
   productname VARCHAR2(30) NOT NULL,
   buyprice NUMBER(5,2) NOT NULL,
   saleprice NUMBER(5,2) NOT NULL,
   InStock NUMBER(6,0) NOT NULL,
   InOrder NUMBER(6,0) NOT NULL,
   weight NUMBER(3,2) NOT NULL,
   category VARCHAR2(20) NOT NULL,
   manfid NUMBER(4,0),
   CONSTRAINT product_pk PRIMARY KEY(productid),
   CONSTRAINT product_fk FOREIGN KEY (manfid) REFERENCES manf(manfid) ON DELETE CASCADE );
   
CREATE TABLE loan
(  loanid NUMBER(4,0) NOT NULL,
   orderid NUMBER(4,0) NOT NULL,
   customerid NUMBER(4,0) NOT NULL,
   amount NUMBER(5,0) NOT NULL,
   CONSTRAINT loan_pk PRIMARY KEY(loanid),
   CONSTRAINT loan_fk1 FOREIGN KEY(orderid) REFERENCES orders(orderid) ON DELETE CASCADE,
   CONSTRAINT loan_fk2 FOREIGN KEY(customerid) REFERENCES customer(customerid) ON DELETE CASCADE );
   
CREATE TABLE payment
(  paymentnumber NUMBER(4,0) NOT NULL,
   loanid NUMBER(4,0) NOT NULL,
   paymentdate DATE NOT NULL,
   paymentamount NUMBER(5,0) NOT NULL,
   CONSTRAINT payment_pk PRIMARY KEY(paymentnumber),
   CONSTRAINT payment_fk FOREIGN KEY(loanid) REFERENCES loan(loanid) ON DELETE CASCADE );

CREATE TABLE order_items
(  productid NUMBER(4,0) NOT NULL,
   orderid NUMBER(4,0) NOT NULL,
   quantity NUMBER(3,0) NOT NULL,
   totalprice NUMBER(6,2) NOT NULL,
   totalweight NUMBER(6,2) NOT NULL,
   CONSTRAINT order_items_fk1 FOREIGN KEY (productid) REFERENCES product(productid) ON DELETE CASCADE,
   CONSTRAINT order_items_fk2 FOREIGN KEY (orderid) REFERENCES orders(orderid) ON DELETE CASCADE );

CREATE TABLE bad_orders
(  orderid NUMBER(4,0) NOT NULL,
   manfid NUMBER(4,0) NOT NULL,
   amount NUMBER(5,0) NOT NULL,
   reshippeddate DATE NOT NULL,
   CONSTRAINT bad_orders_fk FOREIGN KEY(orderid) REFERENCES orders(orderid) ON DELETE CASCADE,
   CONSTRAINT bad_orders_fk2 FOREIGN KEY(manfid) REFERENCES manf(manfid) ON DELETE CASCADE );
   
CREATE TABLE bills
(  billid NUMBER(4,0) NOT NULL,
   paymentnumber NUMBER(4,0) NOT NULL,
   manfid NUMBER(4,0) NOT NULL,
   sum NUMBER(5,0) NOT NULL,
   CONSTRAINT bill_pk PRIMARY KEY (billid),
   CONSTRAINT bill_fk FOREIGN KEY(paymentnumber) REFERENCES payment(paymentnumber) ON DELETE CASCADE,
   CONSTRAINT bill_fk2 FOREIGN KEY(manfid) REFERENCES manf(manfid) ON DELETE CASCADE );

INSERT INTO manf VALUES (1, 'Coca Cola', 'Muhtar Kent', 'CEO', 'OSB Mah Dudullu - Ümraniye', 'İstanbul', '2165284000');
INSERT INTO manf VALUES (2, 'Pepsi', 'Esra İREN', 'Genel Müdür', 'Tekfen Tower Büyükdere Cad 4.Levent', 'İstanbul', '08502220737');
INSERT INTO manf VALUES (3, 'Uludağ', 'SALİH DAĞALTI', 'Bölge Müdürü', 'Yenice Sanayi Bölgesi Turgut Mah. İnegöl', 'Bursa', '02247381500');
INSERT INTO manf VALUES (4, 'RedBull', 'KANAT GÜREL', 'İçecek Müdürü', 'Saray mah. Anel İş Merkezi Ümraniye', 'İstanbul', '02166331600');
INSERT INTO manf VALUES (5, 'Efes Pilsen', 'Alpay Can', 'Bölge Müdürü', 'Fatih Sultan Mehmet Mah. Balkan Cad', 'İstanbul', '02165868000');
INSERT INTO manf VALUES (6, 'Tuborg', 'Mehmet Sever', 'Fabrika Müdürü', 'Kemalpaşa Cad. No: 258/9 35070', 'İzmir', '02854848400');
INSERT INTO manf VALUES (7, 'Lipton', 'Cansu Deniz', 'Pazarlama Müdürü', 'Saray Mahallesi Dr. Adnan Büyükdeniz Cad.', 'Antalya', '02166334500');
INSERT INTO manf VALUES (8, 'Yeni Rakı', 'Hayri Gül', 'Bölge Müdürü', 'Hürriyet Cad. No:211 Bolkan Center B', 'İstanbul', '02123734400');
INSERT INTO manf VALUES (9, 'Cappy', 'Pınar Sevil', 'İçecek Müdürü', 'Mehmet Mah. Can Sok Şişli', 'İstanbul', '02166451600');
INSERT INTO manf VALUES (10, 'Dimes', 'Ekber Sevil', 'İçecek Müdürü', 'Emek Mah. Sıvat Cad. No:4 Sancaktepe', 'Ankara', '08004159007');

INSERT INTO product VALUES (1, 'Coca Cola 330 ml', 1.5, 2 , 1000 , 100 , 0.4 , 'Soda' , 1);
INSERT INTO product VALUES (2, 'Coca Cola 250 ml', 1, 1.50 , 1000 , 100 , 0.3 , 'Soda' , 1);
INSERT INTO product VALUES (3, 'Coca Cola 1 L', 2, 2.5 , 1000 , 100 , 1.2 , 'Soda' , 1);
INSERT INTO product VALUES (4, 'Coca Cola 2.5 L', 3, 3.5 , 1000 , 100 , 3 , 'Soda' , 1);
INSERT INTO product VALUES (5, 'Fanta 250 ml', 1, 1.5 , 1000 , 100 , 0.3 , 'Soda' , 1);
INSERT INTO product VALUES (6, 'Fanta 330 ml', 1.5, 2 , 1000 , 100 , 0.4 , 'Soda' , 1);
INSERT INTO product VALUES (7, 'Fanta 1 L', 2.5, 3 , 1000 , 100 , 1.2 , 'Soda' , 1);
INSERT INTO product VALUES (8, 'Fanta 2.5 L', 3, 3.5 , 1000 , 100 , 3 , 'Soda' , 1);
INSERT INTO product VALUES (9, 'Pepsi Cola 330 ml', 1.5, 2 , 1000 , 100 , 0.4 , 'Soda' , 2);
INSERT INTO product VALUES (10, 'Pepsi Cola 250 ml', 1, 1.50 , 1000 , 100 , 0.3 , 'Soda' , 2);
INSERT INTO product VALUES (11, 'Pepsi Cola 1 L', 2, 2.5 , 1000 , 100 , 1.2 , 'Soda' , 2);
INSERT INTO product VALUES (12, 'Pepsi Cola 2.5 L', 3, 3.5 , 1000 , 100 , 3 , 'Soda' , 2);
INSERT INTO product VALUES (13, 'Yedigün 250 ml', 1, 1.5 , 1000 , 100 , 0.3 , 'Soda' , 2);
INSERT INTO product VALUES (14, 'Yedigün 330 ml', 1.5, 2 , 1000 , 100 , 0.4 , 'Soda' , 2);
INSERT INTO product VALUES (15, 'Yedigün 1 L', 2.5, 3 , 1000 , 100 , 1.2 , 'Soda' , 2);
INSERT INTO product VALUES (16, 'Yedigün 2.5 L', 3, 3.5 , 1000 , 100 , 3 , 'Soda' , 2);
INSERT INTO product VALUES (17, 'Sade Maden Suyu 250 ml', 0.75, 1.25 , 1000 , 100 , 0.3 , 'Soda' , 3);
INSERT INTO product VALUES (18, 'Limonlu Maden Suyu 250 ml', 0.75, 1.25 , 1000 , 100 , 0.3 , 'Soda' , 3);
INSERT INTO product VALUES (19, 'Çilekli Maden Suyu 250 ml', 0.75, 1.25 , 1000 , 100 , 0.3 , 'Soda' , 3);
INSERT INTO product VALUES (20, 'Ananaslı Maden Suyu 250 ml', 0.75, 1.25 , 1000 , 100 , 0.3 , 'Soda' , 3);
INSERT INTO product VALUES (21, 'Limonata 1 L', 2, 2.5 , 1000 , 100 , 1.2 , 'Juice' , 3);
INSERT INTO product VALUES (22, 'RedBull Enerji 250 ml', 3, 4 , 1000 , 100 , 0.3 , 'Energy' , 4);
INSERT INTO product VALUES (23, 'RedBull Enerji 500 ml', 4, 5 , 1000 , 100 , 0.6 , 'Energy' , 4);
INSERT INTO product VALUES (24, 'Efes Pilsen 500 ml', 4, 5 , 1000 , 100 , 0.6 , 'Alcoholic' , 5);
INSERT INTO product VALUES (25, 'Efes Pilsen 330 ml', 3, 4 , 1000 , 100 , 0.4 , 'Alcoholic' , 5);
INSERT INTO product VALUES (26, 'Efes Extra Shot 250 ml', 2.5, 3.5 , 1000 , 100 , 0.3 , 'Alcoholic' , 5);
INSERT INTO product VALUES (27, 'Tuborg 500 ml', 4, 5 , 1000 , 100 , 0.6 , 'Alcoholic' , 6);
INSERT INTO product VALUES (28, 'Tuborg Amber 500 ml', 4, 5 , 1000 , 100 , 0.6 , 'Alcoholic' , 6);
INSERT INTO product VALUES (29, 'Tuborg 330 ml', 3, 4 , 1000 , 100 , 0.4 , 'Alcoholic' , 6);
INSERT INTO product VALUES (30, 'Tuborg 250 ml', 2.5, 3.5 , 1000 , 100 , 0.3 , 'Alcoholic' , 6);
INSERT INTO product VALUES (31, 'Ice Tea Limon 330 ml', 1.5, 2 , 1000 , 100 , 0.4 , 'Ice Tea' , 7);
INSERT INTO product VALUES (32, 'Ice Tea Mango 330 ml', 1.5, 2 , 1000 , 100 , 0.4 , 'Ice Tea' , 7);
INSERT INTO product VALUES (33, 'Ice Tea Şeftali 330 ml', 1.5, 2 , 1000 , 100 , 0.4 , 'Ice Tea' , 7);
INSERT INTO product VALUES (34, 'Ice Tea Karpuz 330 ml', 1.5, 2 , 1000 , 100 , 0.4 , 'Ice Tea' , 7);
INSERT INTO product VALUES (35, 'Yeni Rakı 35 cl', 35, 44 , 1000 , 100 , 0.5 , 'Alcoholic' , 8);
INSERT INTO product VALUES (36, 'Yeni Rakı 50 cl', 50, 58 , 1000 , 100 , 0.75 , 'Alcoholic' , 8);
INSERT INTO product VALUES (37, 'Yeni Rakı 70 cl', 75, 82.5 , 1000 , 100 , 0.9 , 'Alcoholic' , 8);
INSERT INTO product VALUES (38, 'Yeni Rakı 100 cl', 101, 110 , 1000 , 100 , 1.1 , 'Alcoholic' , 8);
INSERT INTO product VALUES (39, 'Cappy Kayısı 330 ml', 1.5, 2 , 1000 , 100 , 0.4 , 'Juice' , 9);
INSERT INTO product VALUES (40, 'Cappy Şeftali 330 ml', 1.5, 2 , 1000 , 100 , 0.4 , 'Juice' , 9);
INSERT INTO product VALUES (41, 'Cappy Karışık 330 ml', 1.5, 2 , 1000 , 100 , 0.4 , 'Juice' , 9);
INSERT INTO product VALUES (42, 'Cappy Kayısı 1 L', 2.5, 3 , 1000 , 100 , 1.2 , 'Juice' , 9);
INSERT INTO product VALUES (43, 'Cappy Şeftali 1 L', 2.5, 3 , 1000 , 100 , 1.2 , 'Juice' , 9);
INSERT INTO product VALUES (44, 'Cappy Şeftali 1 L', 2.5, 3 , 1000 , 100 , 1.2 , 'Juice' , 9);
INSERT INTO product VALUES (45, 'Dimes Kayısı 330 ml', 1.5, 2 , 1000 , 100 , 0.4 , 'Juice' , 10);
INSERT INTO product VALUES (46, 'Dimes Şeftali 330 ml', 1.5, 2 , 1000 , 100 , 0.4 , 'Juice' , 10);
INSERT INTO product VALUES (47, 'Dimes Karışık 330 ml', 1.5, 2 , 1000 , 100 , 0.4 , 'Juice' , 10);
INSERT INTO product VALUES (48, 'Dimes Kayısı 1 L', 2.5, 3 , 1000 , 100 , 1.2 , 'Juice' , 10);
INSERT INTO product VALUES (49, 'Dimes Şeftali 1 L', 2.5, 3 , 1000 , 100 , 1.2 , 'Juice' , 10);
INSERT INTO product VALUES (50, 'Dimes Şeftali 1 L', 2.5, 3 , 1000 , 100 , 1.2 , 'Juice' ,10);

INSERT INTO employee VALUES (1, 'Yağızcan', 'Sezgin', TO_DATE('22/April/2013','DD/MON/YY'), 'Manager', 5000, 'Gaziemir', 'İzmir', 5522416324);
INSERT INTO employee VALUES (2, 'Niyazi', 'Toker', TO_DATE('10/September/2013','DD/MON/YY'), 'CTO', 4000, 'F.Altay', 'İzmir', 5242416324);
INSERT INTO employee VALUES (3, 'Olgu', 'Erten', TO_DATE('20/November/2013','DD/MON/YY'), 'Cashier', 2500, 'Karşıyaka', 'İzmir', 5522456324);
INSERT INTO employee VALUES (4, 'Mansur', 'Turasan', TO_DATE('06/April/2013','DD/MON/YY'), 'Accountant', 2300, 'Karataş', 'İzmir', 5522485324);
INSERT INTO employee VALUES (5, 'Can', 'Yücel', TO_DATE('08/July/2014','DD/MON/YY'), 'Driver' , 2600, 'Datça', 'Muğla', 55224145324);
INSERT INTO employee VALUES (6, 'Özgün', 'Kınalı', TO_DATE('22/October/2014','DD/MON/YY'),'Loader', 2200, 'Mahmutlu', 'Tokat', 5522318524);
INSERT INTO employee VALUES (7, 'Erdem', 'Demir', TO_DATE('22/April/2015','DD/MON/YY'),'Loader', 2700, 'Kuşadası', 'Aydın', 5522414524);
INSERT INTO employee VALUES (8, 'Zübeyir', 'Ünlü', TO_DATE('22/May/2015','DD/MON/YY'),'Driver', 2200, 'Bağcılar', 'İstanbul', 5422416324);
INSERT INTO employee VALUES (9, 'Hasan', 'İnce', TO_DATE('23/April/2014','DD/MON/YY'),'Loader', 2500, 'Tatvan', 'Bitlis', 5552416324);
INSERT INTO employee VALUES (10, 'Berkay', 'Yılmaz', TO_DATE('12/April/2015','DD/MON/YY'), 'Driver', 1900, 'Bostanlı', 'İzmir', 5525416324);
INSERT INTO employee VALUES (11, 'Songül', 'Karlı', TO_DATE('11/April/2015','DD/MON/YY'), 'Cashier', 1800, 'Urla Toki', 'İzmir', 5522356324);
INSERT INTO employee VALUES (12, 'Doğan', 'Can', TO_DATE('02/April/2016','DD/MON/YY'), 'Manager', 2100, 'Esenler', 'İstanbul', 5522456324);
INSERT INTO employee VALUES (13, 'Umut', 'Pehlivan', TO_DATE('26/April/2015','DD/MON/YY'), 'Loader', 2100, 'Çankaya', 'Ankara', 5535216324);
INSERT INTO employee VALUES (14, 'Ferit Acar', 'Savacı', TO_DATE('16/April/2014','DD/MON/YY'), 'Owner', 1700, 'Urla', 'İzmir', 5224164524);
INSERT INTO employee VALUES (15, 'Enver', 'Tatlıcıoğlu', TO_DATE('24/April/2014','DD/MON/YY'), 'Loader',  2000, 'Merkez', 'Manisa', 5556241324);

INSERT INTO car VALUES (1, 'Mercedes', 'Vito' , 1100 , 2017, 5 );
INSERT INTO car VALUES (2, 'Volkswagen', 'Transporter' , 1300 , 2018, 8 );
INSERT INTO car VALUES (3, 'Fiat', 'Doblo' , 850 , 2015, 10 );
INSERT INTO car VALUES (4, 'Fiat', 'Doblo' , 1100 , 2017 , 5 );
INSERT INTO car VALUES (5, 'Renault', 'Kangoo' , 600 , 2016 ,8 );
INSERT INTO car VALUES (6, 'Mercedes', 'Vito' , 1100 , 2017, 10 );
INSERT INTO car VALUES (7, 'Volkswagen', 'Transporter' , 1300 , 2018, 5 );

INSERT INTO customer VALUES (1, 'Şaban Usta', 'Ali Erten' , 'Sahibi' , 'Konak Rustem Mah. No 37' , 'İzmir' , '5546022588');
INSERT INTO customer VALUES (2, 'Olala', 'Ali Çakır' , 'Sahibi' , 'Konak Torasan Mah. No 25' , 'İzmir' , '5336043588');
INSERT INTO customer VALUES (3, 'A101', 'Yağız Turan' , 'Şube Müdürü' , 'Konak Gülbahçe Mah. İYTE Kampüsü' , 'İzmir' , '5546026588');
INSERT INTO customer VALUES (4, 'Migros', 'Oğuzhan Dede' , 'Şube Müdürü' , 'Konak Sanayi Mah. No 45' , 'İzmir' , '5346022588');
INSERT INTO customer VALUES (5, 'BIM', 'Çağatay Gün' , 'Şube Müdürü' , 'Konak Hacı İsa Mah. Kipa AVM' , 'İzmir' , '5446023488');
INSERT INTO customer VALUES (6, 'Banabi', 'Çağrı Güneş' , 'Şube Müdürü' , 'Konak Hacı Mah. No 74' , 'İzmir' , '5447023488');
INSERT INTO customer VALUES (7, 'Getir', 'Baycan Akçay' , 'Şube Müdürü' , 'Konak Dükkan Cad. No 84' , 'İzmir' , '5446023548');
INSERT INTO customer VALUES (8, 'Kırçiçeği', 'Hayat Güzel' , 'Şube Müdürü' , 'Konak Mah. A Cad. No 84' , 'İzmir' , '5326023548');
INSERT INTO customer VALUES (9, 'Olahmacun', 'Yağız Can' , 'Sahibi' , 'Konak Atatürk Cad. No 84' , 'İzmir' , '5456025548');
INSERT INTO customer VALUES (10, 'Pidele', 'Mansur Hasan' , 'Sahibi' , 'Konak Ahmet Cad. No 76' , 'İzmir' , '5476023548');

INSERT INTO orders VALUES (1, TO_DATE('27/November/2019','DD/MON/YY'), TO_DATE('01/December/2019','DD/MON/YY'), TO_DATE('29/November/2019','DD/MON/YY'), 4900 , 200 , 1 , 4);
INSERT INTO orders VALUES (2, TO_DATE('30/November/2019','DD/MON/YY'), TO_DATE('05/December/2019','DD/MON/YY'), TO_DATE('02/November/2019','DD/MON/YY'), 990 , 150 , 3 , 1);
INSERT INTO orders VALUES (3, TO_DATE('03/December/2019','DD/MON/YY'), TO_DATE('05/December/2019','DD/MON/YY'), TO_DATE('02/December/2019','DD/MON/YY'), 1400 , 260 , 3 , 2);
INSERT INTO orders VALUES (4, TO_DATE('07/December/2019','DD/MON/YY'), TO_DATE('09/December/2019','DD/MON/YY'), TO_DATE('06/December/2019','DD/MON/YY'), 2500 , 148 , 4 , 6);
INSERT INTO orders VALUES (5, TO_DATE('12/December/2019','DD/MON/YY'), TO_DATE('17/December/2019','DD/MON/YY'), TO_DATE('14/December/2019','DD/MON/YY'), 1263 , 210 , 5 , 5);
INSERT INTO orders VALUES (6, TO_DATE('15/December/2019','DD/MON/YY'), TO_DATE('19/December/2019','DD/MON/YY'), TO_DATE('17/December/2019','DD/MON/YY'), 5687 , 310 , 7 , 5);
INSERT INTO orders VALUES (7, TO_DATE('20/December/2019','DD/MON/YY'), TO_DATE('23/December/2019','DD/MON/YY'), TO_DATE('21/December/2019','DD/MON/YY'), 8561 , 180 , 8 , 3);
INSERT INTO orders VALUES (8, TO_DATE('25/December/2019','DD/MON/YY'), TO_DATE('29/December/2019','DD/MON/YY'), TO_DATE('22/December/2019','DD/MON/YY'), 8231 , 200 , 8 , 4 );

INSERT INTO bad_orders VALUES (1, 4, 20, TO_DATE('22/April/2013','DD/MON/YY'));
INSERT INTO bad_orders VALUES (5, 2, 12, TO_DATE('10/July/2014','DD/MON/YY'));
INSERT INTO bad_orders VALUES (3, 3, 2, TO_DATE('03/May/2014','DD/MON/YY'));
INSERT INTO bad_orders VALUES (4, 6, 44, TO_DATE('25/September/2012','DD/MON/YY'));

INSERT INTO order_items VALUES (1 , 1 , 50 , 0 , 0);
INSERT INTO order_items VALUES (2 , 1 , 50 , 0 , 0);
INSERT INTO order_items VALUES (3 , 1 , 50 , 0 , 0);
INSERT INTO order_items VALUES (4 , 1 , 50 , 0 , 0);
INSERT INTO order_items VALUES (5 , 1 , 50 , 0 , 0);
INSERT INTO order_items VALUES (6 , 1 , 50 , 0 , 0);
INSERT INTO order_items VALUES (7 , 1 , 50 , 0 , 0);
INSERT INTO order_items VALUES (8 , 1 , 50 , 0 , 0);
INSERT INTO order_items VALUES (9 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (10 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (11 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (12 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (13 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (14 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (15 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (16 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (24 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (25 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (26 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (27 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (28 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (29 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (30 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (35 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (36 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (37 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (38 , 2 , 50 , 0 , 0);
INSERT INTO order_items VALUES (24 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (25 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (26 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (27 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (28 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (29 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (30 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (35 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (36 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (37 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (38 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (1 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (2 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (3 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (4 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (5 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (6 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (7 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (8 , 3 , 50 , 0 , 0);
INSERT INTO order_items VALUES (9 , 4 , 50 , 0 , 0);
INSERT INTO order_items VALUES (10 , 4 , 50 , 0 , 0);
INSERT INTO order_items VALUES (11 , 4 , 50 , 0 , 0);
INSERT INTO order_items VALUES (12 , 4 , 50 , 0 , 0);
INSERT INTO order_items VALUES (13 , 4 , 50 , 0 , 0);
INSERT INTO order_items VALUES (14 , 4 , 50 , 0 , 0);
INSERT INTO order_items VALUES (15 , 4 , 50 , 0 , 0);
INSERT INTO order_items VALUES (16 , 4 , 50 , 0 , 0);
INSERT INTO order_items VALUES (17 , 4 , 100 , 0 , 0);
INSERT INTO order_items VALUES (18 , 4 , 100 , 0 , 0);
INSERT INTO order_items VALUES (19 , 4 , 100 , 0 , 0);
INSERT INTO order_items VALUES (20 , 4 , 100 , 0 , 0);
INSERT INTO order_items VALUES (21 , 4 , 100 , 0 , 0);
INSERT INTO order_items VALUES (22 , 5 , 100 , 0 , 0);
INSERT INTO order_items VALUES (23 , 5 , 100 , 0 , 0);
INSERT INTO order_items VALUES (31 , 6 , 50 , 0 , 0);
INSERT INTO order_items VALUES (32 , 6 , 50 , 0 , 0);
INSERT INTO order_items VALUES (33 , 6 , 50 , 0 , 0);
INSERT INTO order_items VALUES (34 , 6 , 50 , 0 , 0);
INSERT INTO order_items VALUES (39 , 6 , 50 , 0 , 0);
INSERT INTO order_items VALUES (40 , 6 , 50 , 0 , 0);
INSERT INTO order_items VALUES (41 , 6 , 50 , 0 , 0);
INSERT INTO order_items VALUES (42 , 6 , 50 , 0 , 0);
INSERT INTO order_items VALUES (43 , 6 , 50 , 0 , 0);
INSERT INTO order_items VALUES (44 , 6 , 50 , 0 , 0);
INSERT INTO order_items VALUES (31 , 7 , 50 , 0 , 0);
INSERT INTO order_items VALUES (32 , 7 , 50 , 0 , 0);
INSERT INTO order_items VALUES (33 , 7 , 50 , 0 , 0);
INSERT INTO order_items VALUES (34 , 7 , 50 , 0 , 0);
INSERT INTO order_items VALUES (39 , 7 , 50 , 0 , 0);
INSERT INTO order_items VALUES (40 , 7 , 50 , 0 , 0);
INSERT INTO order_items VALUES (41 , 7 , 50 , 0 , 0);
INSERT INTO order_items VALUES (42 , 7 , 50 , 0 , 0);
INSERT INTO order_items VALUES (43 , 7 , 50 , 0 , 0);
INSERT INTO order_items VALUES (44 , 7 , 50 , 0 , 0);
INSERT INTO order_items VALUES (45 , 8 , 100 , 0 , 0);
INSERT INTO order_items VALUES (46 , 8 , 100 , 0 , 0);
INSERT INTO order_items VALUES (47 , 8 , 100 , 0 , 0);
INSERT INTO order_items VALUES (48 , 8 , 100 , 0 , 0);
INSERT INTO order_items VALUES (49 , 8 , 100 , 0 , 0);
INSERT INTO order_items VALUES (50 , 8 , 100 , 0 , 0);

INSERT INTO loan(loanid, orderid, customerid, amount)
SELECT orderid, orderid, customerid, orderprice
FROM "ORDERS";

INSERT INTO payment VALUES (1, 1 , TO_DATE('21/April/2019','DD/MON/YY'), 975);
INSERT INTO payment VALUES (2, 2 , TO_DATE('22/May/2019','DD/MON/YY'), 5000);
INSERT INTO payment VALUES (4, 3 , TO_DATE('01/September/2020','DD/MON/YY'), 5000);
INSERT INTO payment VALUES (3, 4 , TO_DATE('08/December/2019','DD/MON/YY'), 15000);
INSERT INTO payment VALUES (5, 5 , TO_DATE('13/June/2020','DD/MON/YY'), 500);
INSERT INTO payment VALUES (8, 6 , TO_DATE('22/April/2020','DD/MON/YY'), 1000);

INSERT INTO bills VALUES (1, 2, 2, 1200);
INSERT INTO bills VALUES (2, 2, 2, 1700);
INSERT INTO bills VALUES (3, 2, 1, 2222);
INSERT INTO bills VALUES (4, 5, 3, 3214);

UPDATE order_items SET (order_items.totalprice, order_items.totalweight) = (SELECT order_items.quantity * product.saleprice , order_items.quantity * product.weight FROM  product WHERE product.productid = order_items.productid);
