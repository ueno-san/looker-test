view: v_distribution_costs_from_cf {
  sql_table_name: `tsutomuueno-looker-training.sample.v_distribution_costs_from_cf`
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

  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }

  dimension: total_amount {
    type: number
    sql: ${TABLE}.total_amount ;;
  }

  measure: sum_total_amount {
    type: sum
    sql: ${total_amount} ;;
  }

  measure: count {
    type: count
    drill_fields: [cash_flow_name]
  }
}
