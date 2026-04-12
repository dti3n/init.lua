return {
    { trigger = "def", body = "def ${1:name} $0\nend" },
    { trigger = "fn", body = "def ${1:name} $0\nend" },
    { trigger = "do", body = "do |${1:e}| $0\nend" },
}
