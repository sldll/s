#
# ~/.bashrc
#

dot="$HOME/dot"
export PATH="$dot/bin:$PATH"

if [[ "$(tty)" =~ ^/dev/tty[1-6]$ ]]; then

	#setfont ter-132n
	setfont ter-v24b
	setterm -blength 0

	if [[ ! -f ~/.wifi-done ]]; then
	nmtui
	fi
	touch ~/.wifi-done

fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias gr='grep -R -I -i --exclude-dir={.cache,firefox}'
alias cmp2='grep -Fx -f -i'

alias p='ping 1.1.1.1'

#alias vam='vim $(fzf --preview="bat --color=always {}")'
alias vam='selected=$(fzf --preview="bat --color=always {}") && vim "$selected"'
alias v='vim'
alias vm='vim'

alias f='read -p "search: " file && fd -H -i -a $file / | fzf'
alias f1='fzf --preview="bat --color=always {}" --preview-window="right,75%,border-left,<80(up,70%,border-bottom)"'
alias f2='fd -H . --full-path --type f /etc /usr /usr/local /home /var | fzf'
alias f3='fd -H -i -a'
alias f4='fd -H -i -a | fzf'
alias loc='sudo updatedb && locate'
alias bt='systemctl start bluetooth'
alias btc='bluetoothctl'

alias count='i=0; while true; do printf "\r%d" "$i"; ((i++)); sleep 1; done'

alias fis='flatpak install'
alias fup='flatpak update'

alias up='rm -f /tmp/waybar-updates && echo "" && echo "PACMAN pkgs" && sudo pacman -Syu --ignore linux && echo "" && echo "" && echo "FLATPAK pkgs" && flatpak update'
alias is='sudo pacman -S --needed'

alias qu='sudo pacman -Qu'
alias cu='checkupdates'

alias ss='sudo pacman -Ss'
alias pr='sudo pacman -R'
alias qs='sudo pacman -Qs'
alias ql='sudo pacman -Ql'
alias qi='sudo pacman -Qi'
alias si='sudo pacman -Si'
alias qe='sudo pacman -Qe'
alias qo='sudo pacman -Qo'
alias qqe='sudo pacman -Qqe'

alias ys='yay -Ss'

alias gy='cd && git clone https://aur.archlinux.org/yay ; cd yay ; makepkg -si'
alias gp='cd && git clone https://aur.archlinux.org/paru ; cd paru ; makepkg -si'
alias gcl='printf "name/name\nREPONAME: " && read -rp "" REPO  && git clone https://github.com/$REPO'

alias ga='git add . && git commit -m "."'
alias push='git add . && git commit -m "." && git push'

alias stor='read -p "without git restore..." stow --adopt --no-folding .'
alias sto='read -p "git pushed?" && stow --no-folding --adopt . && git restore .'
alias resto='git restore .'

alias gn='gh repo create --private --source=. --remote=origin'
alias gvis='gh repo list && glab repo list -F json | jq ".[] | {name, visibility}"'

alias pp='echo "" && cd $dot && echo $PWD && echo "" && git add . && git commit -m "." && git push && gs && echo "" && git push gitlab main && echo && ll && echo && gs'
alias ppg='cd $dot && git push gitlab main'

#alias gs='cd $dot && git show --name-only'
alias gs='cd $dot && echo && git show --pretty="" --name-only'

alias gla='git remote add gitlab https://gitlab.com/instantuzer/fin.git'

alias gst='git status'
alias gb='git blame --color-lines $(fzf)'
alias gch='cd $dot & git log -p -U0 --no-prefix'
alias god='git log -p  --unified=0 | grep -E '^-' | bat'
alias gl='git log -p --follow --'
alias gcr='read -p "newrepo name: " reponame; gh repo create $reponame --private --source=. --remote=origin --push'

alias cb='cat ~/.bashrc | rg -i -F'
alias k2='cat ~/.config/i3/config | rg -i -F'
alias k='cat ~/.config/hypr/hyprland.conf | rg -i -F'
alias wk='~/.config/i3/wttr3'
alias vd='vimdiff'

alias lak='sudo cryptsetup luksAddKey'
alias lrk='sudo cryptsetup luksRemoveKey'
alias cs='sudo cryptsetup'
alias lo='sudo cryptsetup luksOpen'
alias lc='sudo cryptsetup luksClose'

