connection: "the_look" # Won added this

# Copyright (c) 2016 Snowplow Analytics Ltd. All rights reserved.
#
# This program is licensed to you under the Apache License Version 2.0,
# and you may not use this file except in compliance with the Apache License Version 2.0.
# You may obtain a copy of the Apache License Version 2.0 at http://www.apache.org/licenses/LICENSE-2.0.
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the Apache License Version 2.0 is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the Apache License Version 2.0 for the specific language governing permissions and limitations there under.
#
# Version:     0.1.0
#
# Authors:     Christophe Bogaert, Keane Robinson
# Copyright:   Copyright (c) 2016 Snowplow Analytics Ltd
# License:     Apache License Version 2.0


#connection: "redshift_pacific_time"
# Set the week start day to Sunday. Default is Monday
week_start_day: sunday

# include all views in this project
include: "/Views/*.view"

# include all include files
include: "/Includes/*.view"

# include all dashboards in this project
include: "/Dashboards/*.dashboard"

# Commenting out loading of AA tables until bug is fixed in GDXDSD-3584
# include all explores in this project
include: "/Explores/*.explore" #Won uncommenting

# hidden theme_cache explore supports suggest_explore for theme, subtheme, etc. filters
include: "//cmslite_metadata/Explores/themes_cache.explore.lkml"

# hidden cicy_cache explore supports suggest_explore for the geo filters
explore: geo_cache {
  hidden: yes
}

# hidden site_cache explore supports suggest_explore for the site filter
explore: site_cache {
  hidden: yes

  # access_filter: {
  #   field: page_urlhost
  #   user_attribute: urlhost
  # }
}

explore: page_views {
  persist_for: "10 minutes"
  # exclude when people are viewing files on locally downloaded or hosted copies of webpages
  #sql_always_where: (${page_urlhost} <> 'localhost' OR ${page_urlhost} IS NULL)
  #    AND ${page_url} NOT LIKE '%$/%'
  #    AND ${page_url} NOT LIKE 'file://%' AND ${page_url} NOT LIKE '-file://%' AND ${page_url} NOT LIKE 'mhtml:file://%' ;;

  # adding this access filter to be used by the CMS Lite embed code generator
  #    to allow for page-level dashboards
  # access_filter: {
  #   field: node_id
  #   user_attribute: node_id
  # }
  # access_filter: {
  #   field: page_urlhost
  #   user_attribute: no_editing_allowed
  # }
  # access_filter: {
  #   field: page_exclusion_filter
  #   user_attribute: exclusion_filter
  # }
  # access_filter: {
  #   field: app_id
  #   user_attribute: app_id
  # }

  # #access filter based on the first part of the URL (eg https://site.com/section/page.html)
  # access_filter: {
  #   field: page_section
  #   user_attribute: section
  # }
  # access_filter: {
  #   field: page_sub_section
  #   user_attribute: sub_section
  # }
  # access_filter: {
  #   field: cmslite_themes.theme_id
  #   user_attribute: theme
  # }

  # sql_always_where: ${page_url} NOT LIKE '%video.web.%' ;; -- Causing problems with video.gov analytics
  join: sessions {
    type: left_outer
    sql_on: ${sessions.session_id} = ${page_views.session_id};;
    relationship: many_to_many
  }

  join: users {
    sql_on: ${page_views.domain_userid} = ${users.domain_userid} ;;
    relationship: many_to_one
  }

  join: cmslite_themes {
    type: left_outer
    sql_on: ${page_views.node_id} = ${cmslite_themes.node_id} ;;
    relationship: one_to_one
  }

  join: gdx_analytics_whitelist {
    type: left_outer
    sql_on: ${page_views.page_urlhost} = ${gdx_analytics_whitelist.urlhost} ;;
    relationship: many_to_one
  }

  join: cmslite_metadata {
    type: left_outer
    sql_on: ${page_views.node_id} = ${cmslite_metadata.node_id};;
    relationship: one_to_one
  }

  join: myfs_component_name {
    type:  left_outer
    sql_on: ${page_views.page_view_id} = ${myfs_component_name.id} ;;
    relationship: one_to_one
  }

  join: myfs_estimates {
    type:  left_outer
    sql_on: ${page_views.page_view_id} = ${myfs_estimates.id} ;;
    relationship: one_to_one
  }

  join: performance_timing {
    type: left_outer
    sql_on: ${page_views.page_view_id} = ${performance_timing.page_view_id} ;;
    relationship: one_to_one
  }

}
explore: myfs_estimates {
  persist_for: "10 minutes"

  label: "MyFS Estimates"

  join: page_views {
    type:  left_outer
    sql_on: ${page_views.page_view_id} = ${myfs_estimates.id} ;;
    relationship: one_to_one
  }
  join: cmslite_themes {
    type: left_outer
    sql_on: ${page_views.node_id} = ${cmslite_themes.node_id} ;;
    relationship: one_to_one
  }
}

