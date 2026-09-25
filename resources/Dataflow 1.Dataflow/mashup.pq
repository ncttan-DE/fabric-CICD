[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Replace"], DestinationTypeSettings = [Kind = "Table"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
shared DefaultDestination = Lakehouse.Contents([EnableFolding = false]){[workspaceId = "e9670cc2-b4dc-4fee-bf5d-a73f1836e4d6"]}[Data]{[lakehouseId = "958eb854-450e-4487-b766-6e750a9178bd"]}[Data];
[BindToDefaultDestination = true]
shared #"customer_master csv" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "e9670cc2-b4dc-4fee-bf5d-a73f1836e4d6"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "958eb854-450e-4487-b766-6e750a9178bd"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Name = "customer_master.csv"]}[Content],
  #"Imported CSV" = Csv.Document(#"Navigation 3", [Delimiter = ",", Columns = 11, Encoding = 65001, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(#"Imported CSV", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"customer_id", type text}, {"customer_name", type text}, {"customer_age", Int64.Type}, {"gender", type text}, {"customer_segment", type text}, {"customer_city", type text}, {"customer_state", type text}, {"customer_country", type text}, {"region", type text}, {"customer_postal_code", Int64.Type}, {"customer_acquisition_cost", type number}})
in
  #"Changed column type";
