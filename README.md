# Calibre4KLayout

This KLayout macro allows you to run Siemens Calibre from KLayout.

Currently, it targets the [IHP OpenPDK](https://github.com/IHP-GmbH/IHP-Open-PDK).

**Attention:** This macro requires access to the Calibre configuration files of the proprietary IHP SG13G2 PDK!

## Installation

Clone this repository into `~/.klayout/macros`.

## Usage

This macro will create a new submenu `SG13G2 PDK -> SG13G2 Calibre`.

### Configuration

First, you should run `SG13G2 Calibre Options`. This opens a configuration window. You should check that all environment variables are configured correctly. This is only the case if the proprietary IHP SG13G2 PDK is installed properly.

If you want to run the DRC, select the correct runset from the list.

For LVS and PEX, you need to provide the path to the source netlist.

You can select if the Calibre GUI should be shown before running DRC/LVS/PEX. Select this check box if you want to configure Calibre further.

After everything is configured, click OK.

### Design Rule Check (DRC)

Select `SG13G2 Calibre DRC Run`.

After the DRC is finished (and all Calibre windows have been closed) all DRC errors will be shown in KLayout's marker browser.

If the DRC results in a new layout file, its topcell will be added to the current layout.

### Layout versus Schematic (LVS)

Select `SG13G2 Calibre LVS Run`.

The result of the LVS can be checked directly in Calibre RVE (results viewer).

### Parasitic Extraction (PEX)

Select `SG13G2 Calibre PEX Run`.

The result of the PEX can be checked directly in Calibre RVE (results viewer).
