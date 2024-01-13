function boj() {
    if [ -z $1 ]; then
        echo "Usage: boj 12345 [extension]"
        return
    fi
    rootdir="$HOME/Workspaces/codes"
    ext="$2"
    if [ -z $2 ]; then
        ext="cpp"
    fi

    if [ "rs" = $ext ]; then
        if [ ! -d "rs$1" ]; then
            cargo new "rs$1"
            rm "rs$1/src/main.rs"
            cp "$rootdir/template.rs" "rs$1/src/main.rs"
        fi
        vi "rs$1/src/main.rs"
    else
        filename="$1.$ext"
        if [ -f $filename ]; then
            vi "$filename"
        else
            cp "$rootdir/template.$ext" "$filename" && vi "$filename"
        fi
    fi
}
