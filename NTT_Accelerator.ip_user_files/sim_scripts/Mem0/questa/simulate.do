onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Mem0_opt

do {wave.do}

view wave
view structure
view signals

do {Mem0.udo}

run -all

quit -force
