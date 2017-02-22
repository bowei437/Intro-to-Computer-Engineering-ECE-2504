####-----------------------------------------------------------------
#    dp3_debug: A test interface that connects to the probe/source
#    component in the base dp3 design.  To execute this script:
#       quartus_stp -t dp3_debug.tcl
#
#    Created 3/2013, P. Athanas, Virginia Tech
#
####-----------------------------------------------------------------

package require Tk

variable usbblaster_name
variable device_name

##### Start JTAG instance ## get handle for device and USB connection
####
####-----------------------------------------------------------------
foreach hardware_name [get_hardware_names] {
    if { [string match "USB-Blaster*" $hardware_name]} {
     set usbblaster_name $hardware_name
    }
}

set device_name [lindex [get_device_names -hardware_name $usbblaster_name] 0]

#start_insystem_source_probe -device_name $device_name -hardware_name $usbblaster_name


#end_insystem_source_probe

################################################
####initialize Front Panel
################################################

set pll_image [image create photo -file ./dp3.gif]
label .pll -image $pll_image

set r0   "xxxxxxxx"
set r1   "xxxxxxxx"
set r2   "xxxxxxxx"
set r3   "xxxxxxxx"
set r4   "xxxxxxxx"
set r5   "xxxxxxxx"
set ir   "xxxxxxxx"
set pc   "xxxxxxxx"

set r0txt   "Reg R0:     XXXXXXXXXXXXXXXX (XXXX hex)"
set r1txt   "Reg R1:     XXXXXXXXXXXXXXXX (XXXX hex)"
set r2txt   "Reg R2:     XXXXXXXXXXXXXXXX (XXXX hex)"
set r3txt   "Reg R3:     XXXXXXXXXXXXXXXX (XXXX hex)"
set r4txt   "Reg R4:     XXXXXXXXXXXXXXXX (XXXX hex)"
set r5txt   "Reg R5:     XXXXXXXXXXXXXXXX (XXXX hex)"
set irtxt   "Inst Reg:   XXXXXXXXXXXXXXXX (XXXX hex)"
set pctxt   "Prog Cntr:  XXXXXXXXXXXXXXXX (XXXX hex)"

label .r0lbl -textvariable r0txt -font "Courier"
label .r1lbl -textvariable r1txt -font "Courier"
label .r2lbl -textvariable r2txt -font "Courier"
label .r3lbl -textvariable r3txt -font "Courier"
label .r4lbl -textvariable r4txt -font "Courier"
label .r5lbl -textvariable r5txt -font "Courier"
label .irlbl -textvariable irtxt -font "Courier"
label .pclbl -textvariable pctxt -font "Courier"

button .byebye -text "QUIT" -command exit -padx 182 -relief raised -bg yellow

pack .pll
#
place .r0lbl -x 8m -y 8m
place .r1lbl -x 8m -y 16m
place .r2lbl -x 8m -y 24m
place .r3lbl -x 8m -y 32m
place .r4lbl -x 8m -y 40m
place .r5lbl -x 8m -y 48m
place .irlbl -x 8m -y 56m
place .pclbl -x 8m -y 64m
place .byebye -x 8m -y 72m

# Create wake-up thread variable
global gvar
set gvar 0

#----------------------------------------------------------------------
#
#----------------------------------------------------------------------

proc bin2hex bigbin {
   ## No sanity checking is done
    array set t {
         0000 0 0001 1 0010 2 0011 3 0100 4
         0101 5 0110 6 0111 7 1000 8 1001 9
         1010 a 1011 b 1100 c 1101 d 1110 e 1111 f
    }
    set hresult ""
    for {set i 0} {$i <= [string length $bigbin]} {set i [expr $i+4]} {
       set bin [string range $bigbin $i [expr $i+3]]
       set diff [expr {4-[string length $bin]%4}]
       if {$diff != 4} {
          set bin [format %0${diff}d$bin 0]
       }
       regsub -all .... $bin {$t(&)} hex
       append hresult $hex
    }
    return [subst $hresult]
}


#----------------------------------------------------------------------
#
#----------------------------------------------------------------------
proc monitor_start {} {

    global device_name usbblaster_name 
    global r0 r1 r2 r3 r4 r5 ir pc
    global r0txt r1txt r2txt r3txt r4txt r5txt irtxt pctxt

    start_insystem_source_probe -device_name $device_name -hardware_name $usbblaster_name
#    write_source_data -instance_index 0 -value $bwrite
    set response [read_probe_data -instance_index 0]
    set pc     [string range $response 16 31]
    set ir     [string range $response 32 47 ]
    set r5     [string range $response 48 63 ]
    set r4     [string range $response 64 79 ]
    set r3     [string range $response 80 95 ]
    set r2     [string range $response 96 111 ]
    set r1     [string range $response 112 127 ]
    set r0     [string range $response 128 143 ]

    set r0txt   "Reg R0:     $r0 ([bin2hex $r0] hex)"
    set r1txt   "Reg R1:     $r1 ([bin2hex $r1] hex)"
    set r2txt   "Reg R2:     $r2 ([bin2hex $r2] hex)"
    set r3txt   "Reg R3:     $r3 ([bin2hex $r3] hex)"
    set r4txt   "Reg R4:     $r4 ([bin2hex $r4] hex)"
    set r5txt   "Reg R5:     $r5 ([bin2hex $r5] hex)"
    set irtxt   "Inst Reg:   $ir ([bin2hex $ir] hex)"
    set pctxt   "Prog Cntr:  $pc ([bin2hex $pc] hex)"

    end_insystem_source_probe
}


#----------------------------------------------------------------------
#
#----------------------------------------------------------------------
proc int2bits {i} {
    
    set res ""
    while {$i>0} {
        set res [expr {$i%2}]$res
        set i [expr {$i/2}]
    }
    if {$res==""} {set res 0}
    return $res
}

while 1 {

    monitor_start
    after 500 incr gvar
    vwait gvar
}

