# vernier-ring-oscillator-tdc
Vernier Ring Oscillator Time to Digital Converter (Non synthesizable simulational VHDL model)

Resolution = slow clock T - fast clock T

START - STOP time difference = count x Resolution

File hierarchy 

--vernier_ring_tdc_top.vhd 
    |-- slow_oscillator.vhd
    |-- fast_oscillator.vhd
    |-- counter.vhd
    |-- coincidence_detector.vhd
