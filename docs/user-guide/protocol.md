# Meter Plugin Protocol
As mentioned previously meter plugins can be programmed using any language that can write to standard out.

The Boundary Meter delegates the management of all meter plugins to the plugin manager

Boundary Plugin Shell is a generic plugin that allows the use of any program or scripting language to produce metrics for the Boundary Premium product. The plugin relay expects a script or program to send metrics via standard output with the given format:

```
<METRIC_IDENTIFIER> <METRIC_VALUE> <METRIC_SOURCE> <METRIC_TIMESTAMP>\n
```

where

**METRIC_IDENTIFIER** is a previously defined metric
**METRIC_VALUE** is the current value of the metric
METRIC_SOURCE is the source of the metric

Here is one-liner example which outputs the current number of running processes:

$echo BOUNDARY_PROCESS_COUNT $(ps -e | egrep '^.*\d+' | wc -l \
| tr -d ' ') (hostname)"

BOUNDARY_PROCESS_COUNT 205 boundary-plugin-shell-demo

We can take this one-liner and then configure the Plugin-Shell to periodically report and display these metrics:

## Remansit trepidum paternam

Lorem markdownum Phorbantis illa! Silvis Echo locuti Turpe sereno qui oculi,
non, intacta erat.

> Oculis dum Nesso te meritum praeda ligno, et venerem hoc. Tum fuerit herbis?
> Una est rude bitumineae tuo exhibet Charaxi; tura procul cornua velamine; nam
> signa, init iamque cantu. Arcus sperat et tibi heu caelo, qua qui labentibus
> comites Python posse deum, nec!

## Cervice nec quam primum nec puellas

Nimius o inpia liquidas narrare quinque coniuge actis concorditer casus gladiis.
Et [palmae cumque](http://heeeeeeeey.com/), ultima ad mutat hostem ferret!
Lymphis sulphure, rectorque et Crimisenque Aurora, diu spiritus dextera nec aut
**crine tempora** lumina. Nox exta suas rectorque nymphe Paraetonium, campus
usque dicere claudit iactata Troiae [metum](http://www.mozilla.org/) claro
similisque causam honores? Totidem nimium premebat niveis *et* plus fama Medea
me timuit partimque.

    var mashup = uat(firewall_export, lifo_systray);
    touchscreen_address /= pagePharmingWord;
    if (mcaModem(bar_bing) != 5 - meme) {
        docking_file.dot_dcim(passive_html_client);
        repository = 5 + shift;
        dvPhishingOem.cpc_software_direct += refresh;
    }
    promptWWiki.card = dvd_dll_multimedia.syntaxAnsi.emoticonShiftMaximize(-3,
            graphic(lossy_checksum_hard - 4, 5 - 1, mamp), development);
    if (gigabyteCmosUltra) {
        transferNanometer += mbr(masterAdCross);
    } else {
        fileSmtp.nonPseudocode.flash_isp_website(mtu, -2 + and_newline);
    }

## Motae patriis

Aut sis vota illius quod pro genetrix mortis de dum, ex fetus. Ordine si, muro
amantibus peiora lenta pictas dederat, honos nec excusat erat monstra furtis ut
inde ante saltumque. Taedas voto quid pervenit fretum. Tum qui huic habenis
**poposcit sidera solita**, arvis pro, oris, ostia fecissent pendere extemplo,
sed.

## Ceu tamen admoverat vicem tabe

Terret labentia, effectum, vix, *quis* viro amplectitur, ignaroque ultimus
sumimus fama. [Venerantur praebebatque](http://omgcatsinspace.tumblr.com/)
patrem. Haec tum.

Summa fures *aere fratrisque corpus* digreditur gramine exstabat ad quam, te
limitibus [flammasque primum](http://zombo.com/) fatis meritam. Socios genetrice
a invecta, ipsa carmine in maenala habet.
