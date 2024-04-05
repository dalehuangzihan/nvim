# nvim
NeoVim Configurations

## Branches:
### `main`:
    * No special colour schemes are installed. This is to retain compatibility with MacOS's default terminal, which can only display true colours. Using custom nvim colour themes might cause the colours to mess up. *NB:* This issue does not manifest if tmux is used inside default terminal.

## FAQ:
    * Q: Errors in package source codes (e.g. ^M, etc).
        * A: This is commonly caused by wrong line-endings used in the package's .vim files. Locate the offending source code file and run dos2unix to convert them to unix line-endings.
