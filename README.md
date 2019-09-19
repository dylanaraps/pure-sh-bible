# pure sh bible

A collection of pure POSIX `sh` alternatives to external processes


## Table of Contents

<!-- vim-markdown-toc GFM -->

* [STRINGS](#strings)
    * [Strip pattern from start of string](#strip-pattern-from-start-of-string)
    * [Strip pattern from end of string](#strip-pattern-from-end-of-string)
    * [Trim all white-space from string and truncate spaces](#trim-all-white-space-from-string-and-truncate-spaces)
    * [Check if string contains a sub-string](#check-if-string-contains-a-sub-string)
    * [Check if string starts with sub-string](#check-if-string-starts-with-sub-string)
    * [Check if string ends with sub-string](#check-if-string-ends-with-sub-string)
* [FILES](#files)
    * [Get the first N lines of a file](#get-the-first-n-lines-of-a-file)

<!-- vim-markdown-toc -->


# STRINGS

## Strip pattern from start of string

**Example Function:**

```sh
lstrip() {
    # Usage: lstrip "string" "pattern"
    printf '%s\n' "${1##$2}"
}
```

**Example Usage:**

```shell
$ lstrip "The Quick Brown Fox" "The "
Quick Brown Fox
```

## Strip pattern from end of string

**Example Function:**

```sh
rstrip() {
    # Usage: rstrip "string" "pattern"
    printf '%s\n' "${1%%$2}"
}
```

**Example Usage:**

```shell
$ rstrip "The Quick Brown Fox" " Fox"
The Quick Brown
```

## Trim all white-space from string and truncate spaces

This is an alternative to `sed`, `awk`, `perl` and other tools. The
function below works by abusing word splitting to create a new string
without leading/trailing white-space and with truncated spaces.

**Example Function:**

```sh
# shellcheck disable=SC2086,SC2048
trim_all() {
    # Usage: trim_all "   example   string    "
    set -f
    set -- $*
    printf '%s\n' "$*"
    set +f
}
```

**Example Usage:**

```shell
$ trim_all "    Hello,    World    "
Hello, World

$ name="   John   Black  is     my    name.    "
$ trim_all "$name"
John Black is my name.
```

## Check if string contains a sub-string

**Using a case statement:**

```shell
case $var in
    *sub_string*)
        # Do stuff
    ;;

    *sub_string2*)
        # Do more stuff
    ;;

    *)
        # Else
    ;;
esac
```

## Check if string starts with sub-string

**Using a case statement:**

```shell
case $var in
    sub_string*)
        # Do stuff
    ;;

    sub_string2*)
        # Do more stuff
    ;;

    *)
        # Else
    ;;
esac
```

## Check if string ends with sub-string

**Using a case statement:**

```shell
case $var in
    *sub_string)
        # Do stuff
    ;;

    *sub_string2)
        # Do more stuff
    ;;

    *)
        # Else
    ;;
esac
```

# FILES

## Get the first N lines of a file

Alternative to the `head` command.

**Example Function:**

```sh
head() {
    # Usage: head "n" "file"
    while read -r line; do
        [ "$i" = "$1" ] && break
        printf '%s\n' "$line"
        i=$((i+1))
    done < "$2"
}
```

**Example Usage:**

```shell
$ head 2 ~/.bashrc
# Prompt
PS1='➜ '

$ head 1 ~/.bashrc
# Prompt
```
