# hubot-shortcut

A macro system for hubot supporting macro arguments, multi-command macros, and
recursive macro expansion. hubot-shortcut is fully configurable via chat.

## Demo

![Demo](https://raw.githubusercontent.com/anishathalye/hubot-shortcut/docs/demo.png)

## Installation

In hubot project repo, run:

`npm install hubot-shortcut --save`

Then add **hubot-shortcut** to your `external-scripts.json`:

```json
[
  "hubot-shortcut"
]
```

**Unless you want to configure every macro via environment variable, you also
need to install [hubot-conf][hubot-conf].**

## Usage

hubot-shortcut macros are usually configured using [hubot-conf][hubot-conf].
Macros can also be configured by setting environment variables, but that is not
recommended.

hubot-shortcut expands any macros set in the `shortcut.*` namespace in
hubot-conf. It also expands macros set as `HUBOT_SHORTCUT_*` environment
variables.

Typical usage looks like this:

```
> {botname} conf set shortcut.test "{botname} echo hello!"
botname: shortcut.test = `"{botname} echo hello!"`
> !test
hello!
```

## Tips

* Macros support **arguments**, as demonstrated in the screenshot above.
  Arguments to `!macro` invocations are appended onto the end of the expanded
  macro.

* Macros support **running multiple commands**. When specifying the macro,
  separate commands by semicolons. For example, `{botname} conf set
  shortcut.test "{botname} echo one; {botname} echo two"`. _Multiple commands
  are run in parallel_, not one after another.

* Macros support **recursive expansion**. If a macro expansion contains
  `!whatever`, it'll be expanded. There's no depth limit or cycle breaking on
  macro expansion, so if you make a macro like `{botname} conf set shortcut.die
  "{botname} echo :skull: ; !die"`, it might not turn out very well.

## License

Copyright (c) 2015-2019 Anish Athalye. Released under the MIT License. See
[LICENSE.md][license] for details.

[license]: LICENSE.md
[hubot-conf]: https://github.com/anishathalye/hubot-conf
