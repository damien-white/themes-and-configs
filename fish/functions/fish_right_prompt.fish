function fish_right_prompt -d "Write out the right prompt"
    set -l return_code $status
    if test $return_code -ne 0
        echo '['(set_color -o red)Code: $return_code (set_color normal)'] '
    else
        echo ''
    end
    echo '(' (set_color yellow)(date +%m-%d-%Y)(set_color normal)' at '(set_color yellow)(date +%H:%M:%S)(set_color normal) ')'
end
