#!/usr/bin/env python3
"""Validate and clean the synthetic Silwood tree survey."""

from __future__ import annotations

import csv
from pathlib import Path
from typing import Iterable

import math # checking for infinite and nan values at the same time

# PROJECT_ROOT = Path.cwd().resolve().parent
PROJECT_ROOT = Path(__file__).resolve().parents[1]
INPUT_PATH = PROJECT_ROOT / "data" / "silwood_trees_raw.csv"
RESULTS_DIR = PROJECT_ROOT / "results"

INPUT_FIELDS = [
    "record_id",
    "location",
    "genus",
    "species",
    "distance_m",
    "angle_degrees",
]
ISSUE_FIELDS = ["source_row", "record_id", "reasons"]
OAK_COUNT_FIELDS = ["species", "count"]


def load_records(path: Path = INPUT_PATH) -> list[dict[str, str]]:
    """Read the survey and check its column names."""
    with path.open(newline="", encoding="utf-8") as source:
        reader = csv.DictReader(source)
        if reader.fieldnames != INPUT_FIELDS:
            raise ValueError(
                f"Expected columns {INPUT_FIELDS}, found {reader.fieldnames}"
            )
        return list(reader)

def validate_record(
    row: dict[str, str],
    source_row: int,
    accepted_ids: set[str],
) -> tuple[dict[str, str] | None, list[str]]:
    """Clean one record, or return the reasons it cannot be used."""
    reasons = []

    # remove surrounding whitespace of record_id
    clean_record_id = row["record_id"].strip()

    # checking record id presence, validity and duplciation
    if clean_record_id == "":       
        reasons.append("missing record_id")
    elif (
        len(clean_record_id) != 5 
        or not clean_record_id.startswith('ST') 
        or not clean_record_id[2:5].isdigit()
    ):
        reasons.append('invalid record_id')

    if clean_record_id != "" and clean_record_id in accepted_ids:
        reasons.append("duplicate record_id")

    # removing surrounding whitespace of location
    clean_location = row["location"].strip()
    # setting valid locations case insensitive
    valid_locations = {
        "Silwood Bottom",
        "Nash's Field", 
        "Manor House", 
        "Reactor Wood",
    }
    valid_locations_fold = {
        i.casefold(): i
        for i in valid_locations
    } # a set of locations

    # checking location presence,validity
    clean_location_fold = clean_location.casefold() #single value
    if clean_location_fold == "":
        reasons.append('missing location')

    elif (
        clean_location_fold not in valid_locations_fold
    ):
        reasons.append("invalid location")
    else: 
        clean_location = valid_locations_fold[clean_location_fold]

    # removing surrounding whitesapce of genus
    clean_genus = row["genus"].strip()
    # set valid genra
    valid_genus = {
        "Quercus",
        "Acer",
        "Betula",
        "Fagus",
        "Fraxinus",
    }
    valid_genus_fold = {
        i.casefold(): i
        for i in valid_genus
    }
    # checking genus presence and validity
    clean_genus_fold = clean_genus.casefold()
    if clean_genus == "":
        reasons.append ('missing genus')

    elif (
        clean_genus_fold not in valid_genus_fold
    ):
        reasons.append('invalid genus')
    else:
        clean_genus = valid_genus_fold[clean_genus_fold]
    
    # removing surrounding whitesapce of species
    clean_species = row["species"].strip()
    # set valid species
    valid_species = {
        'robur', 
        'petraea',
        'pseudoplatanus',
        'pendula',
        'sylvatica',
        'excelsior',
    }
    valid_species_fold = {
         i.casefold(): i
                for i in valid_species
    }

    #checking species present and validity
    clean_species_fold = clean_species.casefold()
    if clean_species== "":
        reasons.append('missing species')

    elif (
        clean_species_fold not in valid_species_fold
    ):
        reasons.append('invalid species')
    else:
        clean_species = valid_species_fold[clean_species_fold]

    # check genus and species combination
    valid_comb = [
        ('Quercus','robur'),
        ('Quercus','petraea'),
        ('Acer','pseudoplatanus'),
        ('Betula','pendula'),
        ('Fagus','sylvatica'),
        ('Fraxinus','excelsior'),
    ]
    if (
    clean_genus.casefold() in valid_genus_fold
    and clean_species.casefold() in valid_species_fold
    ):
        if (clean_genus, clean_species) not in valid_comb:
            reasons.append('invalid genus/species combination')

    # check distance present, validity and range
    if row["distance_m"] == "":
        reasons.append ('missing distance_m')
    else:
        try:
            valid_distance_m = float(row["distance_m"])
            if not math.isfinite(valid_distance_m):
                reasons.append('invalid distance_m')
            elif valid_distance_m > 100 or valid_distance_m <= 0:
                reasons.append('distance_m out of range')
        except ValueError:
            reasons.append('invalid distance_m')
                
    
    # check angle presence, validity and range
    if row["angle_degrees"] == "":
        reasons.append ('missing angle_degrees')
    else:
        try:
            valid_angle_degrees = float(row["angle_degrees"])
            if not math.isfinite(valid_angle_degrees):
                reasons.append('invalid angle_degrees')
            elif valid_angle_degrees <= 0 or valid_angle_degrees >= 90:
                reasons.append('angle_degrees out of range')
        except ValueError:
            reasons.append('invalid angle_degrees')

    # checking whether reasons is not empty
    if reasons:
        return (None,reasons)
    else:
        # copying into new rows
        cleaned_row = row.copy()
        cleaned_row["record_id"] = clean_record_id
        cleaned_row["location"] = clean_location
        cleaned_row["genus"] = clean_genus
        cleaned_row["species"] = clean_species
        cleaned_row["distance_m"] = valid_distance_m
        cleaned_row["angle_degrees"] = valid_angle_degrees
        accepted_ids.add(clean_record_id)
        return (cleaned_row, [])
    
