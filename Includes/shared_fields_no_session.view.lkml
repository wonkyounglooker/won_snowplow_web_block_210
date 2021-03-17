view: shared_fields_no_session {

# browser_view_height is not in Sessions

  dimension: browser_view_height {
    description: "The browser viewport height in pixels."
    type: number
    # sql: ${TABLE}.br_viewheight ;;
    sql: ${TABLE}.user_id ;; #Won
    group_label: "Browser"
  }

  # browser_view_width is not in Sessions
  dimension: browser_view_width {
    description: "The browser viewport width in pixels."
    type: number
    # sql: ${TABLE}.br_viewwidth ;;
    sql: ${TABLE}.user_id ;; #Won
    group_label: "Browser"
  }

  # dvce_screenheight is not in sessions
  dimension: devices_screen_height {
    description: "The device screen height in pixels."
    type: number
    # sql: ${TABLE}.dvce_screenheight ;;
    sql: ${TABLE}.user_id ;; #Won
    group_label: "Device"
  }

  # dvce_screenwidth is not in sessions
  dimension: devices_screen_width {
    description: "The device screen width in pixels."
    type: number
    # sql: ${TABLE}.dvce_screenwidth ;;
    sql: ${TABLE}.user_id ;; #Won
    group_label: "Device"
  }

  dimension: os_version {
    type: string
    # sql: ${TABLE}.os_version ;;
    sql: ${TABLE}.status ;; #Won
    group_label: "OS"
  }

  ### Page
  dimension: page_height {
    type: number
    # sql: ${TABLE}.doc_height ;;
    sql: ${TABLE}.user_id ;; #Won
    group_label: "Page"
  }

  dimension: page_title {
    description: "The web page title."
    type: string
    # sql: ${TABLE}.page_title ;;
    sql: ${TABLE}.status ;; #Won
    group_label: "Page"
  }

  dimension: page_url {
    description: "The web page URL."
    type: string
    # sql: ${TABLE}.page_url ;;
    sql: ${TABLE}.status ;; #Won
    group_label: "Page"
    # link: {
    #   label: "Visit Page"
    #   url: "{{ value }}"
    #   icon_url: "https://looker.com/favicon.ico"
    # }
  }

  dimension: page_section {
    description: "The identifier for a section of a website. The part of the URL after the domain before the next '/'"
    type: string
    # sql: ${TABLE}.page_section;;
    sql: ${TABLE}.status ;; #Won
    group_label: "Page"
  }

  dimension: page_sub_section {
    description: "The identifier for a subsection of a website. The part of the URL between the second and third '/' in the path"
    type: string
    # sql: ${TABLE}.page_subsection ;;
    sql: ${TABLE}.status ;; #Won
    group_label: "Page"
  }

  dimension: page_workbc_url {
    description: "The identifier for a subsection of a website. The part of the URL between the second and third '/' in the path"
    type: string
    # sql: CASE WHEN ${TABLE}.page_display_url LIKE 'https://www.workbc.ca/Jobs-Careers/Employers%' THEN 'https://www.workbc.ca/Jobs-Careers/Employers/*'
    #   ELSE ${TABLE}.page_display_url
    #   END ;;
    sql: ${TABLE}.status ;; #Won
    group_label: "Page"
  }
    dimension: page_workbc_joburl {
      description: "The identifier for a subsection of a website. The part of the URL between the second and third '/' in the path"
      type: string
      # sql: CASE WHEN ${TABLE}.page_url LIKE '%&%' THEN SPLIT_PART(${TABLE}.page_url, '&', 1)
      #     ELSE ${TABLE}.page_url
      #   END ;;
      sql: ${TABLE}.status ;; #Won
      group_label: "Page"
    }

  dimension: page_section_exclude {
    description: "An exclusion filter for the identifier for a section of a website used to block sections of a site matching the pattern below.. The part of the URL after the domain before the next '/'."
    type: string
    # sql: CASE WHEN SPLIT_PART(${TABLE}.page_urlpath,'/',2) IN ('empr','agri','mirr','flnrord','env','eao','csnr') THEN '1' ELSE '0' END ;;
    sql: ${TABLE}.status ;; #Won
    group_label: "Page"
  }

  dimension: page_urlquery {
    description: "The querystring of the URL."
    type: string
    # sql: ${TABLE}.page_urlquery ;;
    sql: ${TABLE}.status ;; #Won
    group_label: "Page"
  }

  dimension: page_width {
    type: number
    # sql: ${TABLE}.doc_width ;;
    sql: ${TABLE}.user_id ;; #Won
    group_label: "Page"
  }

  dimension: page_engagement {
    description: "The identifier for an engagement on engage.gov.bc.ca."
    type: string
    # sql: CASE WHEN ${TABLE}.page_urlpath LIKE '/govtogetherbc/consultation/%'
    #   THEN SPLIT_PART(${TABLE}.page_urlpath,'/',4)
    #   ELSE SPLIT_PART(${TABLE}.page_urlpath,'/',2) END ;;
    sql: ${TABLE}.status ;; #Won
    group_label: "Page"
  }

  dimension: page_exclusion_filter {
    description: "The URL matches the exclusion filter. For example subsites of the NRS intranet."
    type: string
    # sql: ${TABLE}.page_exclusion_filter;;
    sql: ${TABLE}.status ;; #Won
    group_label: "Page"
  }

  dimension: search_field {
    description: "The raw search query parameters"
    type: string
    # sql: decode(split_part(${page_url},'/search/',2),'%20', ' ');;
    # sql: REPLACE(split_part(${page_url},'/search/',2), '%20', ' ')
      # ;;
    sql: ${TABLE}.status ;; #Won
  }

  dimension: page_display_url {
    label: "Page Display URL"
    # when editing also see clicks.truncated_target_url_nopar_case_insensitive
    description: "Cleaned URL of the page without query string or standard file names like index.html"
    # sql: ${TABLE}.page_display_url ;;
    sql: ${TABLE}.status ;; #Won
    group_label: "Page"
    drill_fields: [page_views.page_referrer,page_views.page_url]
    # link: {
    #   label: "Visit Page"
    #   url: "{{ value }}"
    #   icon_url: "https://looker.com/favicon.ico"
    # }
  }

  dimension: page_urlpath {
    description: "The path of the page, after the domain."
    type: string
    # sql: ${TABLE}.page_urlpath ;;
    sql: ${TABLE}.status ;; #Won
    group_label: "Page"
  }

  dimension: page_urlhost {
    description: "The web page domain or host."
    type: string
    # sql: ${TABLE}.page_urlhost ;;
    sql: ${TABLE}.status ;; #Won
    suggest_explore: site_cache
    suggest_dimension: site_cache.page_urlhost
    group_label: "Page"
  }

  dimension: page_url_scheme {
    type: string
    # sql: ${TABLE}.page_urlscheme ;;
    sql: ${TABLE}.status ;; #Won
    group_label: "Page"
    hidden: yes
  }

# TIBC dimensions
  dimension: tibc_section {
    description: "The identifier for a section of a website. The part of the URL after the domain before the next '/'"
    type: string
    label: "TIBC Section"
    drill_fields: [page_display_url]
    # sql: CASE
    #         WHEN ${TABLE}.page_section = '' THEN 'Home'
    #         WHEN ${TABLE}.page_section IN ('invest','invest-kr','Invest') THEN 'Invest'
    #         WHEN ${TABLE}.page_section IN ('buy','Buy') THEN 'Buy'
    #         WHEN ${TABLE}.page_section IN ('global','Global') THEN 'Global'
    #         WHEN ${TABLE}.page_section IN ('export','Export') THEN 'Export'
    #         ELSE 'Other' END ;;
    sql: ${TABLE}.status ;; #Won
    group_label: "TIBC"
    order_by_field: tibc_section_sort
  }

  dimension: tibc_section_sort {
    label: "TIBC Section Sort"
    type: string
    hidden: yes
    description: "The identifier for a section of a website. The part of the URL after the domain before the next '/'"
    # sql: CASE WHEN ${TABLE}.page_section = '' THEN '00-Home'
    #         WHEN ${TABLE}.page_section IN ('invest','invest-kr','Invest') THEN 'Invest'
    #         WHEN ${TABLE}.page_section IN ('buy','Buy') THEN 'Buy'
    #         WHEN ${TABLE}.page_section IN ('global','Global') THEN 'Global'
    #         WHEN ${TABLE}.page_section IN ('export','Export') THEN 'Export'
    #         ELSE 'ZZZZZOther' END ;;
    sql: ${TABLE}.status ;; #Won
    group_label: "TIBC"
  }

# Custom Dimensions for Welcome BC
  dimension: welcomebc_page_section {
    label: "WelcomeBC Page Section"
    type: string
    # sql: CASE
    #       WHEN lower(SPLIT_PART(SPLIT_PART(${TABLE}.page_urlpath,'/',2),'.aspx',1)) = 'choose-b-c' THEN 'Choose B.C.'
    #       WHEN lower(SPLIT_PART(SPLIT_PART(${TABLE}.page_urlpath,'/',2),'.aspx',1)) = 'immigrate-to-b-c' THEN 'Immigrate to B.C.'
    #       WHEN lower(SPLIT_PART(SPLIT_PART(${TABLE}.page_urlpath,'/',2),'.aspx',1)) = 'start-your-life-in-b-c' THEN 'Start Your Life in B.C.'
    #       WHEN lower(SPLIT_PART(SPLIT_PART(${TABLE}.page_urlpath,'/',2),'.aspx',1)) = 'work-or-study-in-b-c' THEN 'Work or Study in B.C.'
    #       WHEN lower(SPLIT_PART(SPLIT_PART(${TABLE}.page_urlpath,'/',2),'.aspx',1)) = 'employer-resources' THEN 'Employer Resources'
    #       WHEN lower(SPLIT_PART(SPLIT_PART(${TABLE}.page_urlpath,'/',2),'.aspx',1)) = 'resources-for' THEN 'Resources For'
    #       ELSE NULL
    #     END;;
    sql: ${TABLE}.status ;; #Won
    drill_fields: [page_display_url]
    group_label: "WelcomeBC Dimensions"
  }

  dimension: welcomebc_page_topic {
    label: "WelcomeBC Page Topic"
    # sql: CASE
    #       WHEN SPLIT_PART(SPLIT_PART(lower(${TABLE}.page_display_url), '//', 2), '.aspx', 1) in
    #       ('www.welcomebc.ca/employer-resources',
    #         'www.welcomebc.ca/employer-resources/b-c-provincial-nominee-program-(pnp)-for-employer',
    #         'www.welcomebc.ca/employer-resources/b-c-provincial-nominee-program-for-employer/b-c-provincial-nominee-program-for-employers',
    #         'www.welcomebc.ca/employer-resources/immigration-supports-in-b-c-global-skills-strategy',
    #         'www.welcomebc.ca/employer-resources/immigration-supports-in-b-c-global-skills-strategy/immigration-supports-in-b-c-global-skills-strategy',
    #         'www.welcomebc.ca/employer-resources/federal-immigration-programs',
    #         'www.welcomebc.ca/employer-resources/federal-immigration-programs/about-federal-immigration-programs',
    #         'www.welcomebc.ca/employer-resources/hire-internationally-trained-workers',
    #         'www.welcomebc.ca/employer-resources/hire-internationally-trained-workers/why-hire-internationally-trained-workers',
    #         'www.welcomebc.ca/employer-resources/hire-internationally-trained-workers/recruit-internationally-trained-workers',
    #         'www.welcomebc.ca/employer-resources/hire-internationally-trained-workers/retain-your-workers',
    #         'www.welcomebc.ca/employer-resources/hire-temporary-foreign-workers',
    #         'www.welcomebc.ca/employer-resources/hire-temporary-foreign-workers/temporary-foreign-worker-program ',
    #         'www.welcomebc.ca/employer-resources/hire-temporary-foreign-workers/international-mobility-program ',
    #         'www.welcomebc.ca/immigrate-to-b-c/b-c-provincial-nominee-program/bc-pnp-tech-pilot',
    #         'www.welcomebc.ca/immigrate-to-b-c/b-c-provincial-nominee-program/employer-requirements') THEN 'Employer Related'
    #       WHEN SPLIT_PART(SPLIT_PART(lower(${TABLE}.page_display_url), '//', 2), '.aspx', 1)  in
    #       ('www.welcomebc.ca/immigrate-to-b-c/bc-pnp-skills-immigration/international-graduate',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-skills-immigration/international-post-graduate',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-express-entry-b-c/eebc-international-graduate',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-express-entry-b-c/eebc-international-post-graduate',
    #         'www.welcomebc.ca/start-your-life-in-b-c/daily-life/education-in-british-columbia',
    #         'www.welcomebc.ca/work-or-study-in-b-c/study-in-b-c',
    #         'www.welcomebc.ca/work-or-study-in-b-c/study-in-b-c/international-students',
    #         'www.welcomebc.ca/work-or-study-in-b-c/study-in-b-c/training-and-education',
    #         'www.welcomebc.ca/work-or-study-in-b-c/extend-your-stay-in-b-c/extend-your-study-permit',
    #         'www.welcomebc.ca/resources-for/international-students',
    #         'www.welcomebc.ca/resources-for/international-students/come-to-b-c-to-study') THEN 'Student Related'
    #       WHEN SPLIT_PART(SPLIT_PART(lower(${TABLE}.page_display_url), '//', 2), '.aspx', 1)  in
    #       ('www.welcomebc.ca/immigrate-to-b-c/b-c-provincial-nominee-program/invitations-to-apply',
    #         'www.welcomebc.ca/immigrate-to-b-c/b-c-provincial-nominee-program/documents',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-skills-immigration/skilled-worker',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-skills-immigration/health-care-professional',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-skills-immigration/entre-level-and-semi-skilled',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-express-entry-b-c/eebc-skilled-worker',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-express-entry-b-c/express-entry-health-care-professional',
    #         'www.welcomebc.ca/start-your-life-in-b-c/services-and-support/for-temporary-residents',
    #         'www.welcomebc.ca/work-or-study-in-b-c/work-in-b-c',
    #         'www.welcomebc.ca/work-or-study-in-b-c/work-in-b-c/find-a-job-in-b-c',
    #         'www.welcomebc.ca/work-or-study-in-b-c/work-in-b-c/foreign-qualifications-recognition-(fqr)',
    #         'www.welcomebc.ca/work-or-study-in-b-c/work-in-b-c/temporary-foreign-workers',
    #         'www.welcomebc.ca/work-or-study-in-b-c/work-in-b-c/know-your-rights-as-a-temporary-foreign-worker',
    #         'www.welcomebc.ca/work-or-study-in-b-c/work-in-b-c/workplace-information',
    #         'www.welcomebc.ca/work-or-study-in-b-c/work-in-b-c/employment-language-programs',
    #         'www.welcomebc.ca/work-or-study-in-b-c/your-career-in-b-c',
    #         'www.welcomebc.ca/work-or-study-in-b-c/extend-your-stay-in-b-c',
    #         'www.welcomebc.ca/work-or-study-in-b-c/extend-your-stay-in-b-c/extend-your-stay-in-b-c',
    #         'www.welcomebc.ca/work-or-study-in-b-c/extend-your-stay-in-b-c/transition-to-permanent-residence',
    #         'www.welcomebc.ca/work-or-study-in-b-c/extend-your-stay-in-b-c/support-for-temporary-foreign-residents',
    #         'www.welcomebc.ca/resources-for/temporary-foreign-workers-(tfws)',
    #         'www.welcomebc.ca/resources-for/temporary-foreign-workers-(tfws)/find-out-about-working-temporarily-in-b-c') THEN 'Worker Related'
    #       WHEN SPLIT_PART(SPLIT_PART(lower(${TABLE}.page_display_url), '//', 2), '.aspx', 1)  in
    #       ('www.welcomebc.ca/immigrate-to-b-c/b-c-provincial-nominee-program',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-skills-immigration',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-express-entry-b-c',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-entrepreneur-immigration',
    #         'www.welcomebc.ca/immigrate-to-b-c/other-immigration-options-and-information') THEN 'BC PNP 3rd-Level Pages'
    #       ELSE NULL
    #     END;;
    sql: ${TABLE}.status ;; #Won
    group_label: "WelcomeBC Dimensions"
    drill_fields: [page_display_url]
  }


  dimension: pnp_page_display_url {
    label: "PNP Page Display URL"
    description: "Cleaned URL of the page without specific case, form and reference numbers"
    type: string
    # sql: CASE  WHEN split_part(${TABLE}.page_display_url, '/', 5) similar to '[0-9]+' AND split_part(${TABLE}.page_display_url, '/', 7) similar to '[0-9]+'
    #       THEN REPLACE(REPLACE(${TABLE}.page_display_url, split_part(${TABLE}.page_display_url, '/', 7), 'XXXXXX'), split_part(${TABLE}.page_display_url, '/', 5), 'XXXXXX')
    #       WHEN split_part(${TABLE}.page_display_url, '/', 5) similar to '[0-9]+'
    #       THEN REPLACE(${TABLE}.page_display_url, split_part(${TABLE}.page_display_url, '/', 5), 'XXXXXX')
    #       WHEN split_part(${TABLE}.page_display_url, '/', 6) similar to '[0-9]+'
    #       THEN REPLACE(${TABLE}.page_display_url, split_part(${TABLE}.page_display_url, '/', 6), 'XXXXXX')
    #       WHEN split_part(${TABLE}.page_display_url, '/', 7) similar to '[0-9]+'
    #       THEN REPLACE(${TABLE}.page_display_url, split_part(${TABLE}.page_display_url, '/', 7), 'XXXXXX')
    #       ELSE ${TABLE}.page_display_url
    #     END;;
    sql: ${TABLE}.status ;; #Won
    group_label: "WelcomeBC Dimensions"
    drill_fields: [page_display_url]
  }

  dimension: welcomebc_page_referrer_section {
    label: "WelcomeBC Page Referrer Section"
    type: string
    # sql: CASE
    #       WHEN lower(SPLIT_PART(SPLIT_PART(SPLIT_PART(${TABLE}.page_referrer,'//',2), '/', 2), '.aspx', 1)) = 'choose-b-c' THEN 'Choose B.C.'
    #       WHEN lower(SPLIT_PART(SPLIT_PART(SPLIT_PART(${TABLE}.page_referrer,'//',2), '/', 2), '.aspx', 1)) = 'immigrate-to-b-c' THEN 'Immigrate to B.C.'
    #       WHEN lower(SPLIT_PART(SPLIT_PART(SPLIT_PART(${TABLE}.page_referrer,'//',2), '/', 2), '.aspx', 1)) = 'start-your-life-in-b-c' THEN 'Start Your Life in B.C.'
    #       WHEN lower(SPLIT_PART(SPLIT_PART(SPLIT_PART(${TABLE}.page_referrer,'//',2), '/', 2), '.aspx', 1)) = 'work-or-study-in-b-c' THEN 'Work or Study in B.C.'
    #       WHEN lower(SPLIT_PART(SPLIT_PART(SPLIT_PART(${TABLE}.page_referrer,'//',2), '/', 2), '.aspx', 1)) = 'employer-resources' THEN 'Employer Resources'
    #       WHEN lower(SPLIT_PART(SPLIT_PART(SPLIT_PART(${TABLE}.page_referrer,'//',2), '/', 2), '.aspx', 1)) = 'resources-for' THEN 'Resources For'
    #       ELSE NULL
    #     END;;
    sql: ${TABLE}.status ;; #Won
    drill_fields: [page_views.page_referrer_display_url]
    group_label: "WelcomeBC Dimensions"
  }

  dimension: welcomebc_page_referrer_topic {
    label: "WelcomeBC Page Referrer Topic"
    # sql: CASE
    #       WHEN SPLIT_PART(SPLIT_PART(lower(${TABLE}.page_referrer_display_url), '//', 2), '.aspx', 1) in
    #       ('www.welcomebc.ca/employer-resources',
    #         'www.welcomebc.ca/employer-resources/b-c-provincial-nominee-program-(pnp)-for-employer',
    #         'www.welcomebc.ca/employer-resources/b-c-provincial-nominee-program-for-employer',
    #         'www.welcomebc.ca/employer-resources/b-c-provincial-nominee-program-for-employer/b-c-provincial-nominee-program-for-employers',
    #         'www.welcomebc.ca/employer-resources/immigration-supports-in-b-c-global-skills-strategy ',
    #         'www.welcomebc.ca/employer-resources/immigration-supports-in-b-c-global-skills-strategy/immigration-supports-in-b-c-global-skills-strategy',
    #         'www.welcomebc.ca/employer-resources/federal-immigration-programs',
    #         'www.welcomebc.ca/employer-resources/federal-immigration-programs/about-federal-immigration-programs',
    #         'www.welcomebc.ca/employer-resources/hire-internationally-trained-workers',
    #         'www.welcomebc.ca/employer-resources/hire-internationally-trained-workers/why-hire-internationally-trained-workers',
    #         'www.welcomebc.ca/employer-resources/hire-internationally-trained-workers/recruit-internationally-trained-workers',
    #         'www.welcomebc.ca/employer-resources/hire-internationally-trained-workers/retain-your-workers',
    #         'www.welcomebc.ca/employer-resources/hire-temporary-foreign-workers',
    #         'www.welcomebc.ca/employer-resources/hire-temporary-foreign-workers/temporary-foreign-worker-program',
    #         'www.welcomebc.ca/employer-resources/hire-temporary-foreign-workers/international-mobility-program',
    #         'www.welcomebc.ca/immigrate-to-b-c/b-c-provincial-nominee-program/bc-pnp-tech-pilot',
    #         'www.welcomebc.ca/immigrate-to-b-c/b-c-provincial-nominee-program/employer-requirements') THEN 'Employer Related'
    #       WHEN SPLIT_PART(SPLIT_PART(lower(${TABLE}.page_referrer_display_url), '//', 2), '.aspx', 1) in
    #       ('www.welcomebc.ca/immigrate-to-b-c/bc-pnp-skills-immigration/international-graduate',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-skills-immigration/international-post-graduate',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-express-entry-b-c/eebc-international-graduate',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-express-entry-b-c/eebc-international-post-graduate',
    #         'www.welcomebc.ca/start-your-life-in-b-c/daily-life/education-in-british-columbia',
    #         'www.welcomebc.ca/work-or-study-in-b-c/study-in-b-c',
    #         'www.welcomebc.ca/work-or-study-in-b-c/study-in-b-c/international-students',
    #         'www.welcomebc.ca/work-or-study-in-b-c/study-in-b-c/training-and-education',
    #         'www.welcomebc.ca/work-or-study-in-b-c/extend-your-stay-in-b-c/extend-your-study-permit',
    #         'www.welcomebc.ca/resources-for/international-students',
    #         'www.welcomebc.ca/resources-for/international-students/come-to-b-c-to-study') THEN 'Student Related'
    #       WHEN SPLIT_PART(SPLIT_PART(lower(${TABLE}.page_referrer_display_url), '//', 2), '.aspx', 1) in
    #       ('www.welcomebc.ca/immigrate-to-b-c/b-c-provincial-nominee-program/invitations-to-apply',
    #         'www.welcomebc.ca/immigrate-to-b-c/b-c-provincial-nominee-program/documents',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-skills-immigration/skilled-worker',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-skills-immigration/health-care-professional',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-skills-immigration/entre-level-and-semi-skilled',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-express-entry-b-c/eebc-skilled-worker',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-express-entry-b-c/express-entry-health-care-professional',
    #         'www.welcomebc.ca/start-your-life-in-b-c/services-and-support/for-temporary-residents',
    #         'www.welcomebc.ca/work-or-study-in-b-c/work-in-b-c',
    #         'www.welcomebc.ca/work-or-study-in-b-c/work-in-b-c/find-a-job-in-b-c',
    #         'www.welcomebc.ca/work-or-study-in-b-c/work-in-b-c/foreign-qualifications-recognition-(fqr)',
    #         'www.welcomebc.ca/work-or-study-in-b-c/work-in-b-c/temporary-foreign-workers',
    #         'www.welcomebc.ca/work-or-study-in-b-c/work-in-b-c/know-your-rights-as-a-temporary-foreign-worker',
    #         'www.welcomebc.ca/work-or-study-in-b-c/work-in-b-c/workplace-information',
    #         'www.welcomebc.ca/work-or-study-in-b-c/work-in-b-c/employment-language-programs',
    #         'www.welcomebc.ca/work-or-study-in-b-c/your-career-in-b-c',
    #         'www.welcomebc.ca/work-or-study-in-b-c/extend-your-stay-in-b-c',
    #         'www.welcomebc.ca/work-or-study-in-b-c/extend-your-stay-in-b-c/extend-your-stay-in-b-c',
    #         'www.welcomebc.ca/work-or-study-in-b-c/extend-your-stay-in-b-c/transition-to-permanent-residence',
    #         'www.welcomebc.ca/work-or-study-in-b-c/extend-your-stay-in-b-c/support-for-temporary-foreign-residents',
    #         'www.welcomebc.ca/resources-for/temporary-foreign-workers-(tfws)',
    #         'www.welcomebc.ca/resources-for/temporary-foreign-workers-(tfws)/find-out-about-working-temporarily-in-b-c') THEN 'Worker Related'
    #       WHEN SPLIT_PART(SPLIT_PART(lower(${TABLE}.page_referrer_display_url), '//', 2), '.aspx', 1) in
    #       ('www.welcomebc.ca/immigrate-to-b-c/b-c-provincial-nominee-program',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-skills-immigration',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-express-entry-b-c',
    #         'www.welcomebc.ca/immigrate-to-b-c/bc-pnp-entrepreneur-immigration',
    #         'www.welcomebc.ca/immigrate-to-b-c/other-immigration-options-and-information') THEN 'BC PNP 3rd-Level Pages'
    #       ELSE NULL
    #     END;;
    sql: ${TABLE}.status ;; #Won
    group_label: "WelcomeBC Dimensions"
    drill_fields: [page_views.page_referrer_display_url]
  }

  dimension: pnp_page_referrer_display_url {
    label: "PNP Page Referrer Display URL"
    description: "Cleaned URL of the page without specific case, form and reference numbers"
    type: string
    # sql: CASE  WHEN split_part(${TABLE}.page_referrer_display_url, '/', 5) similar to '[0-9]+' AND split_part(${TABLE}.page_referrer_display_url, '/', 7) similar to '[0-9]+'
    #       THEN REPLACE(REPLACE(${TABLE}.page_referrer_display_url, split_part(${TABLE}.page_referrer_display_url, '/', 7), 'XXXXXX'), split_part(${TABLE}.page_referrer_display_url, '/', 5), 'XXXXXX')
    #       WHEN split_part(${TABLE}.page_referrer_display_url, '/', 5) similar to '[0-9]+'
    #       THEN REPLACE(${TABLE}.page_referrer_display_url, split_part(${TABLE}.page_referrer_display_url, '/', 5), 'XXXXXX')
    #       WHEN split_part(${TABLE}.page_referrer_display_url, '/', 6) similar to '[0-9]+'
    #       THEN REPLACE(${TABLE}.page_referrer_display_url, split_part(${TABLE}.page_referrer_display_url, '/', 6), 'XXXXXX')
    #       WHEN split_part(${TABLE}.page_referrer_display_url, '/', 7) similar to '[0-9]+'
    #       THEN REPLACE(${TABLE}.page_referrer_display_url, split_part(${TABLE}.page_referrer_display_url, '/', 7), 'XXXXXX')
    #       ELSE ${TABLE}.page_referrer_display_url
    #     END;;
    sql: ${TABLE}.status ;; #Won
    group_label: "WelcomeBC Dimensions"
    drill_fields: [page_views.page_referrer,page_views.page_url]
  }

}
