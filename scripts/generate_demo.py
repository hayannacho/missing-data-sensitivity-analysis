"""Generate artificial rows from equations, without reading any source dataset."""
import csv
import math
from pathlib import Path
import random

ROOT = Path(__file__).resolve().parents[1]


def generate_rows(n=400, seed=2025):
    rng = random.Random(seed)
    rows = []
    for i in range(n):
        age = rng.uniform(55, 90)
        gender = rng.choice(['Female', 'Male'])
        interval = rng.uniform(0, 36)
        amyloid = rng.uniform(0.7, 2.1)
        peptides = {f'PEP{j:03}': rng.gauss(0, 1) for j in range(1, 70)}
        tau = max(0.2, 1 + 0.009 * (age - 70) + 0.15 * peptides['PEP001']
                  + 0.12 * amyloid + rng.gauss(0, 0.2))
        wmh = 0.0 if rng.random() < 0.12 else rng.lognormvariate(6, 0.7)
        # Missing TAU depends on fully observed amyloid (MAR by construction).
        missing_probability = 1 / (1 + math.exp(-(-2.5 + 1.2 * amyloid)))
        if rng.random() < missing_probability:
            tau = 0.0 if i % 2 == 0 else ''  # exercise sentinel restoration
        row = dict(DATA_SOURCE='SYNTHETIC_NOT_ADNI', TAU_SUVR=tau,
                   WMH_volume_mm3='' if rng.random() < 0.08 else wmh,
                   AGE='' if rng.random() < 0.04 else age,
                   PTGENDER='' if rng.random() < 0.04 else gender,
                   interval_months='' if rng.random() < 0.06 else interval,
                   SUVR_GlobalSUVR=amyloid, **peptides)
        rows.append(row)
    return rows


def main():
    output = ROOT / 'data' / 'synthetic_demo.csv'
    output.parent.mkdir(exist_ok=True)
    rows = generate_rows()
    with output.open('w', newline='') as stream:
        writer = csv.DictWriter(stream, fieldnames=rows[0])
        writer.writeheader()
        writer.writerows(rows)
    print(f'Generated {len(rows)} artificial rows: {output}')


if __name__ == '__main__':
    main()
