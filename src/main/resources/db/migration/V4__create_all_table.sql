-- Table: users
CREATE TABLE users (
                       id int AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(255) UNIQUE NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       is_enabled BOOLEAN DEFAULT TRUE,
                       account_no_expired BOOLEAN DEFAULT TRUE,
                       account_no_locked BOOLEAN DEFAULT TRUE,
                       credentials_no_expired BOOLEAN DEFAULT TRUE
);

-- Table: roles
CREATE TABLE roles (
                       id int AUTO_INCREMENT PRIMARY KEY,
                       role_name VARCHAR(255) NOT NULL
);

-- Table: permissions
CREATE TABLE permissions (
                             id int AUTO_INCREMENT PRIMARY KEY,
                             name VARCHAR(255) UNIQUE NOT NULL
);

-- Table: user_roles (Many-to-Many relationship between users and roles)
CREATE TABLE user_roles (
                            user_id int,
                            role_id int,
                            PRIMARY KEY (user_id, role_id),
                            FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
                            FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
);

-- Table: role_permissions (Many-to-Many relationship between roles and permissions)
CREATE TABLE role_permissions (
                                  role_id int,
                                  permission_id int,
                                  PRIMARY KEY (role_id, permission_id),
                                  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
                                  FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE
);


-- Insertar permisos
INSERT INTO permissions (name) VALUES ('CREATE');
INSERT INTO permissions (name) VALUES ('READ');
INSERT INTO permissions (name) VALUES ('UPDATE');
INSERT INTO permissions (name) VALUES ('DELETE');
INSERT INTO permissions (name) VALUES ('REFACTOR');

-- Insertar roles
INSERT INTO roles (role_name) VALUES ('ADMIN');
INSERT INTO roles (role_name) VALUES ('USER');
INSERT INTO roles (role_name) VALUES ('INVITED');
INSERT INTO roles (role_name) VALUES ('DEVELOPER');

-- Asignar permisos a los roles
-- ADMIN (CREATE, READ, UPDATE, DELETE)
INSERT INTO role_permissions (role_id, permission_id) VALUES
                                                          ((SELECT id FROM roles WHERE role_name = 'ADMIN'), (SELECT id FROM permissions WHERE name = 'CREATE')),
                                                          ((SELECT id FROM roles WHERE role_name = 'ADMIN'), (SELECT id FROM permissions WHERE name = 'READ')),
                                                          ((SELECT id FROM roles WHERE role_name = 'ADMIN'), (SELECT id FROM permissions WHERE name = 'UPDATE')),
                                                          ((SELECT id FROM roles WHERE role_name = 'ADMIN'), (SELECT id FROM permissions WHERE name = 'DELETE'));

-- USER (CREATE, READ)
INSERT INTO role_permissions (role_id, permission_id) VALUES
                                                          ((SELECT id FROM roles WHERE role_name = 'USER'), (SELECT id FROM permissions WHERE name = 'CREATE')),
                                                          ((SELECT id FROM roles WHERE role_name = 'USER'), (SELECT id FROM permissions WHERE name = 'READ'));

-- INVITED (READ)
INSERT INTO role_permissions (role_id, permission_id) VALUES
    ((SELECT id FROM roles WHERE role_name = 'INVITED'), (SELECT id FROM permissions WHERE name = 'READ'));

-- DEVELOPER (CREATE, READ, UPDATE, DELETE, REFACTOR)
INSERT INTO role_permissions (role_id, permission_id) VALUES
                                                          ((SELECT id FROM roles WHERE role_name = 'DEVELOPER'), (SELECT id FROM permissions WHERE name = 'CREATE')),
                                                          ((SELECT id FROM roles WHERE role_name = 'DEVELOPER'), (SELECT id FROM permissions WHERE name = 'READ')),
                                                          ((SELECT id FROM roles WHERE role_name = 'DEVELOPER'), (SELECT id FROM permissions WHERE name = 'UPDATE')),
                                                          ((SELECT id FROM roles WHERE role_name = 'DEVELOPER'), (SELECT id FROM permissions WHERE name = 'DELETE')),
                                                          ((SELECT id FROM roles WHERE role_name = 'DEVELOPER'), (SELECT id FROM permissions WHERE name = 'REFACTOR'));

-- Insertar usuarios
INSERT INTO users (username, password, is_enabled, account_no_expired, account_no_locked, credentials_no_expired) VALUES
                                                                                                                      ('edwin', '$2a$10$1BmSwMuXWHX5M5GJGRI7suZgKtKc8Y/LadxC1PgPWLz45DPN0Rsmu', true, true, true, true),
                                                                                                                      ('ricardo', '$2a$10$1BmSwMuXWHX5M5GJGRI7suZgKtKc8Y/LadxC1PgPWLz45DPN0Rsmu', true, true, true, true),
                                                                                                                      ('dafne', '$2a$10$1BmSwMuXWHX5M5GJGRI7suZgKtKc8Y/LadxC1PgPWLz45DPN0Rsmu', true, true, true, true),
                                                                                                                      ('dayiro', '$2a$10$1BmSwMuXWHX5M5GJGRI7suZgKtKc8Y/LadxC1PgPWLz45DPN0Rsmu', true, true, true, true);

-- Asignar roles a los usuarios
-- Edwin (ADMIN)
INSERT INTO user_roles (user_id, role_id) VALUES
    ((SELECT id FROM users WHERE username = 'edwin'), (SELECT id FROM roles WHERE role_name = 'ADMIN'));

-- Ricardo (USER)
INSERT INTO user_roles (user_id, role_id) VALUES
    ((SELECT id FROM users WHERE username = 'ricardo'), (SELECT id FROM roles WHERE role_name = 'USER'));

-- Dafne (INVITED)
INSERT INTO user_roles (user_id, role_id) VALUES
    ((SELECT id FROM users WHERE username = 'dafne'), (SELECT id FROM roles WHERE role_name = 'INVITED'));

-- Dayiro (DEVELOPER)
INSERT INTO user_roles (user_id, role_id) VALUES
    ((SELECT id FROM users WHERE username = 'dayiro'), (SELECT id FROM roles WHERE role_name = 'DEVELOPER'));
