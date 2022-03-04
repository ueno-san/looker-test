view: users {
  sql_table_name: `thelook.users` ;;

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
    primary_key: yes
  }

#   dimension: current_dt {
#     type: date
#     sql: current_date() ;;
#   }

# # parameter: par_current_dt {
#   type: string
#   allowed_value: {
#     label: "最新月"
#     value: "{{current_dt._value}}"
#   }
#   default_value: "{{current_dt._value}}"
# }

  dimension: first_name {
    # label: "{% if users.current_dt._value = '2022-01-28' %}today{% else %}yesterday{% endif %}"
    type: string
    sql: ${TABLE}.first_name ;;
    html: <html><meta charset="UTF-8">{{value}}&#128512;</html> ;;
  }

  # dimension: test_for_jinjer {
  #   type: string
  #   sql: case when ${id} is not null then ${id}
  #   else  ${order_items.user_id} end
  #   ;;
  # }



  measure:count_user {
    type: count_distinct
    sql:${id} ;;
  }
  measure: average_revenue_per_user {
    type: number
    sql: ${order_items.total_revenue}/${count_user} ;;
    value_format_name: decimal_1
  }

  filter: user_name_filter {
    type: string
  }


  # filter: name_to_id {

  #   # suggest_explore: users

  #   # suggest_dimension: users.name

  #   type: string
  #   bypass_suggest_restrictions: yes
  #   suggest_dimension: users.name

  #   # sql:${TABLE}.id in (SELECT distinct users.id FROM `thelook.users`
  #   #     where {% condition user_name_filter %} users.name {% endcondition %}) ;;

  #   }


}
