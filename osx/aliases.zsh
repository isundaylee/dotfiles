# All for adding a Git folder to Sublime recent directory, lol

function sublime-project-file-path() {
  echo "$PROJECTS/.sublime-projects/$1.sublime-project"
}

# $1: path, $2: name
function sublime-create-project-file() {
  OUT_DIR=$PROJECTS/.sublime-projects
  OUT_FILE="$OUT_DIR/$2.sublime-project"
  mkdir -p $OUT_DIR
  echo '[]' | jq "{folders: [{path: \"$1\"}]}" > $OUT_FILE
}

# $1: path
function sublime-add-to-recent-project() {
  SESSION_FILE="$HOME/Library/Application Support/Sublime Text 3/Local/Session.sublime_session"
  KEY=".workspaces.recent_workspaces"
  cat $SESSION_FILE | jq "$KEY=$KEY+[\"$1\"]" | sponge $SESSION_FILE
}

# $1: Git name
function sublime-git() {
  if [[ ! -d $GITS/$1 ]]; then
    echo "$GITS/$1 is not a directory. " && return
  fi

  sublime-create-project-file $GITS/$1 $1
  sublime-add-to-recent-project `sublime-project-file-path $1`
}
