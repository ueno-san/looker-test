 view: order_items {
  sql_table_name: `thelook.order_items` ;;

  dimension: order_item_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # dimension_group: created_date {
  #   # label: "受注"
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     month_name,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.created_at ;;
  # }

  dimension_group: duration_for_user {
    type: duration
    intervals: [day,month,year]
    sql_start: ${created_date} ;;
    sql_end: ${delivered_date} ;;
  }

  dimension_group: created {
    group_label: "受注"
    # label: "受注"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    convert_tz: yes
  }

  dimension_group: delivered {
    label: "到着"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    view_label: "inventory_items"
    label: "オーダーID"
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    label: "返品"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    label: "売上"
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    label: "出荷"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    label: "ステータス"
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    label: "ユーザーID"
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_revenue {
    type: sum
    sql: case when ${sale_price} is null then 0
        else  ${sale_price} end;;
    # html: <font size="+5">{{ value }}</font>;;
    description: "売上の合計"
    # value_format_name: yen_0
    drill_fields: [products.brand,products.category,created_date,users.id]
  }

  measure: total_revenue_null_to_zero {
    type: sum
    sql: COALESCE(${sale_price},0);;
    # html: <font size="+5">{{ value }}</font>;;
    description: "売上の合計"
    value_format: " $#,##0"
    # value_format_name: yen_0
    drill_fields: [products.brand,products.category,created_date,users.id]
  }


  measure: average_revenue_per_user {
    type: number
    sql: ${total_revenue}/${users.count_user} ;;
    value_format_name: decimal_1
  }

  measure: running_total_revenue {
    type: running_total
    sql: ${total_revenue} ;;
  }




  parameter: select_timeframe {
    type: string
    default_value: "created_month"
    allowed_value: {
      value: "created_date"
      label: "Date"
    }
    allowed_value: {
      value: "created_week"
      label: "Week"
    }
    allowed_value: {
      value: "created_month"
      label: "Month"
    }
  }
  dimension: dynamic_timeframe {
    label_from_parameter: select_timeframe
    type: string
    sql:
    {% if select_timeframe._parameter_value == "'created_date'" %}
    ${created_date}
    {% elsif select_timeframe._parameter_value == "'created_week'" %}
    ${created_week}
    {% else %}
    ${created_month}
    {% endif %} ;;
  }

  set: visible_dimensions_and_mesures{
    fields: [
      order_id,
      order_item_id,
      created_month,
      created_month_name,
      created_date,
      created_quarter,
      created_week
    ]
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      order_item_id,
      users.id,
      users.first_name,
      users.last_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}

# view: ext_oder_items {
#   extends: [order_items]
#   measure: total_revenue {
#     type: sum
#     sql: ${sale_price} ;;
#   }
# }
