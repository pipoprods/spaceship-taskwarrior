#
# Taskwarrior
#
# Show task count with "PENDING" or "in" tag

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_TASKWARRIOR_SHOW="${SPACESHIP_TASKWARRIOR_SHOW=true}"
SPACESHIP_TASKWARRIOR_SUFFIX="${SPACESHIP_TASKWARRIOR_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_TASKWARRIOR_SYMBOL="${SPACESHIP_TASKWARRIOR_SYMBOL="🗹 "}"
SPACESHIP_TASKWARRIOR_COLOR="${SPACESHIP_TASKWARRIOR_COLOR="#008080"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_taskwarrior() {
  [[ $SPACESHIP_TASK_SHOW == false ]] && return

  [ -e ~/.taskrc -a -x "$(which task)" ] || return

  # Use quotes around unassigned local variables to prevent
  # getting replaced by global aliases
  # http://zsh.sourceforge.net/Doc/Release/Shell-Grammar.html#Aliasing
  local 'tasks_status'

  count="$(task +in +PENDING count)"
  if [[ $count > 0 ]]; then
    tasks_status=$count
  fi

  # Exit section if variable is empty
  [[ -z $tasks_status ]] && return

  # Display tasks section
  spaceship::section::v4 \
    --color "$SPACESHIP_TASKWARRIOR_COLOR" \
    --prefix "$SPACESHIP_TASKWARRIOR_PREFIX" \
    --suffix "$SPACESHIP_TASKWARRIOR_SUFFIX" \
    --symbol "$SPACESHIP_TASKWARRIOR_SYMBOL" \
    "$tasks_status"
}
