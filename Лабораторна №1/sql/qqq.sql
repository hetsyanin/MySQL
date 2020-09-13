CREATE DATABASE MyCMS CHARACTER SET utf8 COLLATE DEFAULT;
CREATE TABLE MyCMS.CATEGORY (
categoryID INT UNSIGNED NOT NULL AUTO_INCREMENT,
cname VARCHAR(39),
PRIMARY KEY (categoryID)
);
CREATE TABLE MyCMS.ROLE (
roleID SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
rolename CHAR(19) NOT NULL,
permissions VARCHAR(255) NOT NULL,
PRIMARY KEY (roleID)
);
CREATE TABLE MyCMS.AUTHOR (
authorID INT UNSIGNED NOT NULL AUTO_INCREMENT
name CHAR(99) NOT NULL,
login CHAR(19) NOT NULL,
password CHAR(255) NOT NULL,
created DATETIME NOT NULL,
email CHAR(40) NOT NULL,
profile TEXT,
roleID SMALLINT UNSIGNED NOT NULL,
PRIMARY KEY (authorID),
CONSTRAINT author_role FOREIGN KEY (roleID)
REFERENCES MyCMS.ROLE (roleID) ON DELETE NO ACTION ON
UPDATE NO ACTION
);
CREATE TABLE MyCMS.MESSAGE (
messageID INT UNSIGNED NOT NULL AUTO_INCREMENT,
message TEXT NOT NULL,
authorID INT UNSIGNED NOT NULL,
posted DATETIME NOT NULL,
status ENUM ('published', 'unpublished', 'deleted',)
DEFAULT 'published',
rating TINYINT,
attachment BOOL DEFAULT 0,
PRIMARY KEY (messageID),
CONSTRAINT message_author FOREIGN KEY (authorID)
REFERENCES MyCMS.AUTHOR (authorID) ON DELETE NO ACTION ON
UPDATE NO ACTION
);
CREATE TABLE MyCMS.COMMENT (
commentID INT UNSIGNED NOT NULL AUTO_INCREMENT,
messageID INT UNSIGNED NOT NULL,
autorID INT UNSIGNED NOT NULL,
text TEXT NOT NULL,
status ENUM ('published', 'unpublished', 'deleted',)
DEFAULT 'published',
posted TIMESTAMP NOT NULL,
PRIMARY KEY (commentID),
CONSTRAINT comment_message FOREIGN KEY (messageID)
REFERENCES MyCMS.MESSAGE (messageID) ON DELETE CASCADE ON
UPDATE CASCADE
);
CREATE TABLE MyCMS.FILE (
fileID INT UNSIGNED NOT NULL AUTO_INCREMENT,
messageID INT UNSIGNED NOT NULL,
authorID INT UNSIGNED NOT NULL,
fname CHAR(39) NOT NULL,
path CHAR(199) NOT NULL,
type CHAR(5) NOT NULL,
size INT UNSIGNED,
UNIQUE UQ_File_Message (fileID, messageID),
PRIMARY KEY (fileID),
CONSTRAINT file_message FOREIGN KEY (messageID)
REFERENCES MyCMS.MESSAGE (messageID) ON DELETE NO ACTION ON
UPDATE NO ACTION,
CONSTRAINT file_author FOREIGN KEY (authorID)
REFERENCES MyCMS.AUTHOR (authorID) ON DELETE NO ACTION ON
UPDATE NO ACTION
);
CREATE TABLE MyCMS.SESSION (
sessionID VARCHAR(255) NOT NULL,
authorID INT UNSIGNED NOT NULL,
start TIMESTAMP NOT NULL,
sessioninfo VARCHAR(255),
CONSTRAINT session_author FOREIGN KEY (authorID)
REFERENCES MyCMS.AUTHOR (authorID) ON DELETE NO ACTION ON
UPDATE NO ACTION
);
CREATE TABLE MyCMS.MESSAGE_CATEGORY (
messageID INT UNSIGNED NOT NULL,
categoryID INT UNSIGNED NOT NULL,
CONSTRAINT cat_category FOREIGN KEY (categoryID)
REFERENCES MyCMS.CATEGORY (categoryID) ON DELETE NO ACTION ON
UPDATE NO ACTION,
CONSTRAINT cat_message FOREIGN KEY (messageID)
REFERENCES MyCMS.MESSAGE (messageID) ON DELETE NO ACTION ON
UPDATE NO ACTION
);
