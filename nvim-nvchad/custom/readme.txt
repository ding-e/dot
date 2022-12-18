# ------------------------------------
# NEOVIM - 依赖
# ------------------------------------

mac command : [
    clang
    clang-format
    stylua
    fzf
    ripgrep
    zig, zls
    nim, nimble, nimlangserver | nimlsp, nimpretty
]

treesitter : [
    vim
    lua

    rust
    c
    #zig
    #cpp
    #make
    #cmake
    #llvm

    #hlsl
    #glsl

    toml
    json
    #markdown

    #godot_resource
    #gdscript

    #javascript
    #typescript

    #html
    #css

    #go
    #gomod
    #c_sharp
]

mason : [
    lua-language-server
    rust-analyzer
    clangd

    #zls
    #nimlsp
]
