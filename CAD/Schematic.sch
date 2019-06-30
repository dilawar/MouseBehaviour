EESchema Schematic File Version 4
LIBS:Schematic-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 3
Title "Shocking Protocol"
Date ""
Rev "0.0.1"
Comp "Bhalla Lab"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_Module:Arduino_UNO_R3 ArduinoUno
U 1 1 5D1837FC
P 6800 3200
F 0 "ArduinoUno" H 6800 4381 50  0000 C CNB
F 1 "Arduino_UNO_R3" H 6800 4290 50  0000 C CNN
F 2 "Module:Arduino_UNO_R3" H 6950 2150 50  0001 L CNN
F 3 "https://www.arduino.cc/en/Main/arduinoBoardUno" H 6600 4250 50  0001 C CNN
	1    6800 3200
	1    0    0    -1  
$EndComp
$Comp
L Schematic-rescue:RotaryEncoder-OrangeRotaryEncoder RotaryEncoder?
U 1 1 5D191567
P 4650 2700
F 0 "RotaryEncoder?" H 4650 2700 50  0001 C CNN
F 1 "RotaryEncoder" H 5368 2700 0   0000 L CNN
F 2 "" H 4450 2850 50  0001 C CNN
F 3 "https://robu.in/wp-content/uploads/2016/02/User-Manual-Orange-3806-OPTI-400-AB-OC-Rotary-Encoder-ROBU.IN_.pdf" H 4450 2850 50  0001 C CNN
	1    4650 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 2500 5900 2500
Wire Wire Line
	5900 2500 5900 2800
Wire Wire Line
	5900 2800 6300 2800
Wire Wire Line
	5000 2600 5800 2600
Wire Wire Line
	5800 2600 5800 2900
Wire Wire Line
	5800 2900 6300 2900
$Comp
L Device:Speaker LS?
U 1 1 5D18ABCB
P 8825 2400
F 0 "LS?" H 8995 2396 50  0000 L CNN
F 1 "Speaker" H 8995 2305 50  0000 L CNN
F 2 "" H 8825 2200 50  0001 C CNN
F 3 "~" H 8815 2350 50  0001 C CNN
	1    8825 2400
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D?
U 1 1 5D18B2CE
P 8775 2950
F 0 "D?" H 8768 2695 50  0000 C CNN
F 1 "LED" H 8768 2786 50  0000 C CNN
F 2 "" H 8775 2950 50  0001 C CNN
F 3 "~" H 8775 2950 50  0001 C CNN
	1    8775 2950
	-1   0    0    1   
$EndComp
$Comp
L Isolator:4N35 U?
U 1 1 5D188B23
P 8925 3425
F 0 "U?" H 8925 3750 50  0000 C CNN
F 1 "4N35" H 8925 3659 50  0000 C CNN
F 2 "Package_DIP:DIP-6_W7.62mm" H 8725 3225 50  0001 L CIN
F 3 "https://www.vishay.com/docs/81181/4n35.pdf" H 8925 3425 50  0001 L CNN
	1    8925 3425
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5D189E2E
P 8500 3300
F 0 "#PWR?" H 8500 3050 50  0001 C CNN
F 1 "GND" H 8505 3127 50  0000 C CNN
F 2 "" H 8500 3300 50  0001 C CNN
F 3 "" H 8500 3300 50  0001 C CNN
	1    8500 3300
	-1   0    0    1   
$EndComp
Wire Wire Line
	8625 3325 8500 3325
Wire Wire Line
	8500 3325 8500 3300
Text GLabel 5975 3400 0    50   Input ~ 0
TONE
Wire Wire Line
	5975 3400 6300 3400
Text GLabel 5975 3500 0    50   Input ~ 0
LED
Wire Wire Line
	5975 3500 6300 3500
Text GLabel 5975 3600 0    50   Input ~ 0
CAM
Wire Wire Line
	5975 3600 6300 3600
Text GLabel 5975 3700 0    50   Input ~ 0
PUFF
Wire Wire Line
	5975 3700 6300 3700
Text GLabel 5975 3900 0    50   Input ~ 0
IMAGING_TRIG
Wire Wire Line
	5975 3900 6300 3900
Text GLabel 8475 2400 0    50   Input ~ 0
TONE
Wire Wire Line
	8475 2400 8625 2400
Text GLabel 8475 2950 0    50   Input ~ 0
LED
Wire Wire Line
	8475 2950 8625 2950
Text GLabel 8475 3525 0    50   Input ~ 0
PUFF
Wire Wire Line
	8475 3525 8625 3525
$Comp
L power:GND #PWR?
U 1 1 5D18C223
P 9325 3025
F 0 "#PWR?" H 9325 2775 50  0001 C CNN
F 1 "GND" H 9330 2852 50  0000 C CNN
F 2 "" H 9325 3025 50  0001 C CNN
F 3 "" H 9325 3025 50  0001 C CNN
	1    9325 3025
	1    0    0    -1  
$EndComp
Wire Wire Line
	8925 2950 9325 2950
Wire Wire Line
	9325 2950 9325 3025
$Comp
L power:GND #PWR?
U 1 1 5D18CB7D
P 8550 2650
F 0 "#PWR?" H 8550 2400 50  0001 C CNN
F 1 "GND" H 8555 2477 50  0000 C CNN
F 2 "" H 8550 2650 50  0001 C CNN
F 3 "" H 8550 2650 50  0001 C CNN
	1    8550 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	8625 2500 8550 2500
