
# Database & table creation

Project
  * #uuid -> Database user

Database
  * database_name (user editable later) -> db Name
    * default is slugged name

Table
  * table_name (user editable later) -> table name
    * default is slugged name

Column
  * column_name (user editable later) -> table name
    * default is slugged name

Rows x RowValues
  * automatically inserted
  * later: two-way binding

DatabaseController
  * DatabaseController#queries
    * SQL payload queried against database
    * Answer is a JSON dict for SELECT statements
      * query-uuid returned as answer
      * /queries/<query-uuid>
      * later pagable