explore: chatbot {
  persist_for: "2 hours"

  label: "Chatbot"

  join: page_views {
    type:  left_outer
    sql_on: ${page_views.page_view_id} = ${chatbot.id} ;;
    relationship: one_to_one
  }
  join: cmslite_themes {
    type: left_outer
    sql_on: ${page_views.node_id} = ${cmslite_themes.node_id} ;;
    relationship: one_to_one
  }

  # access_filter: {
  #   field: page_views.page_urlhost
  #   user_attribute: urlhost
  # }
}

explore: chatbot_intents_and_clicks { #view that only includes intents, in hopes of making it faster
  label: "Chatbot Intents and Clicks"

  join: page_views {
    type:  left_outer
    sql_on: ${page_views.page_view_id} = ${chatbot_intents_and_clicks.id} ;;
    relationship: one_to_one
  }
  join: cmslite_themes {
    type: left_outer
    sql_on: ${page_views.node_id} = ${cmslite_themes.node_id} ;;
    relationship: one_to_one
  }

  # access_filter: {
  #   field: page_views.page_urlhost
  #   user_attribute: urlhost
  # }
}

explore: sessions {
  persist_for: "10 minutes"

  # exclude when people are viewing files on locally downloaded or hosted copies of webpages
  # Note that we are using first_page here instead of page, as there is no "page" for sessions
  #sql_always_where: (${first_page_urlhost} <> 'localhost' OR ${first_page_urlhost} IS NULL)
  #    AND ${first_page_url} NOT LIKE '%$/%'
  #    AND ${first_page_url} NOT LIKE 'file://%' AND ${first_page_url} NOT LIKE '-file://%' AND ${first_page_url} NOT LIKE 'mhtml:file://%';;

  join: users {
    sql_on: ${sessions.domain_userid} = ${users.domain_userid} ;;
    relationship: many_to_one
  }

  join: cmslite_themes {
    type: left_outer
    sql_on: ${sessions.first_page_node_id} = ${cmslite_themes.node_id} ;;
    relationship: one_to_one
  }

  # access_filter: {
  #   field: node_id
  #   user_attribute: node_id
  # }
  # access_filter: {
  #   field: first_page_urlhost
  #   user_attribute: urlhost
  # }
  # access_filter: {
  #   field: first_page_exclusion_filter
  #   user_attribute: exclusion_filter
  # }
  # access_filter: {
  #   field: app_id
  #   user_attribute: app_id
  # }

  # #access filter based on the first part of the URL (eg https://site.com/section/page.html)
  # access_filter: {
  #   field: first_page_section
  #   user_attribute: section
  # }
  # access_filter: {
  #   field: first_page_sub_section
  #   user_attribute: sub_section
  # }
  # access_filter: {
  #   field: cmslite_themes.theme_id
  #   user_attribute: theme
  # }
}

explore: users {
  persist_for: "10 minutes"



  # sql_always_where: ${first_page_url} NOT LIKE '%video.web.%' ;; -- Causing problems with Dan's video analytics
}

explore: clicks{
  persist_for: "10 minutes"

  # exclude when people are viewing files on locally downloaded or hosted copies of webpages
  #sql_always_where: (${page_urlhost} <> 'localhost' OR ${page_urlhost} IS NULL)
  #    AND ${page_url} NOT LIKE '%$/%'
  #    AND ${page_url} NOT LIKE 'file://%' AND ${page_url} NOT LIKE '-file://%' AND ${page_url} NOT LIKE 'mhtml:file://%' ;;

  join: cmslite_themes {
    type: left_outer
    sql_on: ${clicks.node_id} = ${cmslite_themes.node_id} ;;
    relationship: one_to_one
  }
  # access_filter: {
  #   field: node_id
  #   user_attribute: node_id
  # }
  # access_filter: {
  #   field: page_urlhost
  #   user_attribute: urlhost
  # }
  # access_filter: {
  #   field: page_exclusion_filter
  #   user_attribute: exclusion_filter
  # }
  # access_filter: {
  #   field: app_id
  #   user_attribute: app_id
  # }
  # #access filter based on the first part of the URL (eg https://site.com/section/page.html)
  # access_filter: {
  #   field: page_section
  #   user_attribute: section
  # }
  # access_filter: {
  #   field: page_sub_section
  #   user_attribute: sub_section
  # }
  # access_filter: {
  #   field: cmslite_themes.theme_id
  #   user_attribute: theme
  # }
}

explore: searches {
  persist_for: "10 minutes"
  # exclude when people are viewing files on locally downloaded or hosted copies of webpages
  #sql_always_where: (${page_urlhost} <> 'localhost' OR ${page_urlhost} IS NULL)
  #    AND ${page_url} NOT LIKE '%$/%'
  #    AND ${page_url} NOT LIKE 'file://%' AND ${page_url} NOT LIKE '-file://%' AND ${page_url} NOT LIKE 'mhtml:file://%';;

  join: cmslite_themes {
    type: left_outer
    sql_on: ${searches.node_id} = ${cmslite_themes.node_id} ;;
    relationship: one_to_one
  }
  # access_filter: {
  #   field: node_id
  #   user_attribute: node_id
  # }
  # access_filter: {
  #   field: page_urlhost
  #   user_attribute: urlhost
  # }
  # access_filter: {
  #   field: page_exclusion_filter
  #   user_attribute: exclusion_filter
  # }
  # access_filter: {
  #   field: app_id
  #   user_attribute: app_id
  # }

  # #access filter based on the first part of the URL (eg https://site.com/section/page.html)
  # access_filter: {
  #   field: page_section
  #   user_attribute: section
  # }
  # access_filter: {
  #   field: page_sub_section
  #   user_attribute: sub_section
  # }
  # access_filter: {
  #   field: cmslite_themes.theme_id
  #   user_attribute: theme
  # }


 }

