view: boxplot {
  sql_table_name: `tsutomuueno-looker-training.test.boxplot`
    ;;

  dimension: max_value {
    type: number
    sql: ${TABLE}.max_value ;;
  }

  dimension: median {
    type: number
    sql: ${TABLE}.median ;;
  }

  dimension: min_value {
    type: number
    sql: ${TABLE}.min_value ;;
  }

  dimension: seventyfive_percent {
    type: number
    sql: ${TABLE}.seventyfive_percent ;;
  }

  dimension: trafficsource {
    primary_key: yes
    type: string
    sql: ${TABLE}.trafficsource ;;
  }

  dimension: twentyfive_percent {
    type: number
    sql: ${TABLE}.twentyfive_percent ;;
  }

  measure: sum_min_value {
    type: sum
    sql: ${min_value} ;;
  }

  measure: sum_max_value {
    type: sum
    sql: ${max_value} ;;
  }

  measure: sum_twentyfive_percent {
    type: sum
    sql: ${twentyfive_percent} ;;
  }

  measure: sum_median {
    type: sum
    sql: ${median} ;;
    html: <html><body><h2 style="color:blue">{{rendered_value}}</h2></body></html> ;;
  }

  measure: sum_seventyfive_percent {
    type: sum
    sql: ${seventyfive_percent} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
