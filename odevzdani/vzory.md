| Problém | Vzor | Řešení |
|---|---|---|
| Vypnuté zařízení nejde použít a každý stav má jinou spotřebu. | State | Každý stav (vypnuto, zapnuto, používá se) je vlastní třída a sám ví, co zařízení v daném stavu smí. |
| Každý člen smí používat jen některá zařízení. | Proxy | Osoba pracuje se zařízením přes `DeviceProxy`, který nejdřív zkontroluje, jestli na to má právo. |
| Systém potřebuje jednoduše ovládat celý dům. | Facade | `SmartHomeFacade` nabízí pár jednoduchých metod, např. vypni nedůležitá zařízení nebo zavři okna. |
| Kdo událost vyvolá, nemusí vědět, kdo ji vyřeší. | Observer | Událost se pošle do `EventManager` a ten ji předá tomu, kdo ji má obsloužit. |
| Událost má vyřešit ten, kdo zrovna může. | Chain of Responsibility | Obsluhovatelé jsou za sebou v řadě. Když první nemůže (např. máma není doma), pošle událost dalšímu. |
