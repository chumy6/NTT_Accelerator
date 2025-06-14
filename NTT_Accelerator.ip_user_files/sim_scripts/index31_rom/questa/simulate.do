onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib index31_rom_opt

do {wave.do}

view wave
view structure
view signals

do {index31_rom.udo}

run -all

quit -force
