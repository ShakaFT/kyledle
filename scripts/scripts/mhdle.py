"""
This script allows to generate MHDle data.
Args:
--images --> Allow to reupload images.
"""

import json

from google.cloud import storage
import pandas as pd
from redis import Redis
from rich.console import Console

DATA_URL = "https://docs.google.com/spreadsheets/d/1nwVxOynl2rduEWoAVuZjmrlnlDiHwu3RUUoleJ-j6uo/export?format=csv"
MHDLE_ID = "0"

redis = Redis(host="localhost", port=6379)

console = Console()
storage_client = storage.Client()

public_bucket = storage_client.bucket("kyledle-public")


def string_to_list(value: str) -> str:
    """
    This function casts string to list.
    """
    return json.dumps(
        [element.strip() for element in value.split("/")], ensure_ascii=False
    )


def main():
    """
    main function
    """
    # Characters
    df = pd.read_csv(f"{DATA_URL}&gid={MHDLE_ID}")
    for _, row in df.iterrows():
        character = row["Nom"].strip()
        console.log(f"[bold green]{character} [blue]processing...")
        blob = public_bucket.blob(f"mhdle/{character}.png")

        redis.hset(
            f"mhdle:character:{character}",
            mapping={
                "Nom": character,
                "Photo": blob.public_url,
                "Type de monstre": row["Type de monstre"].strip(),
                "Éléments": string_to_list(row["Éléments"]),
                "Faiblesses": string_to_list(row["Faiblesses"]),
                "Afflictions": string_to_list(row["Afflictions"]),
                "Génération": row["Génération"].strip(),
                "Sous-espèce / Déviant / Variant": row[
                    "Sous-espèce / Déviant / Variant"
                ].strip(),
                "Taille Moyenne": str(row["Taille Moyenne"]).strip() + " cm",
                "Couleurs": string_to_list(row["Couleurs"]),
            },
        )

    # Classic config
    redis.hset(
        "mhdle:mode:classic",
        mapping={
            "columns": json.dumps(
                [
                    "Nom",
                    "Photo",
                    "Type de monstre",
                    "Éléments",
                    "Faiblesses",
                    "Afflictions",
                    "Génération",
                    "Sous-espèce / Déviant / Variant",
                ],
                ensure_ascii=False,
            ),
            "indices": json.dumps(["Taille Moyenne", "Couleurs"], ensure_ascii=False),
        },
    )


if __name__ == "__main__":
    main()
