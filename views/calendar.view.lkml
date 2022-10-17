view: calendar {
  derived_table: {
    sql:
      SELECT
          timestamp(date,"Asia/Tokyo") as filtered_date
        FROM
            UNNEST(
              GENERATE_DATE_ARRAY(
                    date({%if calendar.display_date_filter._is_filtered %}{% date_start display_date_filter %}
                          {% else %} date(TIMESTAMP(DATETIME_ADD(DATETIME(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'Asia/Tokyo')), INTERVAL -6 DAY)))
                          {% endif%}),
                    date({%if calendar.display_date_filter._is_filtered %}{% date_end display_date_filter %}
                          {% else %}date(TIMESTAMP(DATETIME_ADD(DATETIME(TIMESTAMP(DATETIME_ADD(DATETIME(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'Asia/Tokyo')), INTERVAL -6 DAY))), INTERVAL 7 DAY)))
                          {% endif %}))
            ) AS date
 ;;
  }

  filter: display_date_filter {
    type: date
  }



  dimension_group: filter_date {
    type: time
    timeframes: [raw,date,month,quarter,year]
    sql: ${TABLE}.filtered_date ;;
  }

}
