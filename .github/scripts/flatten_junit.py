#!/usr/bin/env python3
"""Flatten nested Robot Framework JUnit XML for CI tools that only read direct testcases."""

from __future__ import annotations

import copy
import sys
import xml.etree.ElementTree as ET


def _collect_testcases(element: ET.Element, testcases: list[ET.Element]) -> None:
    for child in element:
        if child.tag == "testcase":
            testcases.append(copy.deepcopy(child))
        elif child.tag == "testsuite":
            _collect_testcases(child, testcases)


def flatten(input_path: str, output_path: str) -> int:
    root = ET.parse(input_path).getroot()

    testcases: list[ET.Element] = []
    _collect_testcases(root, testcases)

    failures = int(root.get("failures", 0))
    errors = int(root.get("errors", 0))
    skipped = int(root.get("skipped", 0))
    total_time = float(root.get("time", 0))

    testsuites = ET.Element("testsuites")
    testsuites.set("tests", str(len(testcases)))
    testsuites.set("failures", str(failures))
    testsuites.set("errors", str(errors))
    testsuites.set("skipped", str(skipped))
    testsuites.set("time", str(total_time))

    suite = ET.SubElement(testsuites, "testsuite")
    suite.set("name", root.get("name", "Robot Framework Tests"))
    suite.set("tests", str(len(testcases)))
    suite.set("failures", str(failures))
    suite.set("errors", str(errors))
    suite.set("skipped", str(skipped))
    suite.set("time", str(total_time))

    for testcase in testcases:
        suite.append(testcase)

    ET.ElementTree(testsuites).write(
        output_path,
        encoding="UTF-8",
        xml_declaration=True,
    )
    return len(testcases)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: flatten_junit.py <input.xml> <output.xml>", file=sys.stderr)
        sys.exit(1)

    count = flatten(sys.argv[1], sys.argv[2])
    print(f"Flattened {count} test cases to {sys.argv[2]}")
