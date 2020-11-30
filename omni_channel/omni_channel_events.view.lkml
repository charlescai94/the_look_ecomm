view: omni_channel_events {
  sql_table_name: `looker-private-demo.retail.omni_channel_events`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: browser {
    type: string
    sql: ${TABLE}.BROWSER ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.CUSTOMER_ID ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.EVENT_TYPE ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.IP_ADDRESS ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}.OS ;;
  }

  dimension: sequence_number {
    type: number
    sql: ${TABLE}.SEQUENCE_NUMBER ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.SESSION_ID ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.TRAFFIC_SOURCE ;;
  }

  dimension: uri {
    type: string
    sql: ${TABLE}.URI ;;
  }

  measure: event_count {
    type: count
  }

  measure: cart_adds {
    filters: [event_type: "Cart"]
    type: count
  }

  measure: purchases {
    filters: [event_type: "Purchase"]
    type: count
  }

  measure: session_count {
    type: count_distinct
    sql: ${session_id} ;;
  }
}
