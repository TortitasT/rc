# OMP
# $THEME="$env:POSH_THEMES_PATH\bubblesextra.omp.json"
$THEME="$env:POSH_THEMES_PATH\catppuccin_mocha.omp.json"

oh-my-posh init pwsh --config $THEME | Invoke-Expression


# MODULES
Import-Module -Name Terminal-Icons

# BASH LIKE AUTOCOMPLETE https://dev.to/ofhouse/add-a-bash-like-autocomplete-to-your-powershell-4257
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# ALIAS
function artisan { php artisan @args }
Set-Alias art artisan

function gitStatus { git status }
Set-Alias gs gitStatus

function gitAdd { git add --all }
Set-Alias ga gitAdd

function gitPull { git pull @args }
Set-Alias gpl gitPull

function gitCheckout { git checkout @args }
Set-Alias gco gitCheckout