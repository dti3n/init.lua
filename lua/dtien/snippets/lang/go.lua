return {
    {
        trigger = "ir",
        body = "if err != nil {\n" .. "\t${1:return err}\n" .. "}",
    },
}
