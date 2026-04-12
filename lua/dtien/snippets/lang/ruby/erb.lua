return {
    {
        trigger = "if",
        body = "<% if ${1:truevalue} %>\n  ${2}\n<% end %>",
    },
    {
        trigger = "else",
        body = "<% else %>",
    },
    {
        trigger = "end",
        body = "<% end %>",
    },
    {
        trigger = "re",
        body = "<%= ${1} %>",
    },
    {
        trigger = "=",
        body = "<%= ${1} %>",
    },
    {
        trigger = "ee",
        body = "<% ${1} %>",
    },
    {
        trigger = "%",
        body = "<% ${1} %>",
    },
}
