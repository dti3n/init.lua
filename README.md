## nvim-config

> nightly build

---

## tree-sitter

> requires: lua, luarocks, tree-sitter-cli

### Create parser & queries folders

```
mkdir -p $HOME/.local/share/nvim/site/parser
mkdir -p $HOME/.local/share/nvim/site/queries
```

check runtime files after that

```
:echo nvim_get_runtime_file('parser', v:true)
:echo nvim_get_runtime_file('queries', v:true)
```

### Install tree-sitter with luarocks

- check lua version before running these commands 
- `tree-sitter-javascript` comes with `tree-sitter-ecma` & `tree-sitter-jsx`
  when installed via luarocks

```
luarocks \
    --lua-version=5.5 \
    --tree=$HOME/.local/share/nvim/rocks install tree-sitter-javascript
```

### Parser symlink

```
ln -s \
  $HOME/.local/share/nvim/rocks/lib/luarocks/rocks-5.5/tree-sitter-javascript/*/parser/javascript.so \
  $HOME/.local/share/nvim/site/parser/javascript.so
```

### Queries symlink

```
ln -s \
  $HOME/.local/share/nvim/rocks/lib/luarocks/rocks-5.5/tree-sitter-javascript/*/queries/javascript \
  $HOME/.local/share/nvim/site/queries/javascript
```

### Automation

```
./ts-link {lang}
```