explore: form_action {
  label: "Form Actions"

  join: page_views {
    type:  left_outer
    sql_on: ${page_views.page_view_id} = ${form_action.page_view_id} ;;
    relationship: one_to_one
  }
  join: cmslite_themes {
    type: left_outer
    sql_on: ${form_action.formid} = ${cmslite_themes.node_id} ;;
    relationship: one_to_one
  }

  # access_filter: {
  #   field: form_action.page_urlhost
  #   user_attribute: urlhost
  # }
}
explore: form_error {
  label: "Form Errors"

  join: page_views {
    type:  left_outer
    sql_on: ${page_views.page_view_id} = ${form_error.page_view_id} ;;
    relationship: one_to_one
  }
  join: cmslite_themes {
    type: left_outer
    sql_on: ${form_error.formid} = ${cmslite_themes.node_id} ;;
    relationship: one_to_one
  }

  # access_filter: {
  #   field: form_error.page_urlhost
  #   user_attribute: urlhost
  # }
}

explore: cmslite_metadata {
  persist_for: "60 minutes"

  # access_filter: {
  #   field: node_id
  #   user_attribute: node_id
  # }
}

explore: esb_se_pathways {
  persist_for: "60 minutes"
  label: "ESB SE Pathways"

  join: page_views {
    type: left_outer
    sql_on: ${page_views.page_urlquery} LIKE 'id=' + ${esb_se_pathways.id} + '%';;
    relationship: many_to_one
  }
  join: cmslite_themes {
    type: left_outer
    sql_on: ${page_views.node_id} = ${cmslite_themes.node_id} ;;
    relationship: one_to_one
  }
}

explore: youtube_embed_video {
  persist_for: "60 minutes"

  join: page_views {
    type: left_outer
    sql_on: ${page_views.page_view_id} = ${youtube_embed_video.page_view_id} ;;
    relationship: many_to_one
  }
  # access_filter: {
  #   field: page_views.page_urlhost
  #   user_attribute: urlhost
  # }
  join: cmslite_themes {
    type: left_outer
    sql_on: ${page_views.node_id} = ${cmslite_themes.node_id} ;;
    relationship: one_to_one
  }
}

explore: workbc_careertoolkit {
  label: "WorkBC Career Transition Toolkit"
  persist_for: "2 hours"

  join: page_views {
    type: left_outer
    sql_on: ${page_views.page_view_id} = ${workbc_careertoolkit.page_view_id} ;;
    relationship: many_to_one
  }
  join: cmslite_themes {
    type: left_outer
    sql_on: ${page_views.node_id} = ${cmslite_themes.node_id} ;;
    relationship: one_to_one
  }
  # access_filter: {
  #   field: page_views.page_urlhost
  #   user_attribute: urlhost
  # }
}
explore: forms {
  persist_for: "60 minutes"

  join: page_views {
    type: left_outer
    sql_on: ${page_views.page_view_id} = ${forms.page_view_id} ;;
    relationship: many_to_one
  }
  join: cmslite_themes {
    type: left_outer
    sql_on: ${page_views.node_id} = ${cmslite_themes.node_id} ;;
    relationship: one_to_one
  }
}

explore: asset_downloads {
  persist_for: "60 minutes"

  # access_filter: {
  #   field: asset_downloads.asset_host
  #   user_attribute: urlhost
  # }

  join: cmslite_metadata {
    type: left_outer
    sql_on: ${asset_downloads.asset_url} = ${cmslite_metadata.hr_url} ;;
    relationship: one_to_one
  }
}

explore: performance_timing {
  persist_for: "60 minutes"

  # access_filter: {
  #   field: page_views.page_urlhost
  #   user_attribute: urlhost
  # }

  join: page_views {
    type:  left_outer
    sql_on: ${performance_timing.page_view_id} = ${page_views.page_view_id} ;;
    relationship: one_to_one
  }

  join: cmslite_themes {
    type: left_outer
    sql_on: ${page_views.node_id} = ${cmslite_themes.node_id} ;;
    relationship: one_to_one
  }
}


### Datagroups

datagroup: aa_datagroup_cmsl_loaded {
  label: "Updates with todays date at 4:55AM"
  description: "Triggers CMS Lite Metadata dependent Aggregate Aware tables to rebuild after each new day and after nightly cmslitemetadata microservice has run."
  # sql_trigger: SELECT DATE(timezone('America/Vancouver', now() - interval '295 minutes')) ;;
  sql_trigger:SELECT FORMAT_TIMESTAMP('%F', CURRENT_TIMESTAMP(), 'America/Los_Angeles') ;; #Won
}
