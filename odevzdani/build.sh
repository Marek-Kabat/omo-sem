#!/usr/bin/env bash
# Vygeneruje diagram (PlantUML), PDF a ZIP k odevzdání.
set -euo pipefail
cd "$(dirname "$0")"
JAR="${PLANTUML_JAR:-../docs/build/plantuml.jar}"
(cd diagram && java -DPLANTUML_LIMIT_SIZE=20000 -jar "../$JAR" -tsvg class-diagram.puml \
            && java -DPLANTUML_LIMIT_SIZE=20000 -jar "../$JAR" -tpng class-diagram.puml)
pandoc odevzdani.md -s -c style.css -o odevzdani.html
NODE_PATH="${NODE_PATH:-$(npm root -g)}" node ../docs/build/to-pdf.js odevzdani.html SmartHome_navrh.pdf
rm odevzdani.html
rm -f SmartHome_navrh.zip
zip -q SmartHome_navrh.zip SmartHome_navrh.pdf popis_funkcionalit.txt vzory.md \
  diagram/class-diagram.puml diagram/class-diagram.svg diagram/class-diagram.png
echo "Hotovo: SmartHome_navrh.pdf, SmartHome_navrh.zip"
