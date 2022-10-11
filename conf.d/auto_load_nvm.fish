function load_nvm --on-variable="PWD"
  set -l default_node_version $nvm_default_version
  set -l node_version (nvm current)
  set -l nvmrc_path "./.nvmrc"
  if test -e "$nvmrc_path"
    set -l nvmrc_node_version (nvm list | grep (cat $nvmrc_path))
    if test -z "$nvmrc_node_version"
      nvm install (cat $nvmrc_path)
    else if test (cat $nvmrc_path) != "$node_version"
      nvm use (cat $nvmrc_path)
    end
  else if test "$node_version" != "$default_node_version"
    echo "Reverting to default Node version"
    nvm use $default_node_version
  end
end

load_nvm > /dev/stderr