VGA_Driver
==========

Introduction
============
The object of this lab was to write vhdl code to synchronize an FPGA with a VGA display.

Implementation
==============


Test/Debug
==========
After the plug in and pray method of testing my code didn't produce results I decided to write test benches 
for h_sync_gen and v_sync_gen. They were simple test benches that allowed continuous iteration of the active_video, 
front_porch,sync_pulse, back_porch, and completed states. This allowed me to check the length of each of the states 
and adjust their values in the code to make them perfect.

I ran into a problem with sensitivity lists. All of my code seemed to be correct and I wasn't leaving anything 
out but the screen would just flicker black. I figured it was something with h_sync and v_sync so I went through and cleaned 
them up. By cleaned them up I mean that I separated my convoluted state machine logic into two separate processes and made sure 
I had all correct flip-flops. I then added a lot of signals to the sensitivity lists of each process until
there was a pattern displayed on the screen.

Another problem I ran into was in trying to get the A functionality. I thought that the code was perfect but the
switched did not change anything. After some advice I added code to the user constraint file and that fixed the problem 
immediately.

I ran into many small syntactical problems that I really solved with brute force. I looked up things in the book
or on the internet or just read the console and tried things.

Conclusion
==========
From this lab I definitely took away how precise VGA synchronization has to be. It made me appreciate
the power and capability of the FPGA. It also showed me that with time and practice even I can learn VHDL 
it just takes time and patience. Next time I would probably finish the code for h_sync_gen and v_sync_gen as
part of the pre lab because those were the crux of this lab and the major time consumers.


Documentation
=============
C2C Michael Bentley, C2C John Miller, C2C Colin Busho, and C2C Ryan Good gave me advice 
on ways they solved the problems they encountered, mainly what to do with certain signals
when there are errors. John showed me that I had a problem with my board settings such that
the program would not map. Michael and John gave me advice on expanding my congested state machines.Ryan 
told me that I needed to write code in the constraints file to use the input switches.
All of this advice lead to my completion of the lab.