alias treee='tree -a -I .git'
alias ls='eza -la --icons --group-directories-first --sort=size'
alias lss='eza -la --sort=size --icons'
alias lsm='eza -la --sort=modified --icons'
alias lti='eza -la --time-style=long-iso --icons'
alias ltr='eza -la --tree --icons'
alias lsg='eza -la --icons --group-directories-first --git --icons'
#alias cl='read -rp "FILENAME: " CLIP && cat $CLIP | xclip -selection clipboard'
#alias cl='CLIP=$(fd --type f --hidden . . | fzf --prompt="Select file: ") && [ -n "$CLIP" ] && cat "$CLIP" | xclip -selection clipboard'
alias cl='CLIP=$(fd --type f --hidden --exclude .git . . | fzf --prompt="Select file: ") && [ -n "$CLIP" ] && xclip -selection clipboard < "$CLIP"'
alias cl2='CLIP=$(fd --type f --hidden --exclude .git . . | fzf --prompt="Select file: ") && [ -n "$CLIP" ] && wl-copy < "$CLIP"'
alias hi='history'
alias hig='history | rg -i'
alias se="sudoedit"
alias ff='fastfetch'
alias b='btop -t -u 100'
alias tm='tmux'
alias m='man'
alias mo='sudo mount'
alias umo='sudo umount'
alias conf2='vim $dot/.config/i3/config'
alias confbak='vim $dot/.config/i3/bakconfig'
alias conf3='vim $dot/.config/hypr/hyprland.conf'
alias conf='vim $dot/.config/sway/config'
alias x='startx'
alias c='sway'
alias h='start-hyprland'
alias test='uwsm start start-hyprland'
alias t='echo '' && date && echo '' && cal -m'
alias zil='unzip -l'
alias uz='unzip'
alias tar2='read -p "archive name: " name; tar -I zstd -cf "${name}-$(date +%Y%m%d).tar.zst" $(fd . | fzf -m)'
alias tl='tar -tvf'
alias tlp2='sudo tlp-stat -s'

alias stc='file=$(fzf) && tar -I zstd -cvf "$file".tar.zst "$file" && ls'

#alias pq2='read -rp "Archive name: " name && fzf -m --print0 | tar --null -T - -I 'zstd -T0' -cf "${name}-$(date +%F).tar.zst"'
#alias pqd='file=$(fzf) && tar -I zstd -xvf "$file"'
alias std='file=$(fzf --prompt="Select .tar.zst file: ") && [ -n "$file" ] && zstd -d "$file" -c | tar -xvf -'
alias std2='file=$(fd -e zst . | fzf --prompt="Select .zst file: ") && [ -n "$file" ] && zstd -d "$file" -c | tar -xvf -'
alias stl='echo && zstdfile=$(fzf) && tar -I zstd -tf $zstdfile'

alias stdir='echo && read -p ".tar.zst name: " file && echo && folder=$(fd -t d | fzf) && tar -I zstd -cvf "$file".tar.zst "$folder" && echo && ls' 
alias zz='read -p ".7z name: " file && folder=$(fd -t d | fzf) && 7z a -t7z -mx=9 "$file".7z "$folder"'

alias x='xrandr'
alias wp='feh --bg-center'
alias mg='magick -verbose'
alias loglvl='sudo dmesg -n 3'

alias sshd='systemctl start sshd'

alias de='declare -f'

alias dns='~/script/dns'
alias sus='systemctl suspend'
alias wifi='rfkill toggle wifi'

alias ..='cd ..'
alias cd..='cd ..'
alias ll='cd ~/Downloads && echo && eza -la --group-directories-first --icons --sort=size'
alias fl='cd ~ && echo && eza -la --group-directories-first --icons --sort=size'
alias sl='cd $dot/script && echo && eza -la --group-directories-first --icons --sort=size'
alias dl='cd $dot && echo && eza -la --group-directories-first --icons --sort=size'

alias lsl='lsblk'

alias real='py script/accu'

#alias gpgc='read -p "file: " file && gpg -c "$file"'
alias gc='file=$(fzf) && gpg -c "$file" && echo "done"'
alias gd='file=$(fzf) && gpg "$file" && echo "done"'
alias y='yazi'
alias py='python'
alias yt='yt-dlp'
#alias sx='find . -type f \( -iname "*.jpg" -o -iname "*.png" \) | sxiv -'
alias sx='sxiv -r'
alias db='sudo updatedb'

alias ddrf='sudo ddrescue -f -n -c64'

alias df='df -h'
alias du='du -h'

alias cls='clear'
alias clr='clear'
alias d='clear'

alias bs='vim ~/.bashrc'
alias sbs='source ~/.bashrc'

