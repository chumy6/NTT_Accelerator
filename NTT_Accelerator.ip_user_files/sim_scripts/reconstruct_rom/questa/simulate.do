onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib reconstruct_rom_opt

do {wave.do}

view wave
view structure
view signals

do {reconstruct_rom.udo}

run -all

quit -force
