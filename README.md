# nvim
# Potential errors resolutions

## FZF : 
### Problem Description

If you encounter the following error when running Telescope with the `fzf` extension:

```bash
Error: 'fzf' extension doesn't exist or isn't installed: .local/share/nvim/lazy/telescope-fzf-native.nvim/lua/fzf_lib.lua:11: .local/share/nvim/lazy/telescope-fzf-native.nvim/lua/../build/libfzf.so: cannot open shared object file: No such file or directory
```


This error typically occurs because the `telescope-fzf-native.nvim` extension's native dependencies (`libfzf.so`) are not built or are missing.

### Steps to Resolve
```bash
cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim
make clean && make
```

If this step did not resolve the problem:

```bash
sudo rm -r ~/.local/share/nvim/lazy/telescope-fzf-native.nvim
sudo rm -r ~/.local/share/nvim/lazy/telescope.nvim
```


## BLINK :
### Problem Description

If you encounter an error with blink.cmp of this kind :

```bash
Compiling frizbee v0.1.0 (https://github.com/saghen/frizbee#0bbeb41c)error[E0554]: `#![feature]` may not be used on the stable release channel--> 
Compiling lazy_static v1.5.0For more information about this error, try `rustc --explain E0554`.error: could not compile `frizbee` (lib) due to 1 previous errorwarning: build failed, waiting for other jobs to finish...
```

This error typically occurs because the plugin `blink.cmp` compilation failed due to the wrong version of cargo being used to build it.

### Steps to resolve
1. Install Rustup

2. Switch to nightly
```bash
rustup default nightly
```

3. Rebuild blink.cmp
```bash

cd ~/.local/share/nvim/lazy/blink.cmp
cargo build --release
```

4. Switch back to stable
```bash
rustup default stable
```
