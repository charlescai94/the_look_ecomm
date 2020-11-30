view: omni_channel_transactions {
  sql_table_name: `looker-private-demo.retail.omni_channel_transactions`
    ;;

  measure: first_purchase {
    type: string
    sql: min(${transaction_date}) ;;
  }

  measure: last_purchase {
    type: string
    sql: max(${transaction_date}) ;;
  }

  measure: transaction_count {
    type: count
  }

  measure: l30_transaction_count {
    type: count
    filters: [last_30: "Yes"]
  }

  measure: l90_transaction_count {
    type: count
    filters: [last_90: "Yes"]
  }

  measure: l180_transaction_count {
    type: count
    filters: [last_180: "Yes"]
  }

  measure: l360_transaction_count {
    type: count
    filters: [last_360: "Yes"]
  }

  measure: return_count {
    type: count
    filters: [is_returned: "Yes"]
  }

  measure: discounted_transaction_count {
    type: count
    filters: [is_discounted: "Yes"]
  }

  measure: online_transaction_count {
    filters: [purchase_channel: "Online"]
    type: count
  }

  measure: curbside_transaction_count {
    type: count
    filters: [fulfillment_channel: "In-store Pickup"]
  }

  measure: instore_transaction_count {
    filters: [purchase_channel: "In-store"]
    type: count
  }

  dimension: is_discounted {
    type: yesno
    sql: ${offer_type} is not null ;;
  }

  dimension: is_returned {
    type: yesno
    sql: ${returned_raw} is not null ;;
  }

  dimension: last_30 {
    type: yesno
    sql: ${transaction_raw} >= ((TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_ADD(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY), INTERVAL -29 DAY)), 'America/Los_Angeles'))) AND ${transaction_raw} < ((TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY), INTERVAL -29 DAY), INTERVAL 30 DAY)), 'America/Los_Angeles'))) ;;
  }

  dimension: last_90 {
    type: yesno
    sql: ${transaction_raw} >= ((TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_ADD(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY), INTERVAL -89 DAY)), 'America/Los_Angeles'))) AND ${transaction_raw} < ((TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY), INTERVAL -89 DAY), INTERVAL 90 DAY)), 'America/Los_Angeles'))) ;;
  }

  dimension: last_180 {
    type: yesno
    sql: ${transaction_raw} >= ((TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_ADD(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY), INTERVAL -179 DAY)), 'America/Los_Angeles'))) AND ${transaction_raw} < ((TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY), INTERVAL -179 DAY), INTERVAL 180 DAY)), 'America/Los_Angeles'))) ;;
  }

  dimension: last_360 {
    type: yesno
    sql: ${transaction_raw} >= ((TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_ADD(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY), INTERVAL -359 DAY)), 'America/Los_Angeles'))) AND ${transaction_raw} < ((TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY), INTERVAL -359 DAY), INTERVAL 360 DAY)), 'America/Los_Angeles'))) ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: delivered {
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
    sql: ${TABLE}.delivered_date ;;
  }

  dimension: fulfillment_channel {
    type: string
    sql: ${TABLE}.fulfillment_channel ;;
  }

  dimension: offer_type {
    type: string
    sql: ${TABLE}.offer_type ;;
  }

  dimension: purchase_channel {
    type: string
    sql: ${TABLE}.purchase_channel ;;
  }

  dimension_group: returned {
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
    sql: ${TABLE}.returned_date ;;
  }

  dimension_group: shipped {
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
    sql: ${TABLE}.shipped_date ;;
  }

  dimension: store_latitude {
    type: number
    sql: ${TABLE}.store_latitude ;;
  }

  dimension: store_longitude {
    type: number
    sql: ${TABLE}.store_longitude ;;
  }

  dimension: store_name {
    type: string
    sql: ${TABLE}.store_name ;;
  }

  dimension: store_sq_ft {
    type: number
    sql: ${TABLE}.Store_sq_ft ;;
  }

  dimension: store_state {
    type: string
    sql: ${TABLE}.store_state ;;
  }

  dimension_group: transaction {
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
    sql: ${TABLE}.transaction_date ;;
  }

  dimension: transaction_details {
    hidden: yes
    sql: ${TABLE}.transaction_details ;;
  }

  dimension: transaction_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.transaction_id ;;
  }
}

view: omni_channel_transactions__transaction_details {
  dimension: gross_margin {
    type: number
    sql: ${TABLE}.gross_margin ;;
  }

  dimension: product_area {
    type: string
    sql: ${TABLE}.product_area ;;
  }

  dimension: product_brand {
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.product_category ;;
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.product_department ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_sku {
    primary_key: yes
    type: string
    sql: ${TABLE}.product_sku ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: total_sales {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: item_count {
    type: count
  }
}
