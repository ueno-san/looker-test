connection: "looker_demo_db"

include: "/views/*.view.lkml"
explore: order_items {

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
  sql_always_where: ${order_items.status}="Complete" ;;
# always_filter: {{% conditon }}
  join: users {
    view_label: "ユーザー"
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    view_label: "在庫アイテム"
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }
  # extends: [inventory_items]
  join: products {
    view_label: "プロダクト"
      type: left_outer
      sql_on: ${inventory_items.product_id} = ${products.id} ;;
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
