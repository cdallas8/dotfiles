####################################################################################################
# Create log directory
####################################################################################################

echo "Ensuring log directory exists..."
logDir="log"
mkdir -p "$logDir"

####################################################################################################
# Logging helper
####################################################################################################

run_install () {
  local script_name=$(basename "$1" .sh)
  echo "$(date) Running $script_name..." >> "$HOME/dotfiles/log/${script_name}.out"
  if [ -f "$1" ]; then
    bash "$1" >> "$HOME/dotfiles/log/${script_name}.out" 2>> "$HOME/dotfiles/log/${script_name}.err" &
  else
    echo "Install script $1 not found" >&2
  fi
}

####################################################################################################
# Run install scripts
####################################################################################################

installDir="install"
run_install "${installDir}/brew.sh"
run_install "${installDir}/go.sh"
run_install "${installDir}/julia.sh"
run_install "${installDir}/R.sh"
run_install "${installDir}/rust.sh"

####################################################################################################
# Wait for background jobs
####################################################################################################

wait
echo "All installation tasks completed."

####################################################################################################
