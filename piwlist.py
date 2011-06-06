#!/usr/bin/env python2

##
# piwlist.py -- parses output of iwlist scan into table
#
# version -- 0.1
#
# usage -- sudo iwlist wlan0 scan | piwlist.py 
#
# written -- 17 January, 2010 by Hugo Chargois 
#
# revised -- 5 July, 2010 by Egan McComb
##

import sys

##
# Functions to parse the properties of each AP (cell).
# Each takes one argument, the text describing one cell.
# Each returns the requested property of that cell.
##

def get_name(cell):
	return matching_line(cell,"ESSID:")[1:-1]

def get_quality(cell):
	quality = matching_line(cell,"Quality=").split()[0].split('/')
	return str(int(round(float(quality[0]) / float(quality[1]) * 100))).rjust(3) + " %"

def get_channel(cell):
	return matching_line(cell,"Channel:")

def get_encryption(cell):
	enc=""
	if matching_line(cell,"Encryption key:") == "off":
		enc="Open"
	else:
		for line in cell:
			matching = match(line,"IE:")
			if matching!=None:
				wpa=match(matching,"WPA Version ")
				if wpa!=None:
					enc="WPA v."+wpa
		if enc=="":
			enc="WEP"
	return enc

def get_address(cell):
	return matching_line(cell,"Address: ")

##
# Dictionary of rules to be applied to descriptions of each cell.
# Keys are the names of the columns in the table.
# Values are obtained in the functions defined above.
##

rules={ "Name":get_name,
	"Quality":get_quality,
	"Channel":get_channel,
	"Encryption":get_encryption,
	"Address":get_address,
	}

##
# Criterion for sorting the table using key from the dictionary.
##

def sort_cells(cells):
	sortby = "Quality"
	reverse = True
	cells.sort(None, lambda el:el[sortby], reverse)

##
# Column definitions using keys using keys from the dictionary.
##

columns=["Name","Address","Quality","Channel","Encryption"]

#########

##
# Text hacking.
##

def matching_line(lines, keyword):
	# Returns first matching line in a list of lines. See match():
	for line in lines:
		matching=match(line,keyword)
		if matching!=None:
			return matching
	return None

def match(line,keyword):
	# Returns end of line if beginning matches keyword; otherwise return None:
	line=line.lstrip()
	length=len(keyword)
	if line[:length] == keyword:
		return line[length:]
	else:
		return None

def parse_cell(cell):
	# Applies rules to text describing cell and returns dictionary:
	parsed_cell={}
	for key in rules:
		rule=rules[key]
		parsed_cell.update({key:rule(cell)})
	return parsed_cell

def print_table(table):
	widths=map(max,map(lambda l:map(len,l),zip(*table))) #functional magic

	justified_table=[]
	for line in table:
		justified_line=[]
		for i,el in enumerate(line):
			justified_line.append(el.ljust(widths[i]+2))
		justified_table.append(justified_line)

	for line in justified_table:
		for el in line:
			print el,
		print

def print_cells(cells):
	table=[columns]
	for cell in cells:
		cell_properties=[]
		for column in columns:
			cell_properties.append(cell[column])
		table.append(cell_properties)
	print_table(table)

def main():
	# Pretty prints stdin (iwlist scan) into a table:
	cells=[[]]
	parsed_cells=[]

	for line in sys.stdin:
		cell_line = match(line,"Cell ")
		if cell_line != None:
			cells.append([])
			line = cell_line[-27:]
		cells[-1].append(line.rstrip())

	cells=cells[1:]

	for cell in cells:
		parsed_cells.append(parse_cell(cell))

	sort_cells(parsed_cells)

	print_cells(parsed_cells)

#########

main()
