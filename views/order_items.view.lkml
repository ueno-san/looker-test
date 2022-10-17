 view: order_items {
  sql_table_name: `thelook.order_items` ;;

  dimension: order_item_id {
    primary_key: yes
    hidden: yes
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

  # dimension_group: created2 {
  #   group_label: "01.受注"
  #   description: "受注日です。"
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
  #   convert_tz: yes
  # }

  dimension: created_mon {
    type: date_month
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created {
    group_label: "01.受注"
    description: "受注日です。"
    # label: "受注"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      day_of_week,
      day_of_month,
      day_of_year,
      month,
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    # datatype: timestamp
    convert_tz: yes
  }

  dimension: wtd_only {
    group_label: "To-Date Filters"
    label: "WTD"
    type: yesno
    sql: EXTRACT(DAYOFWEEK FROM ${created_raw}) <= EXTRACT(DAYOFWEEK FROM CURRENT_DATE('Asia/Tokyo'));;
  }

  dimension: mtd_only {
    group_label: "To-Date Filters"
    label: "MTD"
    type: yesno
    sql: EXTRACT(DAY FROM ${created_raw}) <= EXTRACT(DAY FROM CURRENT_DATE('Asia/Tokyo'));;
  }

  dimension: ytd_only {
    group_label: "To-Date Filters"
    label: "YTD"
    type: yesno
    sql: EXTRACT(DAYOFYEAR FROM ${created_raw}) <= EXTRACT(DAYOFYEAR FROM CURRENT_DATE('Asia/Tokyo'));;
  }



  parameter: select_month {
    type: number
    default_value: "1"
    allowed_value: {
      label: "1ヶ月"
      value: "1"
    }
    allowed_value: {
      label: "2ヶ月"
      value: "2"
    }
    allowed_value: {
      label: "3ヶ月"
      value: "3"
    }
  }



  dimension_group: delivered {
    group_label: "02.到着"
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
    group_label: "05.inventory"
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    group_label: "05.inventory"
    # view_label: "inventory_items"
    label: "オーダーID"
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    group_label: "03.返品"
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
    hidden: yes
    label: "売上"
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    group_label:"04.出荷"
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

  dimension: start_date {
    label: "月の初日"
    type: date
    datatype: date
    sql:date_trunc(${created_raw},month)  ;;
  }

  dimension:last_date  {
    label: "月の最終日"
    datatype: date
    type: date
    sql: last_day(${created_raw},month) ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_revenue {
    type: sum
    sql: ${sale_price} ;;
    # sql: case when ${sale_price} is null then 0
    #     else  ${sale_price} end;;
    #html: <font size="+5">{{ value }}</font>;;
    # html:  ;;
    # html: {% if value >= 1000 and value < 1000000 %}{{value  | divided_by: 1000 | round:1}}k
    #       {% elsif value >= 1000000 and value < 1000000000 %}{{value | divided_by: 1000000 | round:1}}m
    #       {% elsif value > 1000000000 %}{{value| divided_by: 1000000000 | round:1}}b
    #       {% else %}{{rendered_value}}
    #       {% endif %};;
    # html: {% if value >= 1000 and value < 1000000 %}
    #       <b><p style="color: black; background-color: #dc7350; margin: 0; border-radius: 5px; text-align:center">{{ value }}</p></b>
    #       {% elsif value >= 1000000 and value < 1000000000 %}
    #       <b><p style="color: black; background-color: #e9b404; margin: 0; border-radius: 5px; text-align:center">{{ value }}</p></b>
    #       {% elsif value > 1000000000 %}
    #       <b><p style="color: black; background-color: #49cec1; margin: 0; border-radius: 5px; text-align:center">{{ value }}</p></b>
    #       {% else %}{{rendered_value}}
    #       {% endif %};;
    # description: "売上の合計"
    #value_format_name: yen_0
    # drill_fields: [products.brand,products.category,created_date,users.id]
  }
  measure: total_revenue_over_2000000 {
    type: number
    sql: case when ${total_revenue} >= 10000 then ${total_revenue}
          else null end;;
    description: "売上の合計 200,000以上"
    #value_format_name: yen_0
    drill_fields: [products.brand,products.category,created_date,users.id]
    html: revenue:{{rendered_value}}<br>
          count:{{count._rendered_value}};;
  }

  measure: total_revenue_under_2000000 {
    type: number
    sql: case when ${total_revenue} < 10000 then ${total_revenue}
      else  null end;;
    description: "売上の合計 200,000未満"
    #value_format_name: yen_0
    drill_fields: [products.brand,products.category,created_date,users.id]
    html: revenue:{{rendered_value}}<br>
    count:{{count._rendered_value}};;
  }

  measure: max_last_date {
    type: date
    sql: max(${last_date}) ;;
    datatype: date
  }

  measure: max_first_date {
    type: date
    sql: max(${start_date})
       ;;
    datatype: date
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

  measure: sum_revenue_count {
    type: number
    sql: ${total_revenue} ;;
    value_format: " $#,##0"
    html: {{rendered_value}}/
       {{order_items.count._rendered_value}} ;;
  }


  measure: average_revenue_per_user {
    type: number
    sql: ${total_revenue}/${users.count_user} ;;
    value_format_name: percent_1
  }

  measure: running_total_revenue {
    type: running_total
    sql: ${total_revenue} ;;

  }

  measure: multiple_values {
    type: number
    sql: ${total_revenue} ;;
    html: <html>
    Home Page visit:{{total_revenue_null_to_zero._rendered_value}}<br>
    Account Page Visit:{{count._rendered_value}}
    </html>;;
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

  parameter: select_measure {
    type: string
    allowed_value: {
      label: "売上"
      value: "total_revenue"
    }
    allowed_value: {
      label: "一人あたりの売上"
      value: "average_revenue_per_user"
    }
    default_value: "total_revenue"
  }

  measure: selected_measure {
    type: number
    sql:     {% if select_measure._parameter_value == "'total_revenue'" %}
    ${total_revenue}
    {% elsif select_measure._parameter_value == "'average_revenue_per_user'" %}
    ${average_revenue_per_user}
    {% else %}
    0
    {% endif %}  ;;
    html:
    {%if  select_measure._parameter_value == "'total_revenue'" %}
    ${{rendered_value}}
    {%elsif select_measure._parameter_value == "'average_revenue_per_user'" %}
    {{rendered_value}}%
    {%else%}
    {{rendered_value}}
    {%endif%};;
    # value_format_name: percent_0
  }

  measure: last_year_ {
    type: sum
    sql: ${sale_price} ;;
    html: {{rendered_value}} ;;
  }




  # measure: std_pop_count {
  #   type:
  # }

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

  set: set_created{
    fields: [
      created_month,
      created_month_name,
      created_date,
      created_quarter,
      created_week,
      created_raw,
      created_time,
      created_year
    ]
  }


  # set: prediction_test {
  #   fields: [
  #     ALL_FIELDS*

  #   ]
  # }


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
