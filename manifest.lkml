project_name: "the_look"

application: ef_kthub_lab {
  label: "My first extension"
  url: "http://localhost:8080/bundle.js"
  entitlements: {

    local_storage: yes
    navigation: yes
    new_window: yes
    core_api_methods: ["run_inline_query", "all_connections","search_folders", "me", "all_looks", "run_look","create_sql_query","run_sql_query","query"]
    use_embeds: yes
  }
}
