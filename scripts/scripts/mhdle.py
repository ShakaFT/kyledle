"""
This script allows to generate MHDle data.
Args:
--images --> Allow to reupload images.
"""

from collections import defaultdict
import json
import sys

from google.cloud import storage
import pandas as pd
import requests
from rich.console import Console

BUCKET_NAME = "kyledle.appspot.com"
PUBLIC_BUCKET_NAME = "kyledle-public"
DATA_URL = "https://docs.google.com/spreadsheets/d/1nwVxOynl2rduEWoAVuZjmrlnlDiHwu3RUUoleJ-j6uo/export?format=csv"
MHDLE_ID = "0"
PUBLIC_URL = "https://storage.cloud.google.com/kyledle-public"

console = Console()
storage_client = storage.Client()

bucket = storage_client.bucket(BUCKET_NAME)
public_bucket = storage_client.bucket(PUBLIC_BUCKET_NAME)

df = pd.read_csv(f"{DATA_URL}&gid={MHDLE_ID}")

mhdle_classic = {
    "characters": defaultdict(dict),
    "columns": [
        "Photo",
        "Type de monstre",
        "Éléments",
        "Faiblesses",
        "Afflictions",
        "Génération",
        "Sous-espèce",
    ],
    "indices": ["Taille Moyenne", "Couleur"],
}
for _, row in df.iterrows():
    monster = row["Nom"].strip()
    console.log(f"[bold green]{monster} [blue]processing...")
    blob = public_bucket.blob(f"mhdle/{monster}.png")

    if "--images" in sys.argv:
        response = requests.get(row["Photo"], timeout=60)
        blob.upload_from_string(response.content)

    mhdle_classic["characters"][monster] = {
        "columns": {
            "Photo": blob.public_url,
            "Type de monstre": row["Type de monstre"].strip(),
            "Éléments": [
                element.strip()
                for element in row["Éléments"].split("/")
                if element.strip().lower() != "x"
            ],
            "Faiblesses": [
                element.strip()
                for element in row["Faiblesses"].split("/")
                if element.strip().lower() != "x"
            ],
            "Génération": row["Génération"].strip(),
            "Afflictions": [
                element.strip()
                for element in row["Afflictions"].split("/")
                if element.strip().lower() != "x"
            ],
            "Sous-espèce": row["Sous-espèce"].strip(),
        },
        "indices": [str(row["Taille Moyenne"])],
    }

blob = bucket.blob("mhdle/classic.json")
blob.upload_from_string(json.dumps(mhdle_classic))
