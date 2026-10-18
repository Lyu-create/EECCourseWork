#!/usr/bin/env python3

"""Checks for the functions in clean_silwood_trees.py"""

from clean_silwood_trees import (
    validate_record,
    process_records,
    summarise_oaks,
)

## validate record
# normal case with no rejection at any column
assert validate_record ({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "21.4",
    "angle_degrees": "24.0",
}, 1, set()) == (
{
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": 21.4,
    "angle_degrees": 24.0,
}, []
)

# 1. missing record_id
assert validate_record ({
    "record_id": "",
    "location": "Reactor Wood",
    "genus": "Quercus",
    "species": "robur",
    "distance_m": "12",
    "angle_degrees": "36",
}, 1, set()) == (
    None,
    ["missing record_id"]
)

# 2. invalid record_id
# does not start with ST
assert validate_record({
    "record_id": "AB123",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "robur",
    "distance_m": "12",
    "angle_degrees": "36",
}, 1, set()) == (
    None,
    ["invalid record_id"]
)

# does not end with three digits
assert validate_record({
    "record_id": "ST12A",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "robur",
    "distance_m": "12",
    "angle_degrees": "36",
}, 1, set()) == (
    None,
    ["invalid record_id"]
)

# does not have five characters
assert validate_record({
    "record_id": "TREE27",
    "location": "Nash's Field",
    "genus": "Acer",
    "species": "pseudoplatanus",
    "distance_m": "13",
    "angle_degrees": "34",
}, 1, set()) == (
    None,
    ["invalid record_id"]
)

# 3. duplicate record_id
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "21.4",
    "angle_degrees": "24.0",
}, 1, {"ST014"}) == (
    None,
    ["duplicate record_id"]
)

# 4. missing location
assert validate_record({
    "record_id": "ST014",
    "location": "",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "21.4",
    "angle_degrees": "24.0",
}, 1, set()) == (
    None,
    ["missing location"]
)

# 5. invalid location
assert validate_record({
    "record_id": "ST014",
    "location": "London",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "21.4",
    "angle_degrees": "24.0",
}, 1, set()) == (
    None,
    ["invalid location"]
)

# 6. missing genus
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "",
    "species": "petraea",
    "distance_m": "21.4",
    "angle_degrees": "24.0",
}, 1, set()) == (
    None,
    ["missing genus"]
)

# 7. invalid genus
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Pinus",
    "species": "petraea",
    "distance_m": "21.4",
    "angle_degrees": "24.0",
}, 1, set()) == (
    None,
    ["invalid genus"]
)

# 8. missing species
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "",
    "distance_m": "21.4",
    "angle_degrees": "24.0",
}, 1, set()) == (
    None,
    ["missing species"]
)

# 9. invalid species
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "alba",
    "distance_m": "21.4",
    "angle_degrees": "24.0",
}, 1, set()) == (
    None,
    ["invalid species"]
)

# 10. invalid genus/species combination
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "pendula",
    "distance_m": "21.4",
    "angle_degrees": "24.0",
}, 1, set()) == (
    None,
    ["invalid genus/species combination"]
)

# 11. missing distance_m
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "",
    "angle_degrees": "24.0",
}, 1, set()) == (
    None,
    ["missing distance_m"]
)

# 12. invalid distance_m
# not a number
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "abc",
    "angle_degrees": "24.0",
}, 1, set()) == (
    None,
    ["invalid distance_m"]
)

# infinite
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "inf",
    "angle_degrees": "24.0",
}, 1, set()) == (
    None,
    ["invalid distance_m"]
)

# 13. distance_m out of range
# smaller than 0
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "-5",
    "angle_degrees": "24.0",
}, 1, set()) == (
    None,
    ["distance_m out of range"]
)

# equal to 0
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "0",
    "angle_degrees": "24.0",
}, 1, set()) == (
    None,
    ["distance_m out of range"]
)

# greater than 100
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "150",
    "angle_degrees": "24.0",
}, 1, set()) == (
    None,
    ["distance_m out of range"]
)

# 14. missing angle_degrees
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "21.4",
    "angle_degrees": "",
}, 1, set()) == (
    None,
    ["missing angle_degrees"]
)

# 15. invalid angle_degrees
# not a number
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "21.4",
    "angle_degrees": "abc",
}, 1, set()) == (
    None,
    ["invalid angle_degrees"]
)

# infinite
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "21.4",
    "angle_degrees": "inf",
}, 1, set()) == (
    None,
    ["invalid angle_degrees"]
)

# 16. angle_degrees out of range
# smaller than 0
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "21.4",
    "angle_degrees": "-5",
}, 1, set()) == (
    None,
    ["angle_degrees out of range"]
)

# equal to 0
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "21.4",
    "angle_degrees": "0",
}, 1, set()) == (
    None,
    ["angle_degrees out of range"]
)

# greater than 90
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "21.4",
    "angle_degrees": "126",
}, 1, set()) == (
    None,
    ["angle_degrees out of range"]
)

# equal to 90
assert validate_record({
    "record_id": "ST014",
    "location": "Silwood Bottom",
    "genus": "Quercus",
    "species": "petraea",
    "distance_m": "21.4",
    "angle_degrees": "90",
}, 1, set()) == (
    None,
    ["angle_degrees out of range"]
)

