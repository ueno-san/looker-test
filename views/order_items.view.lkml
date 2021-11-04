view: order_items {
  sql_table_name: `thelook.order_items` ;;

dimension: id {
  type: string
  sql: ${TABLE}.id ;;
  primary_key: yes
}


}