#alias ipkg='grep -v '^\s*#' < read -rp "pkgname:" pkgsfile && cat pkgsfile | sudo pacman -S --needed -'
alias ipkg='bash -c '\''read -rp "pkgname: " pkgsfile; grep -v "^[[:space:]]*#" "$pkgsfile" | sudo pacman -S --noconfirm --needed -'\'''
alias pkgs2='grep -v '^\s*#' pkgs2 | sudo pacman -S --noconfirm --needed -'

#PS1="\u@\h \$ "
#PS1=' $(date +"%T") \$ '
#PS1='\[\e[38;5;214m\] $(date +"%T") \$ \[\e[0m\]'


#PS1='\n$( [[ -n "$SSH_CONNECTION" ]] && echo "$(hostname -i)" )\[\e[38;5;214m\]$PWD 😺  🤔🎄🎆🎇🥵💀😈🤑🤯🥵🤠👿🍆🍼'
#PS1='\n$( [[ -n "$SSH_CONNECTION" ]] && echo "'['$(hostname -i)']'" )\[\e[38;5;214m\]\A$PWD 😈  '
#PS1='\n$( [[ -n "$SSH_CONNECTION" ]] && echo "'['$(hostname -i)']'" )\[\e[38;5;214m\]\D{%M}:\D{%S} $PWD 😈  '
#PS1='\n$( [[ -n "$SSH_CONNECTION" ]] && echo "'['$(hostname -i)']'" )\[\e[38;5;214m\] $PWD 😈  '

update_prompt_info() {
    if [[ -n "$SSH_CONNECTION" ]]; then
        SSHIP="[$(hostname -i)] "
    else
        SSHIP=""
    fi
}

PROMPT_COMMAND=update_prompt_info
PS1='\n${SSHIP}\[\e[38;5;214m\] \w 😈  '
t

#PS1='\n[\u@\h] \w 😈 '

#PS1='[\t] \u@\h:\w\$ '
#PS1='[$(date +%M)] \u@\h:\w\$ '
#$(date +%M:%S)
#PS1='\[\e[2m\][$(date +%M)]\[\e[0m\] \$ '


        nmcli dev show | awk '/DNS/ {print $2}' | grep -vqE '^(1\.1\.1\.1|8\.8\.8\.8|2001:4860:4860::8888|2606:4700:4700::1111)$' && rm -f ~/.dns-done

	echo
	if [[ ! -f ~/.dns-done ]]; then
	echo "DNS - DNS - DNS - DNS - DNS - DNS - DNS - DNS - DNS - DNS - DNS - DNS " 
	echo "DNS - DNS - DNS - DNS - DNS - DNS - DNS - DNS - DNS - DNS - DNS - DNS " 
	fi
	
	if [[ ! -f ~/.luks-done ]]; then
	echo	
	echo "LUKS - LUKS - LUKS - LUKS - LUKS - LUKS - LUKS - LUKS - LUKS - LULS - LUKS"
	echo "HEADER - HEADER - HEADER - HEADER - HEADER - HEADER - HEADER - HEADER - HEADER"
	fi





grdns() {
    nmcli -t -f NAME connection show --active | grep -v '^lo$' | while read -r conn; do
    echo
        dns=$(nmcli -g IP4.DNS connection show "$conn")
        [ -n "$dns" ] && echo "$conn -> $dns"
    done
}

ddsda() {
    echo
    lsblk
    read -p "sda (y/N)?" confirm
    if [[ "$confirm" == "y" ]]; then
        sudo dd if=~/Downloads/archlinux-x86_64.iso of=/dev/sda bs=8M status=progress conv=fdatasync
    else
        echo "Aborted."
    fi
}

