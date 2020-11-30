# If necessary, uncomment the line below to include explore_source.
# include: "omni_channel.model.lkml"

view: customer_event_fact {
  derived_table: {
    explore_source: omni_channel_events {
      column: customer_id {}
      column: cart_adds {}
      column: event_count {}
      column: purchases {}
      column: session_count {}
    }
  }
  dimension: customer_id {
    type: number
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
}
