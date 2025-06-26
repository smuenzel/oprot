# oprot
Generate protocols


## Concept
`oprot` generates protocols from an OCaml DSL description.

Protocols consist of:
- Fields, of different basic data types
- Groups, including repeating groups
- Selectors, which select between different fields and groups
- Message names, of different scopes

The generator will determine:
- Which fields will need to be read to uniquely identify a message
- Which fields will need to be read to determine the message length

For each field, it will also determine:
- Which other fields need to be read to uniquely determine the offset and length of the field
- Which message types have the field present
