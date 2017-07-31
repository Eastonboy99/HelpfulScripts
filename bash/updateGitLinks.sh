
#!/bin/bash
url=null
# Define help function
function help(){
    echo "test - test";
    echo "Usage example:";
    echo "test (-d|--gitDirectory) string (-n|--newUrl) string (-o|--oldUrl) string [(-h|--help)] [(-v|--verbose)] [(-V|--version)]";
    echo "Options:";
    echo "-h or --help: Displays this information.";
    echo "-v or --verbose: Verbose mode on.";
    echo "-V or --version: Displays the current version number.";
    echo "-d or --gitDirectory string: Specify Directory where all git repos are stored. Required.";
    echo "-n or --newUrl string: The url to replace the old url with. Required.";
    echo "-o or --oldUrl string: The url to replace. Required.";
    exit 1;
}

# Declare vars. Flags initalizing to 0.
verbose=0;
version=0;

# Execute getopt
ARGS=$(getopt -o "hvVd:n:o:" -l "help,verbose,version,gitDirectory:,newUrl:,oldUrl:" -n "test" -- "$@");

#Bad arguments
if [ $? -ne 0 ];
then
    help;
fi

eval set -- "$ARGS";

while true; do
    case "$1" in
        -h|--help)
            shift;
            help;
            ;;
        -v|--verbose)
            shift;
                    verbose="1";
            ;;
        -V|--version)
            shift;
                    version="1";
            ;;
        -d|--gitDirectory)
            shift;
                    if [ -n "$1" ]; 
                    then
                        gitDirectory="$1";
                        shift;
                    fi
            ;;
        -n|--newUrl)
            shift;
                    if [ -n "$1" ]; 
                    then
                        newUrl="$1";
                        shift;
                    fi
            ;;
        -o|--oldUrl)
            shift;
                    if [ -n "$1" ]; 
                    then
                        oldUrl="$1";
                        shift;
                    fi
            ;;

        --)
            shift;
            break;
            ;;
    esac
done

# Check required arguments
if [ -z "$gitDirectory" ]
then
    echo "gitDirectory is required";
    help;
fi

# Iterate over rest arguments called $arg
for arg in "$@"
do
    # Your code here (remove example below)
    echo $arg

done
if [ -z "$newUrl" ]
then
    echo "newUrl is required";
    help;
fi

# Iterate over rest arguments called $arg
for arg in "$@"
do
    # Your code here (remove example below)
    echo $arg

done
if [ -z "$oldUrl" ]
then
    echo "oldUrl is required";
    help;
fi

# Iterate over rest arguments called $arg
for arg in "$@"
do
    # Your code here (remove example below)
    echo $arg

done
IFS=$'\n'
for fn in `find $gitDirectory -maxdepth 1 -type d`; do
cd $fn

if [ -d .git ]; then
    echo "Editing $fn remotes"

    IFS=$'\n' 
    for remote in $(git remote -v | grep $oldUrl ) ;do
    name=$(echo $remote | grep $oldUrl |cut -f 1)
    url=$(echo $remote |cut -f 2 | cut -d " " -f 1)
    type=$(echo $remote|cut -f 2 | cut -d " " -f 2)
    url="${url/$oldUrl/$newUrl}"
    echo $name
    if [ $type == "(push)" ];then
        git remote set-url --push $name $url
    else
        git remote set-url $name $url
    fi
        # git remote --seturl $name $url
done
fi;
done













# #!/bin/bash
# DIRS=()

# # echo "${DIRS}"

