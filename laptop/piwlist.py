#!/usr/bin/env python

##
# piwlist.py -- parses output of iwlist scan into table
#
# usage      -- sudo iwlist wlan0 scan | piwlist.py [-n|--nopretty]
#
# notes      -- originally written in python v2.x
#
# written    -- 17 January, 2010 by Hugo Chargois
#
# revised    -- 5 July, 2011 by Egan McComb
##

import sys
import getopt

##
# Functions to parse the properties of each AP (cell).
# Each takes one argument, the text describing one cell.
# Each returns the requested property of that cell.
##

def get_name(cell):
	return matching_line(cell,"ESSID:")[1:-1]

def get_quality(cell):
	quality = matching_line(cell, "Quality=").split()[0].split('/')
	return str(round(float(quality[0]) / float(quality[1]) * 100)).rjust(3) + "%"

def get_channel(cell):
	return matching_line(cell,"Channel:")

def get_encryption(cell):
	enc = None
	if matching_line(cell,"Encryption key:") == "off":
		enc = "Open"
	else:
		for line in cell:
			matching = match(line,"IE:")
			if matching != None:
				wpa = match(matching,"IEEE 802.11i/WPA2 Version ")
				if wpa != None:
					enc = "WPA2"
				else:
					wpa = match(matching,"WPA Version ")
					if wpa != None:
						enc = "WPA"
		if enc == None:
			enc = "WEP"
	return enc

def get_address(cell):
	return matching_line(cell,"Address: ")

##
# Dictionary of rules to be applied to descriptions of each cell.
# Keys are the names of the columns in the table.
# Values are obtained in the functions defined above.
##

rules = {
	"Name":	get_name,
	"Quality":	get_quality,
	"Channel":	get_channel,
	"Encryption":	get_encryption,
	"Address":	get_address,
	}

##
# Criterion for sorting the table using key from the dictionary.
##

def sort_cells(cells):
	cells.sort(key=lambda el:el["Quality"], reverse=True)

##
# Column definitions using keys from the dictionary.
##

columns = ["Name","Address","Quality","Channel","Encryption"]

#########

##
# Matching functions. 
##

def matching_line(lines,keyword):
	# Returns first matching line in a list of lines. See match().
	for line in lines:
		matching = match(line,keyword)
		if matching != None:
			return matching
	return None

def match(line,keyword):
	# Returns end of line if beginning matches keyword; otherwise returns None.
	line = line.lstrip()
	length = len(keyword)
	if line[:length] == keyword:
		return line[length:]
	else:
		return None

##
# Parsing and printing functions.
##

def parse_cell(cell):
	# Applies rules to text describing cell and returns dictionary.
	parsed_cell = {}
	for key in rules:
		rule = rules[key]
		parsed_cell.update({key:rule(cell)})
	return parsed_cell

def print_table(table):
	widths = list(map(max,[list(map(len,l)) for  l in zip(*table)]))

	justified_table = []
	for line in table:
		justified_line = []
		for i, el in enumerate(line):
			justified_line.append(el.ljust(widths[i]+2))
		justified_table.append(justified_line)

	for line in justified_table:
		for el in line:
			print(el,end=" ")
		print()

def print_list(list):
	for line in list:
		for el in line:
			print(el,end="|")
		print()

def print_nopretty(cells):
	list = []
	for cell in cells:
		cell_properties = []
		for column in columns:
			cell_properties.append(cell[column])
		list.append(cell_properties)
	print_list(list)

def print_pretty(cells):
	table = [columns]
	for cell in cells:
		cell_properties = []
		for column in columns:
			cell_properties.append(cell[column])
		table.append(cell_properties)
	print_table(table)

#########

def main(argv):

	try:
		args, opts = getopt.getopt(argv,"n",["nopretty"])
		for opt in opts:
			if opt == "-n":
				def print_cells(cells): print_nopretty(cells)
			else:
				def print_cells(cells): print_pretty(cells)
	except getopt.error:
		print("Error: Invalid argument(s)",file=sys.stderr)
		print("Usage: piwlist [-n|--nopretty]",file=sys.stderr)
		sys.exit(3)

	cells = [[]]
	parsed_cells = []

	for line in sys.stdin:
		cell_line = match(line,"Cell ")
		if cell_line != None:
			cells.append([])
			line = cell_line[-27:]
		cells[-1].append(line.rstrip())

	cells = cells[1:]

	for cell in cells:
		parsed_cells.append(parse_cell(cell))

	sort_cells(parsed_cells)

	print_cells(parsed_cells)

#########

main(sys.argv)
