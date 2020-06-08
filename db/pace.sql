DROP TABLE notes;
DROP TABLE animals;
DROP TABLE vets;

CREATE TABLE vets (
    id SERIAL primary key,
    name VARCHAR(255) not null
);

CREATE TABLE animals (
    id SERIAL primary key,
    name VARCHAR(255) not null,
    date_of_birth VARCHAR(255),
    animal_type VARCHAR(255),
    animal_breed VARCHAR(255),
    owner_name VARCHAR(255),
    owner_phone_number VARCHAR(255),
    treatment_notes TEXT,
    vet_id INT REFERENCES vets(id)
);

CREATE TABLE notes (
    id SERIAL primary key,
    treatment_notes TEXT,
    animal_id INT references animals(id)
)