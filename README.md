# gnusty.vim

This plugin is modified from [vim-linux-coding-style](https://github.com/vivien/vim-linux-coding-style).

## Usage

For those who want to apply these options conditionally, you can define an
array of patterns in your vimrc and these options will be applied only if         
the buffer's path matches one of the pattern. In the following example,
options will be applied only if "gtk", "glib", or "gnome" is in
buffer's path.

```
let g:gnusty_patterns = [ "gtk", "gnome", "glib"]
```

## License

Distributed under the same terms as Vim itself. 
See :help license.
