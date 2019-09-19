#!/bin/sh
# shellcheck source=/dev/null
#
# Tests for the Pure sh Bible.

main() {
    trap 'rm -f readme_code test_file' EXIT INT

    # Extract code blocks from the README.
    while read -r line; do
        [ "$code" ] && [ "$line" != \`\`\` ] &&
            printf '%s\n' "$line"

        case $line in
            \`\`\`sh) code=1 ;;
            \`\`\`)   code=
        esac
    done < README.md > readme_code

    # Run shellcheck and source the code.
    shellcheck -s sh readme_code test.sh || exit 1
}

main "$@"
