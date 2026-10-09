import csv


def load_observations(path):
    with open(path, newline="", encoding="utf-8") as stream:
        return list(csv.DictReader(stream))

def parse_count(count_text):
    if count_text == "":
        return None
    try:
        if int(count_text) >= 0:
            return int(count_text)
        else: 
            raise ValueError
    except ValueError:
        raise ValueError        

if __name__ == "__main__":
    rows = load_observations("data/bootcamp_observations.csv")
    print(rows[0])
    print(rows[2])

