view: ndt_test {
# If necessary, uncomment the line below to include explore_source.
# include: "thelook-model.model.lkml"

     derived_table: {
      explore_source: order_items {
        column: returned_month {}
        timezone: "Japan"
      }
    }
    dimension: returned_month {
      label: "オーダー 返品 Month"
      type: date_month
      convert_tz: yes
    }
  }
