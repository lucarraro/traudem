# taudem_pitremove() works

    Code
      output <- taudem_pitremove(file.path(test_dir, "DEM.tif"))
    Output
      PitRemove version ..
      Input file blop.tif has projected coordinate system.
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

# taudem_pitremove() works without mpiexec

    Code
      output <- taudem_pitremove(file.path(test_dir, "DEM.tif"))
    Output
      PitRemove version ..
      Input file blop.tif has projected coordinate system.
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

# taudem_pitremove() works quietly

    Code
      output <- taudem_pitremove(file.path(test_dir, "DEM.tif"))

