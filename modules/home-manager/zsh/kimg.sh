set -euxo pipefail

FILE="$1"
shift

# kitty @ --to unix:/tmp/kitty_remote_control launch --type=tab --title="$FILE" --no-response \
#         bash -c "timg -pk -B gray --title='%f (%wm%h)' $* '$(realpath $FILE)' && read -sn1"
