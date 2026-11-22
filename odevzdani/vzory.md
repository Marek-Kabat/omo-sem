| Problém | Vzor | Řešení |
|---|---|---|
| V simulaci má existovat jen jeden dům, čas a správce událostí, dostupné odkudkoli. | Singleton | `Simulation` – jediná instance přes `getInstance()`. |
| Konfigurace domu se načítá z JSON i přímo z Java třídy. | Strategy | `HouseConfigLoader` s implementacemi `JsonConfigLoader` a `JavaConfigLoader`. |
| Dům je složitý objekt (patra, místnosti, okna, zařízení, osoby) a musí se sestavit konzistentně. | Builder | `HouseBuilder` sestavuje dům krok po kroku, `build()` vrátí hotový `House`. |
| Zařízení se vytvářejí podle typu z konfigurace, klient nemá znát konkrétní třídy. | Factory | `DeviceFactory.create(DeviceType)`. |
| Chování zařízení závisí na stavu (vypnuté nelze používat) a podle stavu se mění spotřeba. | State | `DeviceState` se stavy `OffState`, `OnState`, `InUseState`; zařízení deleguje operace na aktuální stav. |
| Každý člen smí používat jen některá zařízení; kontrola nemá být rozesetá po všech zařízeních. | Proxy | `DeviceProxy` ověří oprávnění osoby a teprve pak volá zařízení. |
| Systém potřebuje jednoduše ovládat celý dům (vypnout nedůležitá zařízení, zavřít okna, zjistit spotřebu). | Facade | `SmartHomeFacade` skrývá procházení domu za jednoduché metody. |
| Události vznikají v zařízeních i u osob a zdroj nemá znát, kdo je obslouží. | Observer | `EventManager` přijímá události (`publish`) a předává je obsluze; zároveň vede historii pro `EventReport`. |
| Událost má obsloužit vhodná osoba nebo systém, případně postupně víc aktérů. | Chain of Responsibility | `EventHandler` s odkazem `next`; `PersonHandler` a `SystemHandler` událost buď obslouží, nebo pošlou dál. |
| Hierarchie dům → patro → místnost → okno se musí jednotně procházet (konfigurační report). | Composite | Dům, patra a místnosti obsahují své prvky a report je prochází rekurzivně. |
