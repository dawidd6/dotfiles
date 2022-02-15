#
# ssh specific completions
#

# Also retrieve `user@host` entries from history
function __ssh_history_completions
    history --prefix ssh --max=100 | string replace -rf '.* ([A-Za-z0-9._:-]+@[A-Za-z0-9._:-]+).*' '$1'
end

complete -c sshpass -d Remote -xa "(__fish_complete_user_at_hosts)"
complete -c sshpass -d Remote -k -fa '(__ssh_history_completions)'

