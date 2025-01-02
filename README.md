# nvim
# Telescope.nvim FZF Extension Error Resolution

## Problem Description

If you encounter the following error when running Telescope with the `fzf` extension:

```bash
Error: 'fzf' extension doesn't exist or isn't installed: .local/share/nvim/lazy/telescope-fzf-native.nvim/lua/fzf_lib.lua:11: .local/share/nvim/lazy/telescope-fzf-native.nvim/lua/../build/libfzf.so: cannot open shared object file: No such file or directory
```


This error typically occurs because the `telescope-fzf-native.nvim` extension's native dependencies (`libfzf.so`) are not built or are missing.

## Steps to Resolve

1. Navigate to the `telescope-fzf-native.nvim` plugin directory:
    ```bash
    cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim
    make clean && make
    ```

