# info

    Code
      Sys.getenv("PATH")
    Output
      [1] "/usr/local/taudem:/home/maelle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin:/usr/lib/rstudio/bin/rpostback:/usr/lib/rstudio/bin/postback:/home/maelle/Documents/quarto-cli/package/dist/bin:/usr/lib/rstudio/bin/postback"

# taudem_sitrep() works - problems

    x Can't find TauDEM on PATH nor `TAUDEM_PATH` environment variable
    i Register your TauDEM installation. See vignette('taudem-installation').

---

    x Can't find directory `blop` (TauDEM executables)
    i Register your TauDEM installation. See vignette('taudem-installation').

---

    x Can't find executables for `aread8`, `areadinf`, `CatchHydroGeo`, `CatchOutlets`, `ConnectDown`, `D8FlowDir`, `D8FlowPathExtremeUp`, `D8HDistToStrm`, `DinfAvalanche`, `DinfConcLimAccum`, `DinfDecayAccum`, `DinfDistDown`, `DinfDistUp`, `DinfFlowDir`, `DinfRevAccum`, `DinfTransLimAccum`, `DinfUpDependence`, `DropAnalysis`, `EditRaster`, `FlowdirCond`, `gagewatershed`, `gridnet`, `LengthArea`, `MoveOutletsToStrm`, `PeukerDouglas`, `PitRemove`, `RetLimFlow`, `SetRegion`, `SinmapSI`, `SlopeArea`, `SlopeAreaRatio`, `SlopeAveDown`, `streamnet`, `Threshold`, `TWI`
    i Try re-installing TauDEM and write down any problem.

# taudem_sitrep() works - all well

    Code
      taudem_sitrep()
    Message <cliMessage>
      v Found GDAL version ...
      v Found MPI (MPI).
      v Found TauDEM path
      v Found TauDEM executables directory.
      v Found all TauDEM executables.
      i Testing TauDEM on an example file (please wait a bit)...
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
      This run may take on the order of  minutes to complete.
      This estimate is very approximate. 
      Run time is highly uncertain as it depends on the complexity of the input data 
      and speed and memory of the computer. This estimate is based on our testing on 
      a dual quad core Dell Xeon E .GHz PC with GB RAM.
    Message <cliMessage>
      -- End of TauDEM output --------------------------------------------------------
      v Was able to launch a TauDEM example!
      ! Make sure you see no serious error message above.

