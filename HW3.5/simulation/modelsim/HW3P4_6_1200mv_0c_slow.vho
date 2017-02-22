-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 32-bit"
-- VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"

-- DATE "02/18/2015 00:50:10"

-- 
-- Device: Altera EP4CE22F17C6 Package FBGA256
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	HW3P4 IS
    PORT (
	F1 : OUT std_logic;
	D : IN std_logic;
	B : IN std_logic;
	C : IN std_logic;
	A : IN std_logic;
	F2 : OUT std_logic
	);
END HW3P4;

-- Design Ports Information
-- F1	=>  Location: PIN_L1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- F2	=>  Location: PIN_B5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A	=>  Location: PIN_F1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B	=>  Location: PIN_J1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- D	=>  Location: PIN_G2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- C	=>  Location: PIN_F2,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF HW3P4 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_F1 : std_logic;
SIGNAL ww_D : std_logic;
SIGNAL ww_B : std_logic;
SIGNAL ww_C : std_logic;
SIGNAL ww_A : std_logic;
SIGNAL ww_F2 : std_logic;
SIGNAL \F1~output_o\ : std_logic;
SIGNAL \F2~output_o\ : std_logic;
SIGNAL \D~input_o\ : std_logic;
SIGNAL \A~input_o\ : std_logic;
SIGNAL \B~input_o\ : std_logic;
SIGNAL \C~input_o\ : std_logic;
SIGNAL \inst4~0_combout\ : std_logic;

BEGIN

F1 <= ww_F1;
ww_D <= D;
ww_B <= B;
ww_C <= C;
ww_A <= A;
F2 <= ww_F2;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOOBUF_X0_Y11_N9
\F1~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst4~0_combout\,
	devoe => ww_devoe,
	o => \F1~output_o\);

-- Location: IOOBUF_X11_Y34_N2
\F2~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \F2~output_o\);

-- Location: IOIBUF_X0_Y23_N15
\D~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_D,
	o => \D~input_o\);

-- Location: IOIBUF_X0_Y23_N1
\A~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A,
	o => \A~input_o\);

-- Location: IOIBUF_X0_Y15_N8
\B~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B,
	o => \B~input_o\);

-- Location: IOIBUF_X0_Y24_N22
\C~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_C,
	o => \C~input_o\);

-- Location: LCCOMB_X1_Y22_N16
\inst4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst4~0_combout\ = (\B~input_o\ & (((\A~input_o\) # (!\C~input_o\)))) # (!\B~input_o\ & (((\A~input_o\ & \C~input_o\)) # (!\D~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110111110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \D~input_o\,
	datab => \A~input_o\,
	datac => \B~input_o\,
	datad => \C~input_o\,
	combout => \inst4~0_combout\);

ww_F1 <= \F1~output_o\;

ww_F2 <= \F2~output_o\;
END structure;

