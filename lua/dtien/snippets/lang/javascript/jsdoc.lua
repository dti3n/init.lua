return {
    {
        trigger = "/**",
        body = "/**\n * @param$0\n * @returns$1\n */",
    },
    {
        trigger = "@type",
        body = "/** @type ${1:typeName} */",
    },
    {
        trigger = "@param",
        body = "@param {${1:type}} ${2:paramName}",
    },
    {
        trigger = "@return",
        body = "@returns {${1:type}} ${2:description}",
    },
    {
        trigger = "@returns",
        body = "@returns {${1:type}} ${2:description}",
    },
}
