view: emoji {
  sql_table_name: `tsutomuueno-looker-training.thelook.emoji`
    ;;

  dimension: liver_name {
    primary_key: yes
    type: string
    sql: ${TABLE}.liver_name ;;
  }

  # measure: count {
  #   type: count
  #   drill_fields: [liver_name]
  # }
}

explore: emoji {}
