create database shopforhomec3g7;
use shopforhomec3g7;
CREATE TABLE cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
);


CREATE TABLE discount
(
    id character varying(255) NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
);

CREATE TABLE product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) ,
    category_type integer,
    create_time timestamp ,
    update_time timestamp ,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
);

ALTER TABLE `product_category` 
CHANGE COLUMN `category_id` `category_id` INT NOT NULL AUTO_INCREMENT ;


CREATE TABLE product_info
(
    product_id character varying(255)  NOT NULL,
    product_name character varying(255)  NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_stock integer NOT NULL,
    product_description character varying(255) ,
     product_icon character varying(255) , 
     product_status integer DEFAULT 0,
    category_type integer DEFAULT 0,
    create_time timestamp ,
    update_time timestamp ,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
);

CREATE TABLE users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) ,
    email character varying(255) ,
    name character varying(255) ,
    password character varying(255) ,
    phone character varying(255) ,
    role character varying(255) ,
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
);

ALTER TABLE `users` 
CHANGE COLUMN `id` `id` BIGINT NOT NULL AUTO_INCREMENT ;



CREATE TABLE order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) ,
    buyer_email character varying(255) ,
    buyer_name character varying(255) ,
    buyer_phone character varying(255) ,
    create_time timestamp,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
);

ALTER TABLE `order_main` 
CHANGE COLUMN `order_id` `order_id` BIGINT NOT NULL AUTO_INCREMENT ;



CREATE TABLE product_in_order
(
    id bigint NOT NULL AUTO_INCREMENT,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255)  NOT NULL,
    product_icon character varying(255) ,
    product_id character varying(255) ,
    product_name character varying(255) ,
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        ,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
);



