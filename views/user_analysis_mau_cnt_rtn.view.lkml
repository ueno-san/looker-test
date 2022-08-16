view: user_analysis_mau_cnt_rtn {
# If necessary, uncomment the line below to include explore_source.
# include: "thelook-model.model.lkml"
      derived_table: {
      explore_source: order_items {
        column: created_month {}
        column: user_id {}
        column: count {}
        column: total_revenue {}
        derived_column: last_time_order_month {
          sql: lag(created_month,1) over(partition by user_id order by created_month) ;;
        }
      }
    }

    dimension: pk {
      primary_key: yes
      hidden: yes
      type: string
      sql: concat(${user_id},${created_month}) ;;
    }

    dimension: created_month {
      label: "オーダー Created Month"
      description: "受注日です。"
      type: date_month
    }
    dimension: user_id {
      label: "オーダー ユーザーID"
      type: number
    }
    dimension: count {
      label: "オーダー Count"
      type: number
    }
    dimension: total_revenue {
      label: "オーダー Total Revenue"
      description: "売上の合計"
      type: number
    }
    dimension: last_time_order_month {
      type: date_month
    }

    dimension: convert_created_month_to_date {
      type: date
      sql: concat(${created_month},'-01') ;;
      convert_tz: no
    }

  dimension: convert_last_time_order_month_to_date {
    type: date
    sql: concat(${last_time_order_month},'-01') ;;
    convert_tz: no
  }

  dimension:diff_this_time_and_last_time  {
    type: number
    sql: date_diff(${convert_created_month_to_date},${convert_last_time_order_month_to_date},MONTH) ;;
  }

  dimension: is_new_user {
    type: yesno
    sql: ${last_time_order_month} is null ;;
  }

  dimension: is_continue_user {
    type: yesno
    sql: ${diff_this_time_and_last_time}=1 ;;
  }

  dimension: is_return_user {
    type: yesno
    sql: ${diff_this_time_and_last_time}>1 ;;
  }


  measure: count_new_user {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_new_user: "yes"]
  }

  measure: count_continue_user {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_continue_user: "yes"]
  }

  measure: count_return_user {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_return_user: "yes"]
  }

  measure: count_user {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: percentage_of_new_user {
    type: number
    sql: ${count_new_user}/nullif(${count_user},0) ;;
    value_format_name: percent_1

  }

  # dimension_group: diff_this_time_and_last_time{
  #   type: duration
  #   intervals: [day,month]
  #   sql_end: ${convert_created_month_to_date} ;;
  #   sql_start: ${convert_last_time_order_month_to_date} ;;
  # }


    # dimension_group: convert_created_month_to_date {
    #   type: time
    #   timeframes: [date]
    #   sql: cast(concat(${created_month},"-01") as date) ;;
    # }

  }
