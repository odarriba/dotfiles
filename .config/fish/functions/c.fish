function c
    cd ~/code/$argv[1]
end

function __complete_c
    set base ~/code
    set arg (commandline -ct)  # texto actual después de `c `

    # Si el argumento está vacío, buscar en base
    if test -z "$arg"
        set dir "$base"
        set prefix ""
    else
        set dir "$base/$arg"
        while not test -d "$dir" -a -n "$dir"
            set dir (path dirname "$dir")
        end
        set prefix (string replace "$base/" '' -- "$dir")
    end

    # Agregar "/" si no está vacío (para construir rutas relativas)
    if test -n "$prefix"
        set prefix "$prefix/"
    end

    # Buscar solo los subdirectorios inmediatos dentro de $dir
    for subdir in "$dir"/*/
        if test -d "$subdir"
            set name (string replace "$base/" '' -- "$subdir")
            echo "$name"
        end
    end
end

complete -c c -a "(__complete_c)"
