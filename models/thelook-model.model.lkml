include: "/*.dashboard.lookml"
connection: "looker-demo-bigquery"

datagroup: aaaa {
  sql_trigger: select cuurent_date() ;;
  # max_cache_age: "24 hours"
  max_cache_age: "10 hours"
}

access_grant: inventory {
  user_attribute: accessible_departments
  allowed_values: ["Inventory"]
}

explore: employee_master {
  access_filter: {
    field: division
    user_attribute: company_id
  }
}


persist_with: aaaa

include: "/views/*.view.lkml"

explore: calendar {
  fields: [ALL_FIELDS*,-order_items.average_revenue_per_user]
  label: "予測テスト"
  join: order_items {
    type: left_outer
    sql_on: ${calendar.filter_date_date} <= ${order_items.created_raw} and
            ${calendar.filter_date_date} >= ${order_items.created_raw} ;;
    relationship: one_to_many
  }
  join: pop_support {

    view_label: "PoP Support - Overrides and Tools"
    # pop_supportビューではなく、ここでこのExploreで使用するためにビューラベルを更新します。これをPOP日付のビューラベルに合わせることができます

    relationship:one_to_one
    # ここでは意図的にファンアウトさせます。そのため、one_to_one のままにしておきます

    sql:{% if pop_support.periods_ago._in_query%}LEFT JOIN pop_support on 1=1{%endif%};;

    # 楔となるピボットフィールド（periods_ago）が選択されている場合にのみprior_periodが含まれ、結合及びファンアウトされるようにします。この安全対策により、ユーザーがPop SupportでPoPパラメーターを選択したが、実際にはPoPのピボットフィールドを選択しなかった場合に、結合によってファンアウトが発生しないことが保証されます。

  }

}

explore:inventory  {
  view_name: inventory_items
  join: products {
    view_label: "プロダクト"
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

}

explore: order_items {
  view_name: order_items
  extends: [inventory]

  # sql_always_where:
  # {%if order_items.select_month._is_selected%}
  # ${created_raw}>=date_sub(current_date,interval {%parameter order_items.select_month%} month)
  # {%else%}1=1
  # {%endif%};;
  sql_always_where:
  {%if order_items.select_month._is_filtered%}
  ${created_raw}>=date_sub(current_date,interval {%parameter order_items.select_month%} month)
  {%else%}1=1
  {%endif%};;

# fields: [ALL_FIELDS*,-order_items.created_date]

  #テストユーザを除く
  # sql_always_where: ${user_id}<>'0' ;;

  #$10,000以下は除外する
  #sql_always_having: ${total_revenue}>10000 ;;

  #デフォルトの日付フィルタ
  # always_filter: {
  #   filters: [order_items.created_date: "7 days"]
  # }


  # conditionally_filter: {
  #   filters: [order_items.created_date: "7 days"]
  #   unless: [order_id,user_id]
  # }

  # fields: [ALL_FIELDS*,-order_items.total_revenue]
  # fields: [order_items.visible_dimensions_and_mesures*]
  # group_label: "LookML基礎 2021 fall"
  # access_filter: {
  #   field: users.email
  #   user_attribute: email
  # }
  label: "(1) オーダー、アイテム、ユーザー関連"
  view_label: "オーダー"
  # sql_always_where: ${order_items.status}="Complete" and {%condition users.user_name_filter%}${users.name}{% endcondition %} ;;
# always_filter: {{% conditon }}
  # access_filter: {
  #   field: order_items.user_id
  #   user_attribute: company_id
  # }
  join: users {
    view_label: "ユーザー"
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  # extends: [extends_for]

  join: inventory_items {
    view_label: "在庫アイテム"
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }
  # extends: [inventory_items]
  # join: products {
  #   view_label: "プロダクト"
  #     type: left_outer
  #     sql_on: ${inventory_items.product_id} = ${products.id} ;;
  #     relationship: many_to_one
  # }

  join: ndt_test {
    type: left_outer
    sql_on: ${ndt_test.returned_month} = ${order_items.returned_month} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    # required_access_grants: [inventory]
    type: left_outer
    sql_on: ${products.distribution_center_id}=${distribution_centers.id} ;;
    relationship: many_to_one
  }

  join: user_analysis_mau_cnt_rtn {
    type: left_outer
    sql_on: ${order_items.created_month} = ${user_analysis_mau_cnt_rtn.created_month}
            and ${order_items.user_id} = ${user_analysis_mau_cnt_rtn.user_id};;
    relationship: many_to_one
  }

  join: pop_support {

    view_label: "PoP Support - Overrides and Tools"
    # pop_supportビューではなく、ここでこのExploreで使用するためにビューラベルを更新します。これをPOP日付のビューラベルに合わせることができます

    relationship:one_to_one
    # ここでは意図的にファンアウトさせます。そのため、one_to_one のままにしておきます

    sql:{% if pop_support.periods_ago._in_query%}LEFT JOIN pop_support on 1=1{%endif%};;

    # 楔となるピボットフィールド（periods_ago）が選択されている場合にのみprior_periodが含まれ、結合及びファンアウトされるようにします。この安全対策により、ユーザーがPop SupportでPoPパラメーターを選択したが、実際にはPoPのピボットフィールドを選択しなかった場合に、結合によってファンアウトが発生しないことが保証されます。

  }

  #（オプション）：このalways_filterを基準日フィールドに更新して、フィルターの使用を促します。フィルターを使用しない場合は、POPを使用すると、「未来」の期間が表示されます（たとえば、今日のデータは、技術的には来年からみた「昨年」であるため）。

#always_filter: {filters: [order_items.created_date: "before 0 minutes ago"]}

}

explore: products {

  # # extends: [inventory_items]
  # join: inventory_items {
  #   view_label: "inventory_items"
  #   type: left_outer
  #   sql_on: ${inventory_items.product_id} = ${products.id} ;;
  #   relationship: many_to_one
  # }

  # join: order_items {
  #   view_label: "order_items"
  #   type: left_outer
  #   sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
  #   relationship: many_to_one
  # }

}

explore: baseball {}

  # join: customer_lifetime_value {
  #   view_label: "カスタマーライフタイムバリュー"
  #   type: left_outer
  #   sql_on: ${customer_lifetime_value.user_id}=${order_items.user_id} ;;
  #   relationship: many_to_one
  # }
test: historic_revenue_is_accurate {
  explore_source: order_items {
    column: total_revenue {
      field: order_items.total_revenue
    }
    column: count {field:order_items.count}
    filters: [order_items.created_date: "2017"]
  }
  assert: revenue_is_expected_value {
    expression: ${order_items.total_revenue} = 626000 ;;
  }
  assert: revenue_is_expected {
    expression: ${order_items.count} = 1;;
  }
}
test: status_is_not_null {
  explore_source: order_items {
    column: status {}
    sorts: [order_items.status: desc]
    limit: 1
  }
  assert: status_is_not_null {
    expression: NOT is_null(${order_items.status}) ;;
  }
}

# named_value_format: dynamic_value_format {
#   value_format:
#     {%if  select_measure._parameter_value == "'total_revenue'" %}
#     "usd_0"
#     {%elsif select_measure._parameter_value == "'average_revenue_per_user'" %}
#     "percent_0"
#     {%else%}
#     "decimal_0"
#     {%endif%}

# }

explore: population {}

# explore: extends_for {
#   from: order_items
#   view_name: order_items

#   join: users {
#     view_label: "ユーザー"
#     type: left_outer
#     sql_on: ${order_items.total_revenue} = ${users.id} ;;
#     relationship: many_to_one
#   }

# }
