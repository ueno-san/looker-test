view: v_cf_products_redistribution {
  sql_table_name: `tsutomuueno-looker-training.sample.v_cf_products_redistribution`
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

  dimension: deemed_cost {
    type: number
    sql: ${TABLE}.deemed_cost ;;
  }

  dimension: deemed_sales_admin_expense {
    type: number
    sql: ${TABLE}.deemed_sales_admin_expense ;;
  }

  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }

  dimension: display_year {
    type: string
    sql: case when ${fiscal_year} is null then
            case when ${v_cf_solutions.fiscal_year} is null then ${v_distribution_costs_from_cf.fiscal_year}
              else ${v_cf_solutions.fiscal_year} end
          else ${fiscal_year} end;;
  }
  filter: filter_cash_flow_name {
    type: string
    suggest_dimension: cash_flow_name
  }


  measure: sum_deemed_cost {
    type: sum
    sql: ${deemed_cost} ;;
  }

  measure: sum_deemed_sales_admin_expense {
    type: sum
    sql: ${deemed_sales_admin_expense} ;;
  }

  measure: count {
    type: count
    drill_fields: [cash_flow_name]
  }
}
