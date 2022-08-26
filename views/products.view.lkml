view: products {
  sql_table_name: `thelook.products` ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    label: "ブランド"
    type: string
    sql: ${TABLE}.brand ;;
    link: {
      label: "Google"
      url: "http://www.google.com/search?q={{ value | encode_uri }}"
      icon_url: "http://google.com/favicon.ico"
    }
    link: {
      label: "{{value}} Analytics Dashboard"
      url: "/dashboards/694?Brand={{ value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  dimension: category {
    # view_label: "order_items"
    # view_label: "オーダー"
    label: "カテゴリ"
    type: string
    sql: ${TABLE}.category ;;
    link: {
      label: "View Category Detail"
      url: "/explore/advanced_data_analyst_bootcamp/inventory_items?fields=inventory_items.product_category,inventory_items.product_name,inventory_items.count&f[products.category]={{value | url_encode }}"
    }
  }

  dimension: cost {
    label: "原価"
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: department {
    label: "部門"
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.distribution_center_id ;;
  }

  dimension: name {
    label: "名称"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: retail_price {
    label: "小売価格"
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    label: "SKU"
    type: string
    sql: ${TABLE}.sku ;;
  }
  parameter: select_product_detail {
    type: unquoted
    default_value: "department"
    allowed_value: {
      value: "department"
      label: "Department"
    }
    allowed_value: {
      value: "category"
      label: "Category"
    }
    allowed_value: {
      value: "brand"
      label: "Brand"
    }
  }

  dimension: product_hierarchy {
    label_from_parameter: select_product_detail
    type: string
    sql: ${TABLE}.{% parameter select_product_detail %}
      ;;
  }

  parameter: select_product_detail_string {
    type: string
    default_value: "department"
    allowed_value: {
      value: "department"
      label: "Department"
    }
    allowed_value: {
      value: "category"
      label: "Category"
    }
    allowed_value: {
      value: "brand"
      label: "Brand"
    }
  }

  dimension: product_hierachy_string {
    type: string
    sql: {% if select_product_detail_string._parameter_value == "'department'"%}${department}
        {% elsif select_product_detail_string._parameter_value == "'category'"%}${category}
        {%else%}${brand}
        {%endif%};;
  }

  filter: choose_a_category_to_compare {
    type: string
    suggest_explore: inventory_items
    suggest_dimension: inventory_items.product_category
  }

  dimension: category_comparator {
    type: string
    sql:
      CASE
        WHEN {% condition choose_a_category_to_compare %}
                ${category}
            {% endcondition %}
        THEN ${category}
        ELSE 'All Other Categories'
      END
      ;;
  }


  measure: count {
    type: count
    drill_fields: [id, name, distribution_centers.id, distribution_centers.name, inventory_items.count]
  }

  set: porduct {
    fields: [name,brand,category]
  }
}
