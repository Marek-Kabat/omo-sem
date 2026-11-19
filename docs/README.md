# Smart Home – návrh (OMO)

Odevzdání fáze návrhu semestrální práce.

| Soubor / adresář | Obsah |
|---|---|
| `SmartHome_navrh.pdf` | Kompletní dokumentace: class diagramy, funkční a nefunkční požadavky, uživatelské scénáře, problémy návrhu a návrhové vzory |
| `dokumentace.md` | Zdrojový text dokumentace (Markdown → PDF) |
| `diagrams/*.puml` | Zdrojové soubory diagramů (PlantUML) |
| `diagrams/model/*.iuml` | Definice tříd po balíčcích (sdílené dílčími i celkovým diagramem) |
| `diagrams/out/` | Vyrenderované diagramy (SVG – vektorové, PNG) |
| `config/house-config.json` | Připravená konfigurace domu |
| `diagrams/gen_full.py` | Generuje celkové diagramy 09 a 10 z `model/*.iuml` |
| `build.sh` | Skript, který znovu vygeneruje diagramy, PDF a ZIP |

## Přehled diagramů

| Soubor | Diagram |
|---|---|
| `00-packages` | Balíčky a závislosti |
| `01-house` | Struktura domu (Composite, Builder, Visitor) |
| `02-devices`, `02b-device-types` | Zařízení – jádro modelu, konkrétní typy |
| `03-device-state` | Stavy zařízení (State), senzory |
| `04-inhabitants` | Obyvatelé, oprávnění, aktivity, sport |
| `05-events` | Události (Observer, Chain of Responsibility) |
| `06-api` | API zařízení (Command, Proxy, Facade) |
| `07-reports` | Reporty (Template Method, Visitor) |
| `08-config-simulation` | Konfigurace, simulace, nákupy |
| `09-data-model` | **Celý datový model** (atributy a vazby) |
| `10-class-diagram-full` | **Celý class diagram** včetně metod |
| `11-state-device` | Stavový diagram zařízení |
| `12`–`15` | Sekvenční diagramy (tick, použití zařízení, prasklá trubka, oprava) |
| `16-usecase` | Případy užití |

## Sestavení

Je potřeba Java, Graphviz, pandoc, Node.js s Playwrightem (Chromium) a `zip`.

```bash
./build.sh
```
