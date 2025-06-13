# ~/.bash_funcs/unix_to_linux.sh
# Membuat alias ala commercial UNIX (HP-UX/AIX) ke Linux
# Contoh: ll → ls -la, dfh → df -h

unix_aliases() {
    alias ll='ls -la'
    alias psg='ps -ef | grep'
    alias h='history'
    alias ..='cd ..'
    echo "UNIX-style aliases loaded."
}
