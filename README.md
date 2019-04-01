# Procedure sfw_lookup

This project is an exploration of the various ways to create restricted
choice input fields.

This is usually done with a drop-down list of options, implemented with
the **select** HTML element containing several **option** elements.

The framework provides several ways to populate a **select** element,

1. Use the elements of an **ENUM** MySQL datatype.
2. In addition to the form's data and schema, include an additional
   query result with the allowed values that are then used as the
   **option** elements.
3. Use a **merged** document that includes the lookup data.  The
   create and update transaction data are merged with with the origin
   document to access the lookup data.
4. Name a table and field name after an **enum** instruction in a
   field branch.  In this example, an definition enum will be
   synthesized from the *name* field of the *Company* table:

   ~~~
   add
      type        : form-new
      schema-proc : App_Invoice_Add
      form-action : ?add_submit
      schema
         field : company
            label : Company
            enum  : Company : name
   ~~~   