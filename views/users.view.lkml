view: users {
  sql_table_name: `thelook.users` ;;

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
    primary_key: yes
  }

  dimension: test_for_jinjer {
    type: string
    sql: case when ${id} is not null then ${id}
    else  ${order_items.user_id} end
    ;;
  }

  measure:count_user {
    type: count_distinct
    sql:${id} ;;
  }
  measure: average_revenue_per_user {
    type: number
    sql: ${order_items.total_revenue}/${count_user} ;;
    value_format_name: decimal_1
  }



}