ddr() {

# Check for fzf
if ! command -v fzf &> /dev/null; then
    echo "fzf is required. Install it (e.g., sudo apt install fzf)"
    return 1
fi

# List all devices and partitions with name, size, type, and mountpoint
mapfile -t devices < <(lsblk -l -o NAME,SIZE,TYPE,MOUNTPOINT)

if [[ ${#devices[@]} -eq 0 ]]; then
    echo "No devices found."
    return 1
fi

echo
lsblk
echo

# Interactive menu with arrow keys
selected=$(printf '%s\n' "${devices[@]}" | fzf --prompt="Select a device/partition: " )

if [[ -z "$selected" ]]; then
    echo "No device selected. Exiting."
    return 1
fi

# Extract full path (/dev/sda, /dev/nvme0n1p1)
device=$(awk '{print $1}' <<< "$selected")

echo
echo "$selected"
echo

# Check if the selected device is mounted
mountpoint=$(lsblk -no MOUNTPOINT "/dev/$device")
if [[ -n "$mountpoint" ]]; then
    echo "WARNING: Selected device is mounted at $mountpoint!"
    echo
    read -p "SURE? (Y/n):" sure
    if [[ -z "$sure" ]]; then
	    echo
            return 1
    fi
fi

# Ask for file name (default: bigfile)
read -r -p "Enter file name (default: bigfile): " file_choice
if [[ -z "$file_choice" ]]; then
    file_choice="bigfile"
fi

# Ask for confirmation (Enter = yes)
read -r -p "Confirm write to /dev/$device/$file_choice? (Y/n): " confirm
if [[ -n "$confirm" ]]; then
    echo "Aborted."
    return 1
fi

# Run dd safely
echo "Writing random data to /dev/$device/$file_choice ..."
sudo dd if=/dev/urandom of="$device/$file_choice" bs=128M status=progress
}

ddrng() {
    echo
    lsblk
    echo
       
    read -p "partname: " part
    read -p "filename: (empty = whole partition) " file
    echo
    read -p "confirm write $part/$file (Y/n)?: " fileconf
	if [[ -z "$fileconf" && -n "$part" ]]; then
		echo "writing file"
		sudo dd if=/dev/urandom of=$part$file bs=128M status=progress
        fi
}

rf() {
    mapfile -t DEVICES < <(rfkill --output ID,TYPE,SOFT,HARD --noheadings | awk '{print $1 ":" $2}')

    if [ ${#DEVICES[@]} -eq 0 ]; then
        echo "No rfkill devices found."
        return 1
    fi

    echo "Available wireless devices:"
    for i in "${!DEVICES[@]}"; do
        ID=$(echo "${DEVICES[$i]}" | cut -d: -f1)
        TYPE=$(echo "${DEVICES[$i]}" | cut -d: -f2)
        echo "[$i] ID=$ID  TYPE=$TYPE"
    done

    echo
    read -p "Select device number: " CHOICE

    if ! [[ "$CHOICE" =~ ^[0-9]+$ ]] || [ "$CHOICE" -ge "${#DEVICES[@]}" ]; then
        echo "Invalid selection."
        return 1
    fi

    ID=$(echo "${DEVICES[$CHOICE]}" | cut -d: -f1)

    echo
    echo "Choose action:"
    echo "1) block"
    echo "2) unblock"
    echo "3) toggle"
    read -p "Select action: " ACTION

    case "$ACTION" in
        1)
            sudo rfkill block "$ID"
            ;;
        2)
            sudo rfkill unblock "$ID"
            ;;
        3)
            if rfkill list "$ID" | grep -q "Soft blocked: yes"; then
                sudo rfkill unblock "$ID"
            else
                sudo rfkill block "$ID"
            fi
            ;;
        *)
            echo "Invalid action."
            return 1
            ;;
    esac

    echo
    rfkill list "$ID"
}

mt() {
	fzf -m | while IFS= read -r f; do
 	[ -e "$f" ] && tar -I zstd -cf "$f.tar.zst" "$f"
	done
}

lb() {
    cd "$dot" || { echo "Failed to go to home directory"; return 1; }

    read -p "device /dev/X): " device
    read -p "filename (default: luks-header-img): " backup
    backup=${backup:-luks-header-img}
    backup="${backup}-${device: -4}"

    if [ -f "$backup" ]; then
        read -p "File '$backup' exists. Overwrite? (y/n): " confirm
        [[ "$confirm" != "y" ]] && echo "Aborted." && return
    fi

    sudo cryptsetup luksHeaderBackup "$device" --header-backup-file $dot/"$backup" && \
    sudo chown $USER:$USER $dot/"$backup"
    gpg -c $dot/"$backup"
    rm -f $dot/"$backup"
	if [[ -f $dot/"$backup".gpg ]]; then
        touch ~/.luks-done
	fi
    echo
    ll
}

gmp() {
  read -p "repo name: " reponame
  gh repo edit "instantuzer/$reponame" --visibility private --accept-visibility-change-consequences
}

glmp() {
  read -p "repo name: " reponame
  ENCODED=$(echo "$reponame" | sed 's/\//%2F/')

echo "Setting visibility to private…"

glab api "projects/instantuzer/$reponame" \
  -X PUT \
  -F "visibility=private"
}

gmpu() {
  read -p "repo name: " reponame
  gh repo edit "instantuzer/$reponame" --visibility public --accept-visibility-change-consequences
}

export EDITOR=vim
export VISUAL=vim
export BROWSER=firefox
