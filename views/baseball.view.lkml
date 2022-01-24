view: baseball {
  # sql_table_name: `tsutomuueno-looker-training.sample.baseball`
  #   ;;
  sql_table_name: `sample.baseball`
    ;;

    filter: filer_name {
      type: date_time
    }



  dimension_group: _partitiondate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}._PARTITIONDATE ;;
  }

  dimension_group: _partitiontime {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}._PARTITIONTIME ;;
  }

  dimension: at_bat_event_sequence_number {
    type: number
    sql: ${TABLE}.atBatEventSequenceNumber ;;
  }

  dimension: at_bat_event_type {
    type: string
    sql: ${TABLE}.atBatEventType ;;
  }

  dimension: attendance {
    type: number
    sql: ${TABLE}.attendance ;;
  }

  dimension: away_batter1 {
    type: string
    sql: ${TABLE}.awayBatter1 ;;
  }

  dimension: away_batter2 {
    type: string
    sql: ${TABLE}.awayBatter2 ;;
  }

  dimension: away_batter3 {
    type: string
    sql: ${TABLE}.awayBatter3 ;;
  }

  dimension: away_batter4 {
    type: string
    sql: ${TABLE}.awayBatter4 ;;
  }

  dimension: away_batter5 {
    type: string
    sql: ${TABLE}.awayBatter5 ;;
  }

  dimension: away_batter6 {
    type: string
    sql: ${TABLE}.awayBatter6 ;;
  }

  dimension: away_batter7 {
    type: string
    sql: ${TABLE}.awayBatter7 ;;
  }

  dimension: away_batter8 {
    type: string
    sql: ${TABLE}.awayBatter8 ;;
  }

  dimension: away_batter9 {
    type: string
    sql: ${TABLE}.awayBatter9 ;;
  }

  dimension: away_current_total_runs {
    type: number
    sql: ${TABLE}.awayCurrentTotalRuns ;;
  }

  dimension: away_fielder1 {
    type: string
    sql: ${TABLE}.awayFielder1 ;;
  }

  dimension: away_fielder10 {
    type: string
    sql: ${TABLE}.awayFielder10 ;;
  }

  dimension: away_fielder11 {
    type: string
    sql: ${TABLE}.awayFielder11 ;;
  }

  dimension: away_fielder12 {
    type: string
    sql: ${TABLE}.awayFielder12 ;;
  }

  dimension: away_fielder2 {
    type: string
    sql: ${TABLE}.awayFielder2 ;;
  }

  dimension: away_fielder3 {
    type: string
    sql: ${TABLE}.awayFielder3 ;;
  }

  dimension: away_fielder4 {
    type: string
    sql: ${TABLE}.awayFielder4 ;;
  }

  dimension: away_fielder5 {
    type: string
    sql: ${TABLE}.awayFielder5 ;;
  }

  dimension: away_fielder6 {
    type: string
    sql: ${TABLE}.awayFielder6 ;;
  }

  dimension: away_fielder7 {
    type: string
    sql: ${TABLE}.awayFielder7 ;;
  }

  dimension: away_fielder8 {
    type: string
    sql: ${TABLE}.awayFielder8 ;;
  }

  dimension: away_fielder9 {
    type: string
    sql: ${TABLE}.awayFielder9 ;;
  }

  dimension: away_final_errors {
    type: number
    sql: ${TABLE}.awayFinalErrors ;;
  }

  dimension: away_final_hits {
    type: number
    sql: ${TABLE}.awayFinalHits ;;
  }

  dimension: away_final_runs {
    type: number
    sql: ${TABLE}.awayFinalRuns ;;
  }

  dimension: away_final_runs_for_inning {
    type: number
    sql: ${TABLE}.awayFinalRunsForInning ;;
  }

  dimension: away_team_id {
    type: string
    sql: ${TABLE}.awayTeamId ;;
  }

  dimension: away_team_name {
    type: string
    sql: ${TABLE}.awayTeamName ;;
  }

  dimension: balls {
    type: number
    sql: ${TABLE}.balls ;;
  }

  dimension_group: created {
    type: time
    description: "bq-datetime"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.createdAt ;;
  }

  dimension: day_night {
    type: string
    sql: ${TABLE}.dayNight ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: duration {
    type: string
    sql: ${TABLE}.duration ;;
  }

  dimension: duration_minutes {
    type: number
    sql: ${TABLE}.durationMinutes ;;
  }

  dimension: game_id {
    type: string
    sql: ${TABLE}.gameId ;;
  }

  dimension: game_status {
    type: string
    sql: ${TABLE}.gameStatus ;;
  }

  dimension: hit_location {
    type: number
    sql: ${TABLE}.hitLocation ;;
  }

  dimension: hit_type {
    type: string
    sql: ${TABLE}.hitType ;;
  }

  dimension: hitter_bat_hand {
    type: string
    sql: ${TABLE}.hitterBatHand ;;
  }

  dimension: hitter_first_name {
    type: string
    sql: ${TABLE}.hitterFirstName ;;
  }

  dimension: hitter_height {
    type: number
    sql: ${TABLE}.hitterHeight ;;
  }

  dimension: hitter_id {
    type: string
    sql: ${TABLE}.hitterId ;;
  }

  dimension: hitter_last_name {
    type: string
    sql: ${TABLE}.hitterLastName ;;
  }

  dimension: hitter_pitch_count {
    type: number
    sql: ${TABLE}.hitterPitchCount ;;
  }

  dimension: hitter_weight {
    type: number
    sql: ${TABLE}.hitterWeight ;;
  }

  dimension: home_batter1 {
    type: string
    sql: ${TABLE}.homeBatter1 ;;
  }

  dimension: home_batter2 {
    type: string
    sql: ${TABLE}.homeBatter2 ;;
  }

  dimension: home_batter3 {
    type: string
    sql: ${TABLE}.homeBatter3 ;;
  }

  dimension: home_batter4 {
    type: string
    sql: ${TABLE}.homeBatter4 ;;
  }

  dimension: home_batter5 {
    type: string
    sql: ${TABLE}.homeBatter5 ;;
  }

  dimension: home_batter6 {
    type: string
    sql: ${TABLE}.homeBatter6 ;;
  }

  dimension: home_batter7 {
    type: string
    sql: ${TABLE}.homeBatter7 ;;
  }

  dimension: home_batter8 {
    type: string
    sql: ${TABLE}.homeBatter8 ;;
  }

  dimension: home_batter9 {
    type: string
    sql: ${TABLE}.homeBatter9 ;;
  }

  dimension: home_current_total_runs {
    type: number
    sql: ${TABLE}.homeCurrentTotalRuns ;;
  }

  dimension: home_fielder1 {
    type: string
    sql: ${TABLE}.homeFielder1 ;;
  }

  dimension: home_fielder10 {
    type: string
    sql: ${TABLE}.homeFielder10 ;;
  }

  dimension: home_fielder11 {
    type: string
    sql: ${TABLE}.homeFielder11 ;;
  }

  dimension: home_fielder12 {
    type: string
    sql: ${TABLE}.homeFielder12 ;;
  }

  dimension: home_fielder2 {
    type: string
    sql: ${TABLE}.homeFielder2 ;;
  }

  dimension: home_fielder3 {
    type: string
    sql: ${TABLE}.homeFielder3 ;;
  }

  dimension: home_fielder4 {
    type: string
    sql: ${TABLE}.homeFielder4 ;;
  }

  dimension: home_fielder5 {
    type: string
    sql: ${TABLE}.homeFielder5 ;;
  }

  dimension: home_fielder6 {
    type: string
    sql: ${TABLE}.homeFielder6 ;;
  }

  dimension: home_fielder7 {
    type: string
    sql: ${TABLE}.homeFielder7 ;;
  }

  dimension: home_fielder8 {
    type: string
    sql: ${TABLE}.homeFielder8 ;;
  }

  dimension: home_fielder9 {
    type: string
    sql: ${TABLE}.homeFielder9 ;;
  }

  dimension: home_final_errors {
    type: number
    sql: ${TABLE}.homeFinalErrors ;;
  }

  dimension: home_final_hits {
    type: number
    sql: ${TABLE}.homeFinalHits ;;
  }

  dimension: home_final_runs {
    type: number
    sql: ${TABLE}.homeFinalRuns ;;
  }

  dimension: home_final_runs_for_inning {
    type: number
    sql: ${TABLE}.homeFinalRunsForInning ;;
  }

  dimension: home_team_id {
    type: string
    sql: ${TABLE}.homeTeamId ;;
  }

  dimension: home_team_name {
    type: string
    sql: ${TABLE}.homeTeamName ;;
  }

  dimension: inning_event_type {
    type: string
    sql: ${TABLE}.inningEventType ;;
  }

  dimension: inning_half {
    type: string
    sql: ${TABLE}.inningHalf ;;
  }

  dimension: inning_half_event_sequence_number {
    type: number
    sql: ${TABLE}.inningHalfEventSequenceNumber ;;
  }

  dimension: inning_number {
    type: number
    sql: ${TABLE}.inningNumber ;;
  }

  dimension: is_ab {
    type: number
    sql: ${TABLE}.is_ab ;;
  }

  dimension: is_ab_over {
    type: number
    sql: ${TABLE}.is_ab_over ;;
  }

  dimension: is_bunt {
    type: number
    sql: ${TABLE}.is_bunt ;;
  }

  dimension: is_bunt_shown {
    type: number
    sql: ${TABLE}.is_bunt_shown ;;
  }

  dimension: is_double_play {
    type: number
    sql: ${TABLE}.is_double_play ;;
  }

  dimension: is_hit {
    type: number
    sql: ${TABLE}.is_hit ;;
  }

  dimension: is_on_base {
    type: number
    sql: ${TABLE}.is_on_base ;;
  }

  dimension: is_passed_ball {
    type: number
    sql: ${TABLE}.is_passed_ball ;;
  }

  dimension: is_triple_play {
    type: number
    sql: ${TABLE}.is_triple_play ;;
  }

  dimension: is_wild_pitch {
    type: number
    sql: ${TABLE}.is_wild_pitch ;;
  }

  dimension: lineup_order {
    type: number
    sql: ${TABLE}.lineupOrder ;;
  }

  dimension: lineup_player_id {
    type: string
    sql: ${TABLE}.lineupPlayerId ;;
  }

  dimension: lineup_position {
    type: number
    sql: ${TABLE}.lineupPosition ;;
  }

  dimension: lineup_team_id {
    type: string
    sql: ${TABLE}.lineupTeamId ;;
  }

  dimension: outcome_description {
    type: string
    sql: ${TABLE}.outcomeDescription ;;
  }

  dimension: outcome_id {
    type: string
    sql: ${TABLE}.outcomeId ;;
  }

  dimension: outs {
    type: number
    sql: ${TABLE}.outs ;;
  }

  dimension: pitch_speed {
    type: number
    sql: ${TABLE}.pitchSpeed ;;
  }

  dimension: pitch_type {
    type: string
    sql: ${TABLE}.pitchType ;;
  }

  dimension: pitch_type_description {
    type: string
    sql: ${TABLE}.pitchTypeDescription ;;
  }

  dimension: pitch_zone {
    type: number
    sql: ${TABLE}.pitchZone ;;
  }

  dimension: pitcher_first_name {
    type: string
    sql: ${TABLE}.pitcherFirstName ;;
  }

  dimension: pitcher_id {
    type: string
    sql: ${TABLE}.pitcherId ;;
  }

  dimension: pitcher_last_name {
    type: string
    sql: ${TABLE}.pitcherLastName ;;
  }

  dimension: pitcher_pitch_count {
    type: number
    sql: ${TABLE}.pitcherPitchCount ;;
  }

  dimension: pitcher_throw_hand {
    type: string
    sql: ${TABLE}.pitcherThrowHand ;;
  }

  dimension: rob0_end {
    type: number
    sql: ${TABLE}.rob0_end ;;
  }

  dimension: rob0_is_out {
    type: string
    sql: ${TABLE}.rob0_isOut ;;
  }

  dimension: rob0_outcome_description {
    type: string
    sql: ${TABLE}.rob0_outcomeDescription ;;
  }

  dimension: rob0_outcome_id {
    type: string
    sql: ${TABLE}.rob0_outcomeId ;;
  }

  dimension: rob0_start {
    type: string
    sql: ${TABLE}.rob0_start ;;
  }

  dimension: rob1_end {
    type: number
    sql: ${TABLE}.rob1_end ;;
  }

  dimension: rob1_is_out {
    type: string
    sql: ${TABLE}.rob1_isOut ;;
  }

  dimension: rob1_outcome_description {
    type: string
    sql: ${TABLE}.rob1_outcomeDescription ;;
  }

  dimension: rob1_outcome_id {
    type: string
    sql: ${TABLE}.rob1_outcomeId ;;
  }

  dimension: rob1_start {
    type: string
    sql: ${TABLE}.rob1_start ;;
  }

  dimension: rob2_end {
    type: number
    sql: ${TABLE}.rob2_end ;;
  }

  dimension: rob2_is_out {
    type: string
    sql: ${TABLE}.rob2_isOut ;;
  }

  dimension: rob2_outcome_description {
    type: string
    sql: ${TABLE}.rob2_outcomeDescription ;;
  }

  dimension: rob2_outcome_id {
    type: string
    sql: ${TABLE}.rob2_outcomeId ;;
  }

  dimension: rob2_start {
    type: string
    sql: ${TABLE}.rob2_start ;;
  }

  dimension: rob3_end {
    type: number
    sql: ${TABLE}.rob3_end ;;
  }

  dimension: rob3_is_out {
    type: string
    sql: ${TABLE}.rob3_isOut ;;
  }

  dimension: rob3_outcome_description {
    type: string
    sql: ${TABLE}.rob3_outcomeDescription ;;
  }

  dimension: rob3_outcome_id {
    type: string
    sql: ${TABLE}.rob3_outcomeId ;;
  }

  dimension: rob3_start {
    type: string
    sql: ${TABLE}.rob3_start ;;
  }

  dimension: season_id {
    type: string
    sql: ${TABLE}.seasonId ;;
  }

  dimension: season_type {
    type: string
    sql: ${TABLE}.seasonType ;;
  }

  dimension_group: start {
    type: time
    description: "bq-datetime"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.startTime ;;
  }

  dimension: starting_balls {
    type: number
    sql: ${TABLE}.startingBalls ;;
  }

  dimension: starting_outs {
    type: number
    sql: ${TABLE}.startingOuts ;;
  }

  dimension: starting_strikes {
    type: number
    sql: ${TABLE}.startingStrikes ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: strikes {
    type: number
    sql: ${TABLE}.strikes ;;
  }

  dimension_group: updated {
    type: time
    description: "bq-datetime"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updatedAt ;;
  }

  dimension: venue_capacity {
    type: number
    sql: ${TABLE}.venueCapacity ;;
  }

  dimension: venue_city {
    type: string
    sql: ${TABLE}.venueCity ;;
  }

  dimension: venue_id {
    type: string
    sql: ${TABLE}.venueId ;;
  }

  dimension: venue_market {
    type: string
    sql: ${TABLE}.venueMarket ;;
  }

  dimension: venue_name {
    type: string
    sql: ${TABLE}.venueName ;;
  }

  dimension: venue_outfield_distances {
    type: string
    sql: ${TABLE}.venueOutfieldDistances ;;
  }

  dimension: venue_state {
    type: string
    sql: ${TABLE}.venueState ;;
  }

  dimension: venue_surface {
    type: string
    sql: ${TABLE}.venueSurface ;;
  }

  dimension: venue_zip {
    type: number
    sql: ${TABLE}.venueZip ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      hitter_first_name,
      venue_name,
      hitter_last_name,
      pitcher_last_name,
      home_team_name,
      pitcher_first_name,
      away_team_name
    ]
  }
}
