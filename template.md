---
title: "The Bullhorn - Issue #{{ timestamp | dateformat(format='[week_number]') }}"
slug: "bullhorn-{{ timestamp | dateformat(format='[year]-[month]-[day]') }}"
author: {{ editor | tojson }}
date: {{ timestamp | dateformat(format='[year]-[month]-[day]') }}
tags: {{ projects | sort | tojson }}
categories: ["weekly-update"]
draft: false
---

![bullhorn-pool.png|600x200, 100%](upload://rmK8gYUKkT0B9pv3KxI2eUOi2wy.png)

<div data-theme-toc="true"> </div>

**This week in Ansible Community**
*Issue #{{ timestamp | dateformat(format='[week_number]') }}, {{ timestamp | dateformat(format='[year]-[month]-[day]') }} ([Past Issues](https://forum.ansible.com/c/news/bullhorn/17))*

Welcome to [The Bullhorn](https://forum.ansible.com/c/news/bullhorn/17), our newsletter for the Ansible Community. If you have any questions or content you’d like to share, you're welcome to chat with us in the [Ansible Social room on Matrix](https://matrix.to/#/#social:ansible.com), and mention [`newsbot`](https://matrix.to/#/@newsbot:ansible.im) to have your news item tagged for review for the next weekly issue!

{%- macro news(news_items) -%}
  {%- for item in news_items %}

[{{ item.reporter_display_name }}](https://matrix.to/#/{{ item.reporter_id }}) {{ config.verbs | random }}

> {{ item.message | replace("\n", "\n> ") }}
    {%- if item.images -%}
      {%- for image in item.images %}
> ![](/post/bullhorn/{{ image[0] }})
      {%- endfor %}
    {%- endif -%}
    {%- if item.videos -%}
      {%- for video in item.videos %}
> {{ "{{" }}< video src="/post/bullhorn/{{ video[0] }}" >{{ "}}" }}
      {%- endfor %}
    {%- endif -%}

  {%- endfor %}
{%- endmacro %}

{%- for key, entry in sections | dictsort %}

## {{ entry.section.title }} {{ entry.section.emoji }}

  {{- news(entry.news) }}

  {%- for project_entry in entry.projects %}

### {{ project_entry.project.title }} [↗]({{ project_entry.project.website }})

{{ project_entry.project.description }}

    {{- news(project_entry.news) }}

  {%- endfor %}
{%- endfor %}

## Other events and releases

Use the Ansible Forum to see [other events](https://forum.ansible.com/c/events/8) and [releases](https://forum.ansible.com/c/news/releases/18).

## Join the Ansible community

Looking for ways to get involved? See [how can I help](https://docs.ansible.com/ansible/devel/community/how_can_I_help.html#how-can-i-help) for some ideas!

You can find easy issues in [collections](https://github.com/search?q=user:ansible-collections+label:easyfix,"good+first+issue"+state:open&type=Issues) and [other projects](https://github.com/search?q=user:ansible+user:ansible-community+label:easyfix,"good+first+issue"+state:open&type=Issues) for code or documentation contributions.

## That's all for now!

Have any questions you’d like to ask, or issues you’d like to see covered? Please ask in [#social:ansible.com](https://matrix.to/#/#social:ansible.com)! See you next time!
