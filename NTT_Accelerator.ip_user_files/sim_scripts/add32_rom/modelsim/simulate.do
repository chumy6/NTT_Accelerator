onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xil_defaultlib -L xpm -L blk_mem_gen_v8_4_2 -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.add32_rom xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {add32_rom.udo}

run -all

quit -force