def process_records(
    rows: Iterable[dict[str, str]],
) -> tuple[list[dict[str, str]], list[dict[str, str]]]:
    """Sort records into accepted rows and issue reports."""
    # intialise variables
    clean_records = []
    issues = []
    accepted_ids = set()

    #loop through the records
    for source_row, row in enumerate(rows, start=2):
        cleaned_row, reasons = validate_record(row, source_row, accepted_ids)
        if cleaned_row is not None:
            clean_records.append(cleaned_row)
        else:
            issue = {
                    "source_row": source_row,
                    "record_id" : row["record_id"].strip(),
                    "reasons" : "; ".join(reasons),
            }
            issues.append(issue)
    clean_records.sort(key=lambda item: item["record_id"])
    return (clean_records,issues)

def summarise_oaks(clean_records: Iterable[dict[str, str]]) -> list[dict[str, str]]:
    """Count accepted oak records by species."""
    # intialise variables
    oak_counts = []
    count_Quercus_robur = 0
    count_Quercus_petraea = 0
    for row in clean_records:
        if row["genus"] == "Quercus" and row["species"] == "robur":
            count_Quercus_robur +=1
        elif row["genus"] == "Quercus" and row["species"] == "petraea":
            count_Quercus_petraea +=1
    if count_Quercus_robur > 0:
        oak_counts.append({"species":"robur","count": count_Quercus_robur})
    if count_Quercus_petraea > 0:
        oak_counts.append({"species":"petraea","count": count_Quercus_petraea})
    return oak_counts

def write_csv(
    path: Path,
    fieldnames: list[str],
    rows: Iterable[dict[str, str]],
) -> None:
    """Write rows to a CSV file, replacing an older copy."""
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as destination:
        writer = csv.DictWriter(destination, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def main() -> None:
    """Clean the survey and write the three result files."""
    clean_records, issues = process_records(load_records())
    oak_counts = summarise_oaks(clean_records)

    write_csv(
        RESULTS_DIR / "silwood_trees_clean.csv",
        INPUT_FIELDS,
        clean_records,
    )
    write_csv(
        RESULTS_DIR / "silwood_tree_issues.csv",
        ISSUE_FIELDS,
        issues,
    )
    write_csv(
        RESULTS_DIR / "oak_species_counts.csv",
        OAK_COUNT_FIELDS,
        oak_counts,
    )


if __name__ == "__main__":
    main()
