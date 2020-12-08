connection: "looker-private-demo"

include: "/omni_channel/*.view.lkml"                # include all views in the views/ folder in this project

explore: omni_channel_transactions {
  join: omni_channel_transactions__transaction_details {
    type: left_outer
    relationship: one_to_many
    sql: LEFT JOIN UNNEST(${omni_channel_transactions.transaction_details}) as omni_channel_transactions__transaction_details  ;;
  }
  join: c360 {
    type: inner
    relationship: many_to_one
    sql_on: ${omni_channel_transactions.customer_id} = ${c360.customer_id} ;;
  }
}

explore: omni_channel_events {}

explore: omni_channel_support_calls {}


explore: customer_transaction_fact {
  join: customer_event_fact {
    type: left_outer
    relationship: one_to_one
    sql_on: ${customer_event_fact.customer_id} = ${customer_transaction_fact.customer_id} ;;
  }
  join: customer_support_fact {
    type: left_outer
    relationship: one_to_one
    sql_on: ${customer_support_fact.client_id} = ${customer_transaction_fact.customer_id} ;;
  }
}
