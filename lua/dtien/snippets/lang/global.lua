return {
    {
        trigger = "shebang",
        body = "#!/usr/bin/env bash",
    },
    {
        trigger = "lorem1",
        body = "Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat.",
    },
    {
        trigger = "lorem2",
        body = "Lorem ipsum dolor sit amet, officia excepteur ex fugiat reprehenderit enim labore culpa sint ad nisi Lorem pariatur mollit ex esse exercitation amet. Nisi anim cupidatat excepteur officia. Reprehenderit nostrud nostrud ipsum Lorem est aliquip amet voluptate voluptate dolor minim nulla est proident. Nostrud officia pariatur ut officia. Sit irure elit esse ea nulla sunt ex occaecat reprehenderit commodo officia dolor Lorem duis laboris cupidatat officia voluptate. Culpa proident adipisicing id nulla nisi laboris ex in Lorem sunt duis officia eiusmod. Aliqua reprehenderit commodo ex non excepteur duis sunt velit enim. Voluptate laboris sint cupidatat ullamco ut ea consectetur et est culpa et culpa duis.",
    },
    {
        trigger = "datetime",
        body = function()
            return os.date("%Y-%m-%d %H:%M:%S")
        end,
    },
    {
        trigger = "uuid",
        body = function()
            local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
            return template:gsub("[xy]", function(c)
                local v = (c == "x") and math.random(0, 0xf) or math.random(8, 0xb)
                return string.format("%x", v)
            end)
        end,
    },
}
