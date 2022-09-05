# taudem_sitrem() works - problems

    x Can't find `TAUDEM_PATH` environment variable
    i Add `TAUDEM_PATH` environment variable pointing to TauDEM executables. See `?taudem_sitrep`

---

    x Can't find directory `blop` (TauDEM executables)
    i Fix `TAUDEM_PATH` environment variable pointing to TauDEM executables. See `?taudem_sitrep`

---

    x Can't find executables for `aread8`, `areadinf`, `CatchHydroGeo`, `CatchOutlets`, `ConnectDown`, `D8FlowDir`, `D8FlowPathExtremeUp`, `D8HDistToStrm`, `DinfAvalanche`, `DinfConcLimAccum`, `DinfDecayAccum`, `DinfDistDown`, `DinfDistUp`, `DinfFlowDir`, `DinfRevAccum`, `DinfTransLimAccum`, `DinfUpDependence`, `DropAnalysis`, `EditRaster`, `FlowdirCond`, `gagewatershed`, `gridnet`, `LengthArea`, `MoveOutletsToStrm`, `PeukerDouglas`, `PitRemove`, `RetLimFlow`, `SetRegion`, `SinmapSI`, `SlopeArea`, `SlopeAreaRatio`, `SlopeAveDown`, `streamnet`, `Threshold`, `TWI`
    i Try re-installing TauDEM and write down any problem.

# taudem_sitrem() works - all well

    Code
      taudem_sitrep()
    Message <cliMessage>
      v Found `TAUDEM_PATH` environment variable (/usr/local/taudem).
      v Found TauDEM executables directory (/usr/local/taudem).
      v Found all TauDEM executables.

