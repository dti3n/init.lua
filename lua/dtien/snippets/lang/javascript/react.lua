local function get_component_name()
    local filename = vim.fn.expand("%:t:r")
    if filename == "" then
        filename = "Component"
    end
    return filename
end

return {
    {
        trigger = "rfca",
        body = "const "
            .. get_component_name()
            .. " = () => {\n"
            .. "    return (\n"
            .. "        <div>"
            .. "$0"
            .. "</div>\n"
            .. "    );\n"
            .. "};\n\n"
            .. "export default "
            .. get_component_name(),
    },
    {
        trigger = "rfcn",
        body = "export default function "
            .. get_component_name()
            .. "() {\n"
            .. "    return (\n"
            .. "        <div>"
            .. "$0"
            .. "</div>\n"
            .. "    );\n"
            .. "};",
    },
}
