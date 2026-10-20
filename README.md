# Ansible Community Newsbot

Configuration, newsletter template, and container image for the Ansible Community Newsbot.

## NewsBot

The [NewsBot](https://github.com/haecker-felix/hebbot/) resides in the [Ansible Social](https://matrix.to/#/#social:ansible.com) room, and is used to help compile [The Bullhorn](https://forum.ansible.com/c/news/bullhorn/17). See [How to edit and release the Bullhorn](https://forum.ansible.com/t/how-to-edit-and-release-the-ansible-bullhorn/6543) for details on using newsbot to generate the Bullhorn.

### Submitting news

You can submit your news! It will be included in the next edition of the Bullhorn.

To do so, simply write a message in [Ansible Social](https://matrix.to/#/#social:ansible.com) and mention the bot (`@newsbot:ansible.im`) at the
start. *Or* alternatively, write your post and then add a :o: (`:o:`) reaction to it.

Posts should be in Markdown and include lots of information (what, why, when) as well as links to relevant changelogs, repos, etc.

You can also add some information about which section and/or project the news relates to. Add reactions to your message from the list below:

#### Sections

- ⏱️: Key dates (`:stopwatch:`)
- 🔈️: General news updates (`:speaker:`)
- 🏆️: Major new releases (`:trophy:`)
- 🛠️: Project updates (`:hammer_and_wrench:`)
- 🪄: Collection updates (`:magic_wand:`)
- 🙏: Help wanted (`:pray:`)
- 🗳️: Proposals (`:ballot_box:`)
- 📅: Community events and meetups (`:date:`)
- 👂️: Community updates (`:ear:`)
- 💰️: Ansible is hiring (`:moneybag:`)

#### Projects

- 🪜: Maintainers (`:ladder:`)
- ⚡️: ansible-core (`:zap:`)
- 📦️: Ansible Community Package (`:package:`)
- ⛏️: DevTools (`:pick:`)
- 🐂: Antsibull tooling (`:ox:`)
- AWX: AWX Project

The configured minimum is 30 UTF-8 bytes. An editor can accept a shorter item by adding the notice reaction.

### Configuration and rendering

`config.toml` is the source config downloaded by the bot. It defines the Matrix rooms, editors, notice behavior, minimum message length, section/project metadata, acknowledgement text, and report verbs. Image and video formatting belongs in `template.md`; it is not configured through TOML.

`template.md` is the complete MiniJinja template for the rendered Bullhorn. It receives `timestamp`, `sections`, `projects`, `config`, and `editor`. The template emits sorted, JSON-quoted project tags and a JSON-quoted author so the generated YAML front matter remains stable and valid. Hebbot reads `template.md` from its working directory by default; set `TEMPLATE_PATH` to an absolute path if the template is stored elsewhere. Likewise, `CONFIG_PATH` can select the config file.

The container downloads `config.toml` and `template.md` into `/data` on every startup. The in-chat `!update-config` command runs `/usr/local/bin/update_config.sh`, then Hebbot restarts. Both paths fetch from this repository using `main` by default. Set `NEWSBOT_CONFIG_REF` to a reviewed branch, tag, or commit to pin the source. Scripts stay in the image; updates fetch only the config and template. Failed or empty downloads prevent startup and leave existing deployed files unchanged.

### Updating and checking changes

After merging changes to the configured source ref, tell the bot to reload them in the NewsBot admin room:

`!update-config`

Then run `!render` to check the generated report. Check the admin room for render warnings and verify the generated front matter, section ordering, links, and media paths before publishing. Use `!help` for the current admin commands.
