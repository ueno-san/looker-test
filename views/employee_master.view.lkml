view: employee_master {
  sql_table_name: `thelook.employee_master`
    ;;

  dimension: email {
    type: string
    sql: ${TABLE}.string_field_0 ;;
  }

  dimension: division {
    type: string
    sql: ${TABLE}.string_field_1 ;;
  }

  # measure: count {
  #   type: count
  #   drill_fields: []
  # }
}
