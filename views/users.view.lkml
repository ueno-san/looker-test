view: users {
  sql_table_name: `thelook.users` ;;

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
    primary_key: yes
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  measure:count_user {
    type: count
  }

}
