#!/bin/sh

interrupt_handler() {
  echo -e "\nScript interrupted. Exiting..."
  exit 1
}
trap interrupt_handler SIGINT
trap interrupt_handler SIGTERM

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script/246128#246128
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

for base_file in $SCRIPT_DIR/*
do
  if [ ! -d ${base_file} ]; then
    continue
  fi
  while [[ true ]]; do
    echo "Files in ${base_file}"
    ls -lh "${base_file}"
    read -p \
      "Do you want to create symlinks for all the files in '${base_file}' to '/usr/bin/'? [y/n]: " \
    user_choice
    case "$user_choice" in
    [Yy]*)
      sudo ln -s ${base_file}/* /usr/bin/
      break
      ;;
    [Nn]*)
      echo "No changes have been made."
      break
      ;;
    *)
      echo "Select (y/n)."
      ;;
    esac
  done
done
