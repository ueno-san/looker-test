view: v_cf_solutions {
  sql_table_name: `tsutomuueno-looker-training.sample.v_cf_solutions`
    ;;

  dimension: pk {
    type: string
    hidden: yes
    primary_key: yes
    sql: concat(${cash_flow_id},${fiscal_year}) ;;
  }

  dimension: cash_flow_id {
    type: string
    sql: ${TABLE}.cash_flow_id ;;
  }

  dimension: cash_flow_name {
    type: string
    sql: ${TABLE}.cash_flow_name ;;
  }

  dimension: deemed_direct_sales_admin_expense {
    type: number
    sql: ${TABLE}.deemed_direct_sales_admin_expense ;;
  }

  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }

  measure: sum_deemed_direct_sales_admin_expense {
    type: sum
    sql: ${deemed_direct_sales_admin_expense} ;;
  }

  measure: count {
    type: count
    drill_fields: [cash_flow_name]
  }
}
