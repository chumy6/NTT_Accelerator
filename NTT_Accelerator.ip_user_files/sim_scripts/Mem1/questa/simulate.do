onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Mem1_opt

do {wave.do}

view wave
view structure
view signals

do {Mem1.udo}

run -all

quit -force
