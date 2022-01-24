include: "order_items.view"
include: "pop_support.view"

view: +order_items {# view名を指定して + でRefinementsします。このビューはここに含めておく必要があり、またExploreにも含まれる必要があります。


  #Refine YOUR date field by simply updating the dimension group name to match your base date field

  dimension_group: created {

    convert_tz: no #we need to inject the conversion before the date manipulation

    datatype: datetime

    sql:{% assign now_converted_to_date_with_timezone_sql = "${pop_support.now_converted_to_date_with_tz_sql::unknown}" %}{% assign now_unconverted_sql = pop_support.now_sql._sql %}
                {%comment%}PoP Supportテンプレートからロジックを引用し、その中に元のSQLを挿入します。Lookerに変換を実行させたい場合は${:: date}を使用しますが、生のSQLを抽出するには _sql を使用します{%endcomment%}

                {% assign selected_period_size = selected_period_size._sql | strip%}

                {%if selected_period_size == 'Day'%}{% assign pop_sql_using_now = "${pop_support.pop_sql_days_using_now::unknown}" %}{%elsif selected_period_size == 'Month'%}{% assign pop_sql_using_now = "${pop_support.pop_sql_months_using_now::unknown}" %}{%else%}{% assign pop_sql_using_now = "${pop_support.pop_sql_years_using_now::unknown}" %}{%endif%}

                {% assign my_date_converted = now_converted_to_date_with_timezone_sql | replace:now_unconverted_sql,"${EXTENDED}" %}

                {% if pop_support.periods_ago._in_query %}{{ pop_sql_using_now | replace: now_unconverted_sql, my_date_converted }}

                {%else%}{{my_date_converted}}

                {%endif%};;
                # パラメータ化されたselected-period-size-or-smart-default（以下に定義）を利用して、元のSQL（つまり、${EXTENDED}）をカスタム PoP ロジック内にラップします

    }



    # 選択した期間サイズは、ユーザーがPoP期間サイズパラメータを調整しない場合に、各時間枠で使用するデフォルトの期間長を設定します

    # YoYだけ有効にしたい場合は、ここで他のタイムフレームを隠すことでPOP Supportのパラメータから消せます

    dimension: selected_period_size {

      hidden: yes

      sql:{%if pop_support.period_size._parameter_value != 'Default'%}{{pop_support.period_size._parameter_value}}

                {% else %}

                  {% if created_date._is_selected %}Day

                  {% elsif created_month._is_selected %}Month

                  {% else %}Year

                  {% endif %}

                {% endif %};;
                # created_dateとcreated_monthが指定のタイムフレームを指し示すようにこのLiquidを更新します。また潜在的に他のタイムフレーム(weekなど)が参照される可能性がある場合はそれも考慮して、このビュー内の他のRefinementsされたPoP日付フィールドを指すように編集します（存在する場合）

      }



      dimension: created_date_periods_ago_pivot {# ベースフィールド名に一致するように更新します。これは一般的なSQLロジックです（したがって、pop_supportテンプレートにあると思われるかもしれません）が、この特定の日付ディメンションのグループラベルに専用のピボットフィールドを作成できるように、この楔となるピボットフィールドをここに明示すると便利です。

        label: "{% if _field._in_query%}Pop Period (Created {{selected_period_size._sql}}){%else%} Pivot for Period Over Period{%endif%}" # フィールドピッカーで「PIVOT ME」としておくと明確になります。ラベルは選択した期間サイズに基づいて動的出力ラベルが使用されます

        group_label: "Created Date" #!Update this group label if necessary to make it fall in your date field's group_label

        order_by_field: pop_support.periods_ago #sort numerically/chronologically.

        sql:{% assign period_label_sql = "${pop_support.period_label_sql}" %}{% assign selected_period_size = selected_period_size._sql | strip%}{% assign label_using_selected_period_size = period_label_sql | replace: 'REPLACE_WITH_PERIOD',selected_period_size%}{{label_using_selected_period_size}};;#makes intuitive period labels

      }



# Optional Validation Support field.  If there's ever any confusion with the results of PoP, it's helpful to see the exact min and max times of your raw data flowing through.

#  measure: pop_validation {

#     view_label: "PoP - VALIDATION - TO BE HIDDEN"

#     label: "Range of Raw Dates Included"

#     description: "Note: does not reflect timezone conversion"

#sql:{%assign base_sql = '${TABLE}.created_at'%}concat(concat(min({{base_sql}}),' to '),max({{base_sql}}));;#!Paste the sql parameter value from the original date fields as the variable value for base_sql

#   }

 }
