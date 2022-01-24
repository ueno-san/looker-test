# このコードは変更する必要がありません。必要な場所に以下のコードを含むファイルを作成して保存してください。例えばRefinementsのコード部分でも良いでしょう

view: pop_support {

  derived_table: {

    sql:

      select periods_ago from

      (

        select 0 as periods_ago

        {% if periods_ago._in_query%}{%comment%}このビューが何らかの理由で結合されたが、periods_agoが実際には使用されていない場合に、不要なファンアウトを防ぐための追加のバックストップ{%endcomment%}

        {% for i in (1..52)%} union all select {{i}}{%endfor%}{%comment%}最大52週まで設定できます。選択が不十分だとピボットが大きくなりすぎてレンダリングが滞る以外は、実運用上の問題はありません。{%endcomment%}

        {%endif%}

      ) possible_periods

      where {%condition periods_ago_to_include%}periods_ago{%endcondition%}

      {% if periods_ago_to_include._is_filtered == false%}and periods_ago <=1{%endif%}{%comment%}デフォルト1期前までの期間{%endcomment%}

      ;;

    }

    dimension: periods_ago {hidden:yes type:number}

    filter: periods_ago_to_include {

      label: "PoP Periods Ago To Include"

      description: "比較期間を指定するために使用します。デフォルトは 0 または 1 です。(つまり 0=現在 と 1つ前になります)。数字として扱って範囲でも指定できます（例：12以下）"

      type: number

      default_value: "0,1"

    }

    parameter: period_size {

      label: "PoP Period Size"

      description: "デフォルトは直感的に機能するはずです（選択したスケール、つまり行の粒度に合わせる必要があります）が、別のオフセット量を指定する必要がある場合はこれを使用できます。たとえば、毎日の結果を見たいが、以前の52週間と比較したい場合など"

      type: unquoted

      allowed_value: {value:"Day"}

      allowed_value: {value:"Month"}

      allowed_value: {value:"Year"}

      # allowed_value: {value:"Week"}
      # allowed_value: {value:"Quarter"}
      # 他の時間枠も多少調整すれば処理できると思われますが、Dialect依存のため普遍的にサポートされていない可能性があり、ユーザーにとって不要な場合があります

      allowed_value: {value:"Default" label:"Default Based on Selection"}

      default_value: "Default"

    }



    dimension: now_sql {

      type: date_raw

      expression: now();;
      # sql: current_date() ;;

    }

    dimension: now_converted_to_date_with_tz_sql {

      hidden: yes

      type: date

      # sql: current_date() ;;
      expression: now();;


    }



    dimension: pop_sql_years_using_now  {type: date_raw expression:  add_years(${periods_ago},${now_sql});;}#use looker expressions to get dialect specific sql for date add functions

    dimension: pop_sql_months_using_now {type: date_raw expression:  add_months(${periods_ago},${now_sql});;}

    dimension: pop_sql_days_using_now   {type: date_raw expression:  add_days(${periods_ago},${now_sql});;}



    dimension: period_label_sql {

      hidden:yes

      expression:

      if(${pop_support.periods_ago}=0," Current"

        , concat(

            ${pop_support.periods_ago}," REPLACE_WITH_PERIOD"

            ,if(${pop_support.periods_ago}>1,"s","")

            ," Prior"

          )

      );;

      }

    }