Wire Wire Line
	8550 2500 8550 2650
Text Notes 9300 3725 1    50   ~ 10
To solenoid.
Text Notes 4250 2425 0    50   ~ 0
1200 counts per cycle.
$Comp
L power:GND #PWR?
U 1 1 5D18F1BB
P 5300 3000
F 0 "#PWR?" H 5300 2750 50  0001 C CNN
F 1 "GND" H 5305 2827 50  0000 C CNN
F 2 "" H 5300 3000 50  0001 C CNN
F 3 "" H 5300 3000 50  0001 C CNN
	1    5300 3000
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5D18F987
P 5375 2825
F 0 "#PWR?" H 5375 2675 50  0001 C CNN
F 1 "VCC" H 5392 2998 50  0000 C CNN
F 2 "" H 5375 2825 50  0001 C CNN
F 3 "" H 5375 2825 50  0001 C CNN
	1    5375 2825
	1    0    0    -1  
$EndComp
Wire Wire Line
	5375 2750 5375 2700
Wire Wire Line
	5375 2700 5000 2700
Wire Wire Line
	5000 2800 5300 2800
Wire Wire Line
	5300 2800 5300 3000
Text Notes 5300 6050 0    50   ~ 0
CH1=CH3 \nCH2=CH4=~CH1\nImplemented in Arduino.
Wire Wire Line
	5475 3000 5475 3575
Wire Wire Line
	5475 3575 5050 3575
Wire Wire Line
	5050 3575 5050 5300
Wire Wire Line
	5475 3000 6300 3000
Wire Wire Line
	5550 3200 5550 3650
Wire Wire Line
	5550 3200 6300 3200
Wire Wire Line
	5400 3100 5400 4500
Wire Wire Line
	5400 4500 6525 4500
Wire Wire Line
	6525 4500 6525 4850
Wire Wire Line
	6525 4850 6425 4850
Wire Wire Line
	5400 3100 6300 3100
$Sheet
S 7600 4925 850  525 
U 5D191D2C
F0 "StimIsolator" 50
F1 "StimIsolator.sch" 50
F2 "INPUT" I L 7600 5025 50 
F3 "OUT+" O L 7600 5300 50 
F4 "OUT-" O L 7600 5400 50 
$EndSheet
Wire Wire Line
	6300 3300 6075 3300
Wire Wire Line
	6075 3300 6075 4425
Wire Wire Line
	7500 3500 7300 3500
$Comp
L Schematic-rescue:ShockPad-BhallaLabComponents ShockPad?
U 1 1 5D197A8E
P 9425 4025
F 0 "ShockPad?" H 9775 3875 50  0001 C CNN
F 1 "ShockPad" H 8657 3805 50  0000 C TNN
F 2 "" H 9775 3875 50  0001 C CNN
F 3 "" H 9775 3875 50  0001 C CNN
	1    9425 4025
	1    0    0    -1  
$EndComp
Text GLabel 8475 3875 0    50   Input ~ 0
PAD+
Text GLabel 8475 4225 0    50   Input ~ 0
PAD-
Wire Wire Line
	8475 3875 8975 3875
Wire Wire Line
	8475 4225 8975 4225
Text GLabel 6600 4975 2    50   Input ~ 0
PAD+
Wire Wire Line
	7200 4425 7200 5025
Wire Wire Line
	7200 5025 7600 5025
Wire Wire Line
	6075 4425 7200 4425
Wire Wire Line
	6925 5250 6925 4600
Wire Wire Line
	6925 4600 7500 4600
Wire Wire Line
	7500 4600 7500 3500
$Comp
L Device:R R2
U 1 1 5D1B22CC
P 7750 3675
F 0 "R2" H 7820 3721 50  0000 L CNN
F 1 "1M" H 7820 3630 50  0000 L CNN
F 2 "" V 7680 3675 50  0001 C CNN
F 3 "~" H 7750 3675 50  0001 C CNN
	1    7750 3675
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5D1B2935
P 7750 3900
F 0 "#PWR?" H 7750 3650 50  0001 C CNN
F 1 "GND" H 7755 3727 50  0000 C CNN
F 2 "" H 7750 3900 50  0001 C CNN
F 3 "" H 7750 3900 50  0001 C CNN
	1    7750 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	7750 3825 7750 3900
Wire Wire Line
	7750 3525 7750 3500
Wire Wire Line
	7750 3500 7500 3500
Connection ~ 7500 3500
Text Notes 5600 4500 2    50   ~ 0
PWM
Wire Wire Line
	5050 5300 5300 5300
Wire Wire Line
	5300 5475 4850 5475
Text GLabel 6600 5450 2    50   Input ~ 0
PAD-
$Sheet
S 5300 4750 1125 950 
U 5D1ADABF
F0 "SSR 4Channel" 50
F1 "SSR_4CH.sch" 50
F2 "DC+" I L 5300 4950 50 
F3 "DC-" I L 5300 5075 50 
F4 "CH1" I L 5300 5300 50 
F5 "CH2" I L 5300 5475 50 
F6 "A1" O R 6425 4850 50 
F7 "B1" O R 6425 4975 50 
F8 "B2" O R 6425 5450 50 
F9 "A2" O R 6425 5325 50 
$EndSheet
Wire Wire Line
	6425 5450 6600 5450
Wire Wire Line
	6425 4975 6600 4975
Wire Wire Line
	5550 3650 4850 3650
Wire Wire Line
	4850 3650 4850 5475
$EndSCHEMATC
