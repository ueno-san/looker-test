- dashboard: looker_geo_dashboard
  title: looker_geo_dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: 地図
    name: 地図
    model: baseball
    explore: geo_data
    type: looker_map
    fields: [geo_data.prefecture, geo_data.sum_amount]
    sorts: [geo_data.sum_amount desc]
    limit: 500
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    defaults_version: 1
    row: 0
    col: 0
    width: 8
    height: 6
  - title: Untitled
    name: Untitled
    model: thelook-model
    explore: order_items
    type: looker_column
    fields: [products.brand, order_items.total_revenue]
    sorts: [order_items.total_revenue desc]
    limit: 20
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
    defaults_version: 1
    row: 6
    col: 0
    width: 8
    height: 6
