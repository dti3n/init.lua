return {
    { trigger = "fn", body = "function ${1:name}(${2:args}) $0\nend" },
    { trigger = "@type", body = "---@type ${1:type}" },
}
