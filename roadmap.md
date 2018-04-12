
# Database & table creation

sql escape for all inputs
  Project
    * #uuid -> Database user

  Database
    * rename database_identifier to uuid

  Table

  Column

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
