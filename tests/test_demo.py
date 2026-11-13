import importlib.util
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('demo', ROOT / 'scripts/generate_demo.py')
demo = importlib.util.module_from_spec(spec)
spec.loader.exec_module(demo)


class DemoTests(unittest.TestCase):
    def test_reproducible_and_labelled(self):
        rows = demo.generate_rows()
        self.assertEqual(rows, demo.generate_rows())
        self.assertNotEqual(rows, demo.generate_rows(seed=2))
        self.assertTrue(all(r['DATA_SOURCE'] == 'SYNTHETIC_NOT_ADNI' for r in rows))
        self.assertEqual(len(rows), 400)

    def test_analysis_scenarios_present(self):
        rows = demo.generate_rows()
        for col in ['TAU_SUVR', 'WMH_volume_mm3', 'AGE', 'PTGENDER', 'interval_months']:
            self.assertTrue(any(r[col] == '' for r in rows), col)
        for col in ['TAU_SUVR', 'WMH_volume_mm3']:
            self.assertTrue(any(r[col] == 0 for r in rows), col)
        self.assertEqual(sum(k.startswith('PEP') for k in rows[0]), 69)
        self.assertTrue(all(r['SUVR_GlobalSUVR'] != '' for r in rows))
        self.assertGreater(sum(all(v != '' for v in r.values()) and r['TAU_SUVR'] > 0
                               for r in rows), 100)


if __name__ == '__main__':
    unittest.main()
