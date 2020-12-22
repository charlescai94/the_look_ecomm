view: customers {
  sql_table_name: `looker-private-demo.retail.customers` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
    group_label: "Address Info"
    link: {
      url: "/dashboards/ya1knzVmVzuw8UHoe4VqVt?Address=%22{{value | encode_uri}}"
      label: "Drill into this address"
      icon_url: "https://img.icons8.com/cotton/2x/worldwide-location.png"
    }
  }

  dimension: address_street_view {
    type: string
    group_label: "Address Info"
    sql: ${address} ;;
    html: <img src="https://maps.googleapis.com/maps/api/streetview?size=700x400&location={{value | encode_uri}}&fov=120&key=AIzaSyD7BvCbKqjStBl7r6AmDu1p8yGF-IxtFLs" ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.AGE ;;
  }

  dimension: city {
    type: string
    group_label: "Address Info"
    sql: ${TABLE}.CITY ;;
  }

  dimension: country {
    type: string
    group_label: "Address Info"
    map_layer_name: countries
    sql: ${TABLE}.COUNTRY ;;
  }

  dimension_group: registered {
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

  dimension: email {
    type: string
    group_label: "Address Info"
    sql: ${TABLE}.EMAIL ;;
    tags: ["email"]

    link: {
      label: "User Lookup Dashboard"
      url: "/dashboards/ayalascustomerlookupdb?Email={{ value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
    action: {
      label: "Email Promotion to Customer"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "https://sendgrid.com/favicon.ico"
      param: {
        name: "some_auth_code"
        value: "abc123456"
      }
      form_param: {
        name: "Subject"
        required: yes
        default: "Thank you {{ users.name._value }}"
      }
      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "Dear {{ users.first_name._value }},

        Thanks for your loyalty to the Look.  We'd like to offer you a 10% discount
        on your next purchase!  Just use the code LOYAL when checking out!

        Your friends at the Look"
      }
    }
    required_fields: [name, first_name]
  }

  dimension: first_name {
    type: string
    hidden: yes
    sql: ${TABLE}.FIRST_NAME ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.GENDER ;;
  }

  dimension: last_name {
    type: string
    hidden: yes
    sql: ${TABLE}.LAST_NAME ;;
  }

  dimension: name {
    type: string
    sql: CONCAT(${first_name}, " ", ${last_name}) ;;
  }

  dimension: latitude {
    hidden: yes
    type: number
    sql: ${TABLE}.LATITUDE ;;
  }

  dimension: longitude {
    hidden: yes
    type: number
    sql: ${TABLE}.LONGITUDE ;;
  }

  dimension: location {
    type: location
    group_label: "Address Info"
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: state {
    type: string
    group_label: "Address Info"
    sql: ${TABLE}.STATE ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.TRAFFIC_SOURCE ;;
  }

  dimension: postcode {
    type: zipcode
    group_label: "Address Info"
    sql: ${TABLE}.ZIP ;;
  }

  ##### CUSTOM DIMENSIONS #####

  filter: address_comparison_filter {
    type: string
    suggest_dimension: customers.address
  }

  dimension: address_comparison {
    type: string
    group_label: "Address Info"
    sql: CASE
      WHEN {% condition address_comparison_filter %} ${address} {% endcondition %} THEN ${address}
      ELSE 'vs Average'
    END;;
    order_by_field: address_comparison_order
  }

  dimension: address_comparison_order {
    hidden: yes
    type: number
    sql: CASE
      WHEN {% condition address_comparison_filter %} ${address} {% endcondition %} THEN 1
      ELSE 2
    END;;
  }
}
