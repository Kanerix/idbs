CREATE TABLE rentals(
    pid INT -- Person ID
    hid INT -- House ID
    s YEAR -- Start Year?
    PRIMARY KEY (pid, hid)
    FOREIGN KEY (pid) REFERENCES rentals_person(pid)
    FOREIGN KEY (hid) REFERENCES rentals_house(hid)
)

CREATE TABLE rentals_person(
    pid INT PRIMARY KEY
    pn VARCHAR(255) -- Person Name
)

CREATE TABLE rentals_house(
    hid INT PRIMARY KEY
    hs VARCHAR(255) -- House Street
    FOREIGN KEY (hs) REFERENCES rentals_street(s)
)

CREATE TABLE rentals_street(
    s VARCHAR(255) PRIMARY KEY -- Street
    z INT -- Zip
    FOREIGN KEY (z) REFERENCES rentals_zip(z)
)

CREATE TABLE rentals_zip(
    z INT PRIMARY KEY -- Zip
    c VARCHAR(255) -- City
)