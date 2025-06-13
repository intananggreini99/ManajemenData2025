# ~/.bash_funcs/dos_aliases.sh
# Membuat alias ala DOS jika Anda terbiasa di Windows
# Contoh: dir → ls, copy → cp, del → rm

dos_aliases() {
    alias dir='ls -l'
    alias copy='cp'
    alias del='rm'
    alias md='mkdir'
    alias rd='rmdir'
    echo "DOS-style aliases loaded."
}