CREATE TABLE wishlist
(
    id bigint NOT NULL AUTO_INCREMENT,
    created_date timestamp ,
    user_id bigint,
    product_id character varying(255),
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT user_wish_Fkey FOREIGN KEY (user_id)
        REFERENCES users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

ALTER TABLE `discount`
ADD COLUMN user_email VARCHAR(255);

ALTER TABLE `discount` 
ADD INDEX `user_email_fkey_idx` (`user_email` ASC) VISIBLE;
;
ALTER TABLE `discount` 
ADD CONSTRAINT `user_email_fkey`
  FOREIGN KEY (`user_email`)
  REFERENCES `users` (`email`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `discount` 
DROP PRIMARY KEY;
;

ALTER TABLE `discount` 
ADD COLUMN `coupon` VARCHAR(255) NULL AFTER `user_email`,
CHANGE COLUMN `id` `id` BIGINT NOT NULL ,
ADD PRIMARY KEY (`id`);
;

ALTER TABLE `discount` 
CHANGE COLUMN `id` `id` BIGINT NOT NULL AUTO_INCREMENT ;



INSERT INTO product_category VALUES (1, 'Appliances', 0, '2022-08-18 19:03:26', '2022-08-18 19:03:26');
INSERT INTO product_category VALUES (2, 'Furniture', 1, '2022-08-18 19:03:27', '2022-08-18 19:03:27');
INSERT INTO product_category VALUES (3, 'Garden', 2, '2022-08-18 19:03:27', '2022-08-18 19:03:27');
INSERT INTO product_category VALUES (4, 'Lighting', 3, '2022-08-18 19:03:28', '2022-08-18 19:03:28');

INSERT INTO product_info VALUES ('A01','Havells Water Purifer',13000,35,'Constantly monitors the purification process, ensures safe water always','/assets/images/A01.jpg',0,0,'2022-08-18 19:03:26','2022-08-18 19:03:26');
INSERT INTO product_info VALUES ('A02','Koryo 7.5kg Semi Automatic Washer',9999,50,'Great wash Quality and Easy to use','/assets/images/A02.jpg',0,0,'2022-08-18 19:03:26','2022-08-18 19:03:26');
INSERT INTO product_info VALUES ('A03','Havells Storage Water Heater',15999,100,' Made using feroglas technology, the instanio water heaters are absolutely safe to use and energy efficient as well','/assets/images/A03.jpg',0,0,'2022-08-18 19:03:26','2022-08-18 19:03:26');
INSERT INTO product_info VALUES ('A04',' Robotic Vacuum Cleaner with Alexa',29963,29,'Perfect cleaning robot for large houses. With a large dustbin and automatic recharging','/assets/images/A04.jpg',0,0,'2022-08-18 19:03:26','2022-08-18 19:03:26');

INSERT INTO product_info VALUES ('F01','Nicole 6 Seater Dining Set In Teak Finish',32900,78,'These products are designed by our seasoned artisans using traditional methods that will go on for ages','/assets/images/F01.jpg',0,1,'2022-08-18 19:03:26','2022-08-18 19:03:26');
INSERT INTO product_info VALUES ('F02','Lannister Aqua Queen Box Storage Bed',60260,85,' It uses a combination of vinyl, steel, plastic, glass or wood having monochromatic colours and sleek silhouettes','/assets/images/F02.jpg',0,1,'2022-08-18 19:03:26','2022-08-18 19:03:26');
INSERT INTO product_info VALUES ('F03','Amelio 3 Seater Sofa',38990,67,'CasaCraft offers the best in comfort, with elan','/assets/images/F03.jpg',0,1,'2022-08-18 19:03:26','2022-08-18 19:03:26');
INSERT INTO product_info VALUES ('F04','Tynisha Reclaimed Wood TV Console for TVs',23990,88,' Reclaimed wood furniture is made from solid wood that comes from old wooden sections ','/assets/images/F04.jpg',0,1,'2022-08-18 19:03:26','2022-08-18 19:03:26');

INSERT INTO product_info VALUES ('G01','Birds Engineered Wood Wall Hanging',1290,52,'Elegant, Beautiful, Innovatie, Flexible, Best space, Utility Shelve, Interactive, Ergonomically designed, user friendly','/assets/images/G01.jpg',0,2,'2022-08-18 19:03:26','2022-08-18 19:03:26');
INSERT INTO product_info VALUES ('G02','White Ceramic Buddha Shape Desk Pot',439,103,'Handmade item, glazed to give it shiny look','/assets/images/G02.jpg',0,2,'2022-08-18 19:03:26','2022-08-18 19:03:26');
INSERT INTO product_info VALUES ('G03','White Fabric Artificial Cherry Blossom Flower Sticks',510,90,'Flower material- Polyester fabric, stem material- plastic; Color: White ','/assets/images/G03.jpg',0,2,'2022-08-18 19:03:26','2022-08-18 19:03:26');
INSERT INTO product_info VALUES ('G04','Hanging Basket Planter ',900,200,'The unique hanging garden pots from Coirgarden are made of 100 % natural coco fibre','/assets/images/G04.jpg',0,2,'2022-08-18 19:03:26','2022-08-18 19:03:26');

INSERT INTO product_info VALUES ('L01','Oscuro Black Metal Chandelier',13990,80,'The candelabra bulbs offer the look of an older world look for a throwback to simpler times','/assets/images/L01.jpg',0,3,'2022-08-18 19:03:26','2022-08-18 19:03:26');
INSERT INTO product_info VALUES ('L02','Colourful Metal Wall Sconces',650,99,'Diffusing light in the downward direction, these lights will add a distinguished charm to your home',0,3,'2022-08-18 19:03:26','2022-08-18 19:03:26');
INSERT INTO product_info VALUES ('L03','Orange Wood Shade Table Lamp',1984,500,'The Table Lamp is the perfect blend of artistic flair and modern appeal','/assets/images/L03.jpg',0,3,'2022-08-18 19:03:26','2022-08-18 19:03:26');
INSERT INTO product_info VALUES ('L04','Black Metal Garden Light',4990,90,' Featuring a lantern like design and available in an excellent matte finish, this light is made of aluminum','/assets/images/L04.jpg',0,3,'2022-08-18 19:03:26','2022-08-18 19:03:26');

INSERT INTO users VALUES (1, true, 'MALKAPURAM, VISAKHAPATNAM', 'admin@gmail.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');




