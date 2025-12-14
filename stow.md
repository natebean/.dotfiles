# GNU Stow Reference

## Basic Concept

Stow is a symlink manager that creates symbolic links from a source directory to a target directory. It's commonly used for managing dotfiles.

## Basic Usage

```bash
stow [options] <package>
```

## Common Workflow

### 1. Organize your dotfiles

Structure subdirectories within your stow directory (e.g., `~/.dotfiles/`). Each subdirectory represents a "package":

```
~/.dotfiles/
├── nvim/
│   └── .config/nvim/init.vim
├── bash/
│   └── .bashrc
└── git/
    └── .gitconfig
```

### 2. Create symlinks from a package

```bash
cd ~/.dotfiles
stow nvim  # Creates symlinks for files in nvim/ to your home directory
```

### 3. Unstow (remove symlinks)

```bash
stow -D nvim
```

## Common Options

- `-t <target>` — specify target directory (defaults to parent of stow dir, typically your home)
- `-D` — delete symlinks (unstow)
- `-R` — restow (delete and recreate)
- `-v` — verbose output
- `--adopt` — move existing files into the stow package before symlinking

## Examples

### Stow multiple packages at once

```bash
cd ~/.dotfiles
stow -v nvim bash git
```

### Restow after changes

```bash
stow -R nvim
```

### Adopt existing files

```bash
stow --adopt nvim  # Moves existing files into the stow package
```
