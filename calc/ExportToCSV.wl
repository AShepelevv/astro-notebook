(* ::Package:: *)

BeginPackage["ExportToCSV`"]	

	DataFileName::usage = "DataFileName[filename]"
	TableWithTitle::usage = "TableWithTitle[table, title]"
	ExportToCSV::usage = "ExportToCSV[table, filepath]"
	SetTablePrecision::usage = "SetTablePrecision[precision]"

	Begin[ "Private`"]

		DataFileName[x_] := FileNameJoin[{NotebookDirectory[],"..","data",x}]
		TableWithTitle[table_, title_]:= Join[{title}, table]
		ExportToCSV[table_, filepath_]:= Export[filepath, table, "CSV", "TextDelimiters"->""]
		SetTablePrecision[table_, precision_]:=table /. x_Real :> SetPrecision[N[x,10], precision]
	End[]
EndPackage[]



