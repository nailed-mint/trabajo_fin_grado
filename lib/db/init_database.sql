-- TABLES =====================================================================
CREATE TABLE IF NOT EXISTS game (
    -- columns definition
    id INTEGER PRIMARY KEY ON CONFLICT ROLLBACK AUTOINCREMENT,
    name TEXT NOT NULL,
    -- table constraints
    UNIQUE (name) ON CONFLICT ROLLBACK
);

CREATE TABLE IF NOT EXISTS gameplay (
    -- columns definition
    id INTEGER PRIMARY KEY ON CONFLICT ROLLBACK AUTOINCREMENT,
    game_id INTEGER NOT NULL,
    child_id INTEGER NOT NULL,
    result_id INTEGER NOT NULL,
    --table constraints
    FOREIGN KEY (game_id) REFERENCES game (id) ON DELETE CASCADE,
    FOREIGN KEY (child_id) REFERENCES child (id) ON DELETE CASCADE,
    FOREIGN KEY (result_id) REFERENCES result (id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS result (
    -- columns definition
    id INTEGER PRIMARY KEY ON CONFLICT ROLLBACK AUTOINCREMENT,
    gameplay_id INTEGER NOT NULL,
    report_id INTEGER,
    duration INTEGER, -- duration is stored in seconds 
    hits_number INTEGER,
    misses_number INTEGER,
    -- table constraints
    FOREIGN KEY (gameplay_id) REFERENCES gameplay (id) ON DELETE CASCADE,
    FOREIGN KEY (report_id) REFERENCES report (id) ON DELETE CASCADE,
    CHECK (duration >= 0)
);

CREATE TABLE IF NOT EXISTS user (
    -- columns definition
    id INTEGER PRIMARY KEY ON CONFLICT ROLLBACK AUTOINCREMENT,
    userType TEXT,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    -- table constraints
    CHECK (userType IN ("child", "family", "professional"))
);

CREATE TABLE IF NOT EXISTS child (
    -- columns definition
    id INTEGER PRIMARY KEY,
    family_id INTEGER,
    -- table constraints
    FOREIGN KEY (id) REFERENCES user (id) ON DELETE CASCADE,
    FOREIGN KEY (family_id) REFERENCES user (id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS professional (
    -- columns definition
    id INTEGER PRIMARY KEY,
    email TEXT,
    -- table constraints
    FOREIGN KEY (id) REFERENCES user (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS report (
    -- columns definition
    id INTEGER PRIMARY KEY ON CONFLICT ROLLBACK AUTOINCREMENT,
    child_id INTEGER NOT NULL,
    family_id INTEGER NOT NULL,
    -- table constraints
    FOREIGN KEY (child_id) REFERENCES child (id) ON DELETE CASCADE,
    FOREIGN KEY (family_id) REFERENCES family (id) ON DELETE CASCADE
);


-- CROSS REFERENCE TABLES =====================================================
CREATE TABLE xref_game_gameplay (
    -- columns definition
    game_id INTEGER NOT NULL,
    gameplay_id INTEGER NOT NULL,
    -- table constraints
    PRIMARY KEY (game_id, gameplay_id) ON CONFLICT ROLLBACK,
    FOREIGN KEY (game_id) REFERENCES game (id) ON DELETE CASCADE,
    FOREIGN KEY (gameplay_id) REFERENCES gameplay (id) ON DELETE CASCADE,
    UNIQUE (gameplay_id) ON CONFLICT ROLLBACK
);

CREATE TABLE xref_child_gameplay (
    -- columns definition
    child_id INTEGER NOT NULL,
    gameplay_id INTEGER NOT NULL,
    -- table constraints
    PRIMARY KEY (child_id, gameplay_id) ON CONFLICT ROLLBACK,
    FOREIGN KEY (child_id) REFERENCES child (id) ON DELETE CASCADE,
    FOREIGN KEY (gameplay_id) REFERENCES gameplay (id) ON DELETE CASCADE,
    UNIQUE (gameplay_id) ON CONFLICT ROLLBACK
);

CREATE TABLE xref_child_report (
    -- columns definition
    child_id INTEGER NOT NULL,
    report_id INTEGER NOT NULL,
    -- table constraints
    PRIMARY KEY (child_id, report_id) ON CONFLICT ROLLBACK,
    FOREIGN KEY (child_id) REFERENCES child (id) ON DELETE CASCADE,
    FOREIGN KEY (report_id) REFERENCES report (id) ON DELETE CASCADE,
    UNIQUE (report_id) ON CONFLICT ROLLBACK
);

CREATE TABLE xref_family_report (
    -- columns definition
    family_id INTEGER NOT NULL,
    report_id INTEGER NOT NULL,
    -- table constraints
    PRIMARY KEY (family_id, report_id) ON CONFLICT ROLLBACK,
    FOREIGN KEY (family_id) REFERENCES user (id) ON DELETE CASCADE,
    FOREIGN KEY (report_id) REFERENCES report (id) ON DELETE CASCADE,
    UNIQUE (report_id) ON CONFLICT ROLLBACK
);

CREATE TABLE xref_report_result (
    -- columns definition
    report_id INTEGER NOT NULL,
    result_id INTEGER NOT NULL,
    -- table constraints
    PRIMARY KEY (report_id, result_id) ON CONFLICT ROLLBACK,
    FOREIGN KEY (report_id) REFERENCES report (id) ON DELETE CASCADE,
    FOREIGN KEY (result_id) REFERENCES result (id) ON DELETE RESTRICT,
    UNIQUE (result_id) ON CONFLICT ROLLBACK
);


-- TODO: migrate triggers to dart models, they cannot be made like that in sqlite :(
/* -- TRIGGERS ===================================================================

-- GAME TABLE

-- GAMEPLAY TABLE

-- RESULT TABLE

-- USER TABLE
CREATE TRIGGER IF NOT EXISTS prevent_userType_update
BEFORE UPDATE OF userType ON user
FOR EACH ROW
BEGIN
    SELECT RAISE(ROLLBACK, 'Update of column "userType" is not allowed');
END;

-- CHILD TABLE
CREATE TRIGGER IF NOT EXISTS ensure_family_userType_insert
BEFORE INSERT OF family_id ON child
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN ((SELECT userType FROM user WHERE id = NEW.family_id) != 'family') THEN
            RAISE(ROLLBACK, 'family_id must reference a user of type "family"')
    END;
END;

CREATE TRIGGER IF NOT EXISTS ensure_family_userType_update
BEFORE UPDATE OF family_id ON child
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN ((SELECT userType FROM user WHERE id = NEW.family_id) != 'family') THEN
            RAISE(ROLLBACK, 'family_id must reference a user of type "family"')
    END;
END;

CREATE TRIGGER IF NOT EXISTS ensure_child_userType_insert
BEFORE INSERT OF id ON child
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN ((SELECT userType FROM user WHERE id = NEW.id) != 'child') THEN
            RAISE(ROLLBACK, 'id must reference a user of type "child"')
    END;
END;

CREATE TRIGGER IF NOT EXISTS ensure_child_userType_update
BEFORE UPDATE OF id ON child
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN ((SELECT userType FROM user WHERE id = NEW.id) != 'child') THEN
            RAISE(ROLLBACK, 'id must reference a user of type "child"')
    END;
END;

-- PROFESSIONAL TABLE
CREATE TRIGGER IF NOT EXISTS ensure_professional_userType_insert
BEFORE INSERT OF id ON professional
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN ((SELECT userType FROM user WHERE id = NEW.id) != 'professional') THEN
            RAISE(ROLLBACK, 'id must reference a user of type "professional"')
    END;
END;

CREATE TRIGGER IF NOT EXISTS ensure_professional_userType_update
BEFORE UPDATE OF id ON professional
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN ((SELECT userType FROM user WHERE id = NEW.id) != 'professional') THEN
            RAISE(ROLLBACK, 'id must reference a user of type "professional"')
    END;
END;

-- REPORT TABLE
 */