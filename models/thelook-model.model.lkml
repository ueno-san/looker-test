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
}

  # join: customer_lifetime_value {
  #   view_label: "カスタマーライフタイムバリュー"
  #   type: left_outer
  #   sql_on: ${customer_lifetime_value.user_id}=${order_items.user_id} ;;
  #   relationship: many_to_one
  # }
