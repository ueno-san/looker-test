- dashboard: test_moved_from_tsutomu_ueno
  title: test (moved from Tsutomu Ueno)
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: test
    name: test
    model: thelook-model
    explore: order_items
    type: looker_grid
    fields: [order_items.created_month, order_items.total_revenue]
    fill_fields: [order_items.created_month]
    sorts: [order_items.created_month desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    title_hidden: true
    listen: {}
    row: 0
    col: 0
    width: 8
    height: 6
  - name: add look to dashboard
    title: add look to dashboard
    model: thelook-model
    explore: order_items
    type: looker_column
    fields: [order_items.created_month, order_items.total_revenue]
    fill_fields: [order_items.created_month]
    sorts: [order_items.created_month desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 6
    col: 0
    width: 8
    height: 6
