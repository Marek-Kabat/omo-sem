#!/usr/bin/env bash
# Sestaví diagramy (PlantUML -> SVG/PNG), PDF dokumentaci a ZIP k odevzdání.
# Požadavky: Java, Graphviz (dot), pandoc, Node.js s balíčkem playwright, zip.
set -euo pipefail
cd "$(dirname "$0")"

PLANTUML_JAR="${PLANTUML_JAR:-build/plantuml.jar}"
if [ ! -f "$PLANTUML_JAR" ]; then
  curl -sSL -o "$PLANTUML_JAR" \
    https://repo1.maven.org/maven2/net/sourceforge/plantuml/plantuml/1.2024.7/plantuml-1.2024.7.jar
fi

echo "== Diagramy"
python3 diagrams/gen_full.py
rm -rf diagrams/out
(cd diagrams && java -DPLANTUML_LIMIT_SIZE=20000 -jar "../$PLANTUML_JAR" -tsvg -o out ./*.puml \
              && java -DPLANTUML_LIMIT_SIZE=20000 -jar "../$PLANTUML_JAR" -tpng -o out ./*.puml)

echo "== HTML + PDF"
pandoc dokumentace.md -s --toc --toc-depth=2 --number-sections \
  --metadata title-prefix="" -c build/style.css -o build/dokumentace.html
# odkazy na obrázky a CSS v HTML jsou relativní k adresáři docs/
mv build/dokumentace.html ./dokumentace.html
sed -i 's#href="build/style.css"#href="build/style.css"#' dokumentace.html
NODE_PATH="${NODE_PATH:-$(npm root -g)}" node build/to-pdf.js dokumentace.html SmartHome_navrh.pdf
rm dokumentace.html

echo "== ZIP"
rm -f SmartHome_navrh.zip
zip -qr SmartHome_navrh.zip SmartHome_navrh.pdf dokumentace.md README.md build.sh \
  diagrams/*.puml diagrams/*.iuml diagrams/gen_full.py diagrams/model diagrams/out config build/style.css build/to-pdf.js
echo "Hotovo: SmartHome_navrh.pdf, SmartHome_navrh.zip"