# 17. case-insensitive cleaning
assert validate_record({
    "record_id": "ST014",
    "location": "SILWOOD BOTTOM",
    "genus": "quercus",
    "species": "PETRAEA",
    "distance_m": "21.4",
    "angle_degrees": "24.0",
}, 1, set()) == (
    {
        "record_id": "ST014",
        "location": "Silwood Bottom",
        "genus": "Quercus",
        "species": "petraea",
        "distance_m": 21.4,
        "angle_degrees": 24.0,
    },
    []
)


## process records
# normal case with valid and invalid records
assert process_records([
    {
        "record_id": "ST014",
        "location": "Silwood Bottom",
        "genus": "Quercus",
        "species": "petraea",
        "distance_m": "21.4",
        "angle_degrees": "24.0",
    },
    {
        "record_id": "ST002",
        "location": "Nash's Field",
        "genus": "Acer",
        "species": "pseudoplatanus",
        "distance_m": "13",
        "angle_degrees": "34",
    },
    {
        "record_id": "ST020",
        "location": "London",
        "genus": "Quercus",
        "species": "robur",
        "distance_m": "12",
        "angle_degrees": "36",
    },
]) == (
    [
        {
            "record_id": "ST002",
            "location": "Nash's Field",
            "genus": "Acer",
            "species": "pseudoplatanus",
            "distance_m": 13.0,
            "angle_degrees": 34.0,
        },
        {
            "record_id": "ST014",
            "location": "Silwood Bottom",
            "genus": "Quercus",
            "species": "petraea",
            "distance_m": 21.4,
            "angle_degrees": 24.0,
        },
    ],
    [
        {
            "source_row": 4,
            "record_id": "ST020",
            "reasons": "invalid location",
        },
    ],
)

# duplicated records
assert process_records([
    {
        "record_id": "ST014",
        "location": "Silwood Bottom",
        "genus": "Quercus",
        "species": "petraea",
        "distance_m": "21.4",
        "angle_degrees": "24.0",
    },
    {
        "record_id": "ST014",
        "location": "Nash's Field",
        "genus": "Acer",
        "species": "pseudoplatanus",
        "distance_m": "13",
        "angle_degrees": "34",
    },
]) == (
    [
        {
            "record_id": "ST014",
            "location": "Silwood Bottom",
            "genus": "Quercus",
            "species": "petraea",
            "distance_m": 21.4,
            "angle_degrees": 24.0,
        },
    ],
    [
        {
            "source_row": 3,
            "record_id": "ST014",
            "reasons": "duplicate record_id",
        },
    ],
)

# multiple errors, especially not having invalid genus/species combination with invalid genus and invalid species
assert process_records([
    {
        "record_id": "ST014",
        "location": "London",
        "genus": "Pinus",
        "species": "alba",
        "distance_m": "abc",
        "angle_degrees": "24.0",
    },
]) == (
    [],
    [
        {
            "source_row": 2,
            "record_id": "ST014",
            "reasons": (
                "invalid location; invalid genus; "
                "invalid species; invalid distance_m"
            ),
        },
    ],
)

# invalid records do not reserve record_id
assert process_records([
    {
        "record_id": "ST015",
        "location": "London",
        "genus": "Quercus",
        "species": "robur",
        "distance_m": "12",
        "angle_degrees": "36",
    },
    {
        "record_id": "ST014",
        "location": "Silwood Bottom",
        "genus": "Quercus",
        "species": "robur",
        "distance_m": "12",
        "angle_degrees": "36",
    },
]) == (
    [
        {
            "record_id": "ST014",
            "location": "Silwood Bottom",
            "genus": "Quercus",
            "species": "robur",
            "distance_m": 12.0,
            "angle_degrees": 36.0,
        },
    ],
    [
        {
            "source_row": 2,
            "record_id": "ST015",
            "reasons": "invalid location",
        },
    ],
)

## sumarise oaks
# normal case counting both aok species
assert summarise_oaks([
    {
        "record_id": "ST001",
        "location": "Silwood Bottom",
        "genus": "Quercus",
        "species": "robur",
        "distance_m": 12.0,
        "angle_degrees": 36.0,
    },
    {
        "record_id": "ST002",
        "location": "Nash's Field",
        "genus": "Quercus",
        "species": "robur",
        "distance_m": 15.0,
        "angle_degrees": 40.0,
    },
    {
        "record_id": "ST003",
        "location": "Manor House",
        "genus": "Quercus",
        "species": "petraea",
        "distance_m": 21.4,
        "angle_degrees": 24.0,
    },
]) == [
    {"species": "robur", "count": 2},
    {"species": "petraea", "count": 1},
]

# one species with zero count
assert summarise_oaks([
    {
        "record_id": "ST001",
        "location": "Silwood Bottom",
        "genus": "Quercus",
        "species": "robur",
        "distance_m": 12.0,
        "angle_degrees": 36.0,
    },
]) == [
    {"species": "robur", "count": 1},
]

# both species with zero counts
assert summarise_oaks([
    {
        "record_id": "ST001",
        "location": "Silwood Bottom",
        "genus": "Acer",
        "species": "pseudoplatanus",
        "distance_m": 12.0,
        "angle_degrees": 36.0,
    },
]) == []