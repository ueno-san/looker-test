view: users {
  sql_table_name: `thelook.users` ;;

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
    primary_key: yes
  }

  measure:count_user {
    type: count
  }

}
