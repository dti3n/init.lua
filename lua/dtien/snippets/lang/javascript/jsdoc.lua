return {
    {
        trigger = "/**",
        body = "/**\n * @param {${1:type}} ${2:paramName}\n */",
    },
    {
        trigger = "@type",
        body = "/** @type {${1:typeName}} */",
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
    {
        trigger = "@typedef",
        body = "/**\n * @typedef {Object} ${1:TypeName}\n * @property {${2:type}} ${3:propName}\n */",
    },
    {
        trigger = "@property",
        body = "@property {${2:type}} ${3:propName}",
    },
}
