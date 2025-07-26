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
  echo "$(date) Running $script_name..." >> "${archDir}/log/${script_name}.out"
  if [ -f "$1" ]; then
    bash "$1" >> "${archDir}/log/${script_name}.out" 2>> "${archDir}/log/${script_name}.err" &
  else
    echo "Install script $1 not found" >&2
  fi
}

####################################################################################################
# Run install scripts
####################################################################################################

in_silico="${archDir}/install"
run_install "${in_silico}/brew.sh"
run_install "${in_silico}/go.sh"
run_install "${in_silico}/julia.sh"
run_install "${in_silico}/R.sh"
run_install "${in_silico}/rust.sh"

####################################################################################################
# Wait for background jobs
####################################################################################################

wait
echo "All installation tasks completed."

####################################################################################################
