return {
    {
        trigger = "##",
        body = "# ${1:A one-line summary.}\n#\n# @param ${2}\n# @return ${3}",
    },
    {
        trigger = "@param",
        body = "@param ${1:name} [${2:Type}] ${3:Description.}",
    },
    {
        trigger = "@return",
        body = "@return [${1:Types}] ${2:Description}",
    },
}
