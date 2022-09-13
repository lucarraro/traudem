# taudem_sitrem() works - problems

    x Can't find TauDEM on PATH nor `TAUDEM_PATH` environment variable
    i Register your TauDEM installation. See vignette('taudem-installation').

---

    x Can't find directory `/home/maelle/blop` (TauDEM executables)
    i Register your TauDEM installation. See vignette('taudem-installation').

---

    x Can't find executables for `aread8`, `areadinf`, `CatchHydroGeo`, `CatchOutlets`, `ConnectDown`, `D8FlowDir`, `D8FlowPathExtremeUp`, `D8HDistToStrm`, `DinfAvalanche`, `DinfConcLimAccum`, `DinfDecayAccum`, `DinfDistDown`, `DinfDistUp`, `DinfFlowDir`, `DinfRevAccum`, `DinfTransLimAccum`, `DinfUpDependence`, `DropAnalysis`, `EditRaster`, `FlowdirCond`, `gagewatershed`, `gridnet`, `LengthArea`, `MoveOutletsToStrm`, `PeukerDouglas`, `PitRemove`, `RetLimFlow`, `SetRegion`, `SinmapSI`, `SlopeArea`, `SlopeAreaRatio`, `SlopeAveDown`, `streamnet`, `Threshold`, `TWI`
    i Try re-installing TauDEM and write down any problem.

# taudem_sitrem() works - all well

    Code
      taudem_sitrep()
    Message <cliMessage>
      v Found GDAL version ...
      v Found mpiexec (OpenRTE) .. (MPI).
      v Found `TAUDEM_PATH` environment variable (/usr/local/taudem).
      v Found TauDEM executables directory (/usr/local/taudem).
      v Found all TauDEM executables.
      i Testing TauDEM on an example file...
      -- TauDEM output ---------------------------------------------------------------
    Output
      PitRemove version ..
      Input file MED__.tif has projected coordinate system.
      Nodata value input to create partition from file: -.
      Nodata value recast to float used in partition raster: -.
      Processes: 
      Header read time: .
      Data read time: .
      Compute time: .
      Write time: .
      Total time: .
    Message <cliMessage>
      -- End of TauDEM output --------------------------------------------------------
      v Was able to launch a TauDEM example!
      ! Make sure you see no serious error message above.

