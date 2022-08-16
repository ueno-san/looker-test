view: population {
  sql_table_name: `tsutomuueno-looker-training.thelook.population` ;;

  dimension: prefecture {
    type: string
    sql: string_field_7 ;;
    primary_key: yes
  }

  dimension: population {
    type: number
    sql: int64_field_8 ;;
  }

  measure: sum_population {
    type: number
    sql: sum(${population}) ;;
    value_format: "#,###"

    # html: {% if value != null %}{{rendered_value}}{%else%}{% endif %}  ;;
  }
  measure: sum_population_to_0 {
    type: sum
    sql: ${population} ;;
    value_format: "#,###"

    # html: {% if value != null %}{{rendered_value}}{%else%}{% endif %}  ;;
  }



}
