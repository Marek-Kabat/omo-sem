#!/usr/bin/env python3
"""Vygeneruje celkové diagramy 09-data-model.puml a 10-class-diagram-full.puml.

Definice tříd se berou z model/*.iuml (stejné jako u dílčích diagramů), ale rámečky
balíčků se odstraní a balíčky se rozliší barvou. Bez rámečků dokáže Graphviz rozložit
~140 tříd do přibližně čtvercové plochy (s rámečky vzniká pás v poměru 7 : 1).
"""
import re
from pathlib import Path

HERE = Path(__file__).resolve().parent
PACKAGES = [  # (soubor, název balíčku, barva)
    ("simulation", "simulation", "#FDE2E4"),
    ("config", "config", "#E2ECE9"),
    ("house", "house", "#DDEBF7"),
    ("device", "device", "#FFF1C1"),
    ("device-types", "device (typy zařízení)", "#FFF8DC"),
    ("device-state", "device.state", "#FCE3C4"),
    ("sensor", "device.sensor", "#F8D9A8"),
    ("inhabitant", "inhabitant", "#E4DFF5"),
    ("activity", "activity", "#EFE6F9"),
    ("sport", "sport", "#D9F2E6"),
    ("event", "event", "#FAD4D8"),
    ("api", "api", "#D6EEF2"),
    ("report", "report", "#E9F0D7"),
    ("shop", "shop", "#EDE7E1"),
]
DECL = re.compile(
    r'^(\s*(?:abstract class|class|interface|enum)\s+(?:"[^"]+"\s+as\s+)?[\w.]+(?:\s*<<[^>]+>>)?)(\s*\{?\s*)$'
)


def colored(name: str, color: str) -> str:
    text = (HERE / "model" / f"{name}.iuml").read_text(encoding="utf-8")
    text = re.sub(r'^package "[^"]+" \{\n', "", text, flags=re.M)
    text = re.sub(r"\n\}\s*$", "\n", text)
    out = []
    for line in text.splitlines():
        m = DECL.match(line)
        out.append(f"{m.group(1)} {color}{m.group(2)}" if m else line)
    return "\n".join(out)


def build(file: str, title: str, hide_methods: bool) -> None:
    legend = "\n".join(f"|<{c}>   | {label} |" for _, label, c in PACKAGES)
    parts = [
        f"@startuml {file}",
        "!include common.iuml",
        "skinparam linetype polyline",
        "skinparam nodesep 25",
        "skinparam ranksep 60",
        "left to right direction",
        "hide methods" if hide_methods else "",
        f"title {title}",
        "' VYGENEROVÁNO skriptem gen_full.py – needitovat ručně",
    ]
    parts += [colored(n, c) for n, _, c in PACKAGES]
    parts.append((HERE / "model" / "relations.iuml").read_text(encoding="utf-8"))
    parts += ["legend top left", "|= Barva |= Balíček |", legend, "endlegend", "@enduml", ""]
    (HERE / f"{file}.puml").write_text("\n".join(parts), encoding="utf-8")


build("09-data-model", "Smart Home – datový model (atributy a vazby, bez metod)", True)
build("10-class-diagram-full", "Smart Home – kompletní class diagram (vč. metod)", False)
