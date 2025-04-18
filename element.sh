#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

MAIN_PROGRAM() {
  [[ -z $1 ]] && echo "Please provide an element as an argument." || PRINT_ELEMENT "$1"
}

PRINT_ELEMENT() {
  INPUT=$1

  if [[ $INPUT =~ ^[0-9]+$ ]]; then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$INPUT" | xargs)
  else
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$INPUT' OR name='$INPUT'" | xargs)
  fi

  if [[ -z $ATOMIC_NUMBER ]]; then
    echo "I could not find that element in the database."
    return
  fi

  TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER;" | xargs)
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER;" | xargs)
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER;" | xargs)
  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER;" | xargs)
  MELTING_POINT_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;" | xargs)
  BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;" | xargs)
  TYPE=$($PSQL "SELECT type FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;" | xargs)

  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
}

FIX_DB() {
  # You should rename the weight column to atomic_mass
  echo "RENAME_PROPERTIES_WEIGHT                    : $($PSQL \"ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;\")"

  # You should rename the melting_point column to melting_point_celsius and the boiling_point column to boiling_point_celsius
  echo "RENAME_PROPERTIES_MELTING_POINT             : $($PSQL \"ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;\")"
  echo "RENAME_PROPERTIES_BOILING_POINT             : $($PSQL \"ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;\")"

  # Your melting_point_celsius and boiling_point_celsius columns should not accept null values
  echo "ALTER_PROPERTIES_MELTING_POINT_NOT_NULL     : $($PSQL \"ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;\")"
  echo "ALTER_PROPERTIES_BOILING_POINT_NOT_NULL     : $($PSQL \"ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;\")"

  # You should add the UNIQUE constraint to the symbol and name columns from the elements table
  echo "ALTER_ELEMENTS_SYMBOL_UNIQUE                : $($PSQL \"ALTER TABLE elements ADD UNIQUE(symbol);\")"
  echo "ALTER_ELEMENTS_NAME_UNIQUE                  : $($PSQL \"ALTER TABLE elements ADD UNIQUE(name);\")"

  # Your symbol and name columns should have the NOT NULL constraint
  echo "ALTER_ELEMENTS_SYMBOL_NOT_NULL              : $($PSQL \"ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;\")"
  echo "ALTER_ELEMENTS_SYMBOL_NOT_NULL              : $($PSQL \"ALTER TABLE elements ALTER COLUMN name SET NOT NULL;\")"

  # You should set the atomic_number column from the properties table as a foreign key that references the column of the same name in the elements table
  echo "ALTER_PROPERTIES_ATOMIC_NUMBER_FOREIGN_KEY  : $($PSQL \"ALTER TABLE properties ADD FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);\")"

  # You should create a types table that will store the three types of elements
  echo "CREATE_TBL_TYPES                            : $($PSQL \"CREATE TABLE types();\")"

  # Your types table should have a type_id column that is an integer and the primary key
  echo "ADD_COLUMN_TYPES_TYPE_ID                    : $($PSQL \"ALTER TABLE types ADD COLUMN type_id SERIAL PRIMARY KEY;\")"

  # Your types table should have a type column that's a VARCHAR and cannot be null
  echo "ADD_COLUMN_TYPES_TYPE                       : $($PSQL \"ALTER TABLE types ADD COLUMN type VARCHAR(20) NOT NULL;\")"

  # You should add three rows to your types table whose values are the three different types from the properties table
  echo "INSERT_COLUMN_TYPES_TYPE                    : $($PSQL \"INSERT INTO types(type) SELECT DISTINCT(type) FROM properties;\")"

  # Your properties table should have a type_id foreign key column
  echo "ADD_COLUMN_PROPERTIES_TYPE_ID               : $($PSQL \"ALTER TABLE PROPERTIES ADD COLUMN type_id INT;\")"
  echo "ADD_FOREIGN_KEY_PROPERTIES_TYPE_ID          : $($PSQL \"ALTER TABLE properties ADD FOREIGN KEY(type_id) REFERENCES types(type_id);\")"

  # Each row in your properties table should have a type_id value that links to the correct type
  echo "UPDATE_PROPERTIES_TYPE_ID                   : $($PSQL \"UPDATE properties SET type_id = (SELECT type_id FROM types WHERE properties.type = types.type);\")"
  echo "ALTER_COLUMN_PROPERTIES_TYPE_ID_NOT_NULL    : $($PSQL \"ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;\")"

  # You should capitalize the first letter of all the symbol values
  echo "UPDATE_ELEMENTS_SYMBOL                      : $($PSQL \"UPDATE elements SET symbol=INITCAP(symbol);\")"

  # You should remove all trailing zeros after the decimals from atomic_mass
  echo "ALTER_VARCHAR_PROPERTIES_ATOMIC_MASS        : $($PSQL \"ALTER TABLE PROPERTIES ALTER COLUMN atomic_mass TYPE VARCHAR(9);\")"
  echo "UPDATE_FLOAT_PROPERTIES_ATOMIC_MASS         : $($PSQL \"UPDATE properties SET atomic_mass=CAST(atomic_mass AS FLOAT);\")"

  # You should add the element with atomic number 9
  echo "INSERT_ELEMENT_F                            : $($PSQL \"INSERT INTO elements(atomic_number,symbol,name) VALUES(9,'F','Fluorine');\")"
  echo "INSERT_PROPERTIES_F                         : $($PSQL \"INSERT INTO properties(atomic_number,type,melting_point_celsius,boiling_point_celsius,type_id,atomic_mass) VALUES(9,'nonmetal',-220,-188.1,3,'18.998');\")"

  # You should add the element with atomic number 10
  echo "INSERT_ELEMENT_NE                           : $($PSQL \"INSERT INTO elements(atomic_number,symbol,name) VALUES(10,'Ne','Neon');\")"
  echo "INSERT_PROPERTIES_NE                        : $($PSQL \"INSERT INTO properties(atomic_number,type,melting_point_celsius,boiling_point_celsius,type_id,atomic_mass) VALUES(10,'nonmetal',-248.6,-246.1,3,'20.18');\")"

  # You should delete the non-existent element
  echo "DELETE_PROPERTIES_1000                      : $($PSQL \"DELETE FROM properties WHERE atomic_number=1000;\")"
  echo "DELETE_ELEMENTS_1000                        : $($PSQL \"DELETE FROM elements WHERE atomic_number=1000;\")"

  # Your properties table should not have a type column
  echo "DELETE_COLUMN_PROPERTIES_TYPE               : $($PSQL \"ALTER TABLE properties DROP COLUMN type;\")"
}

START_PROGRAM() {
  CHECK=$($PSQL "SELECT COUNT(*) FROM elements WHERE atomic_number=1000;" | xargs)
  [[ $CHECK -gt 0 ]] && FIX_DB && clear
  MAIN_PROGRAM "$1"
}

START_PROGRAM "$1"
