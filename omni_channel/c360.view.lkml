# If necessary, uncomment the line below to include explore_source.
# include: "omni_channel.model.lkml"

view: c360 {
  derived_table: {
    persist_for: "24 hours"
    explore_source: customer_transaction_fact {
      column: cart_adds { field: customer_event_fact.cart_adds }
      column: event_count { field: customer_event_fact.event_count }
      column: purchases { field: customer_event_fact.purchases }
      column: session_count { field: customer_event_fact.session_count }
      column: count { field: customer_support_fact.count }
      column: curbside_transaction_count {}
      column: customer_id {}
      column: discounted_transaction_count {}
      column: first_purchase {}
      column: instore_transaction_count {}
      column: item_count {}
      column: l180_transaction_count {}
      column: l30_transaction_count {}
      column: l360_transaction_count {}
      column: l90_transaction_count {}
      column: last_purchase {}
      column: online_transaction_count {}
      column: return_count {}
      column: total_sales {}
      column: transaction_count {}
    }
  }
  dimension: cart_adds {
    type: number
  }
  dimension: event_count {
    type: number
  }
  dimension: purchases {
    type: number
  }
  dimension: session_count {
    type: number
  }
  dimension: count {
    label: "Support Calls"
    type: number
  }
  dimension: curbside_transaction_count {
    type: number
  }
  dimension: customer_id {
    primary_key: yes
    type: number
  }
  dimension: discounted_transaction_count {
    type: number
  }
  dimension: first_purchase {}
  dimension: instore_transaction_count {
    type: number
  }
  dimension: item_count {
    type: number
  }
  dimension: l180_transaction_count {
    type: number
  }
  dimension: l30_transaction_count {
    type: number
  }
  dimension: l360_transaction_count {
    type: number
  }
  dimension: l90_transaction_count {
    type: number
  }
  dimension: last_purchase {}
  dimension: online_transaction_count {
    type: number
  }
  dimension: return_count {
    type: number
  }
  dimension: total_sales {
    type: number
  }
  dimension: transaction_count {
    type: number
  }
  measure: customer_count {
    type: count
  }
}
