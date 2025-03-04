grep -E '^(VERSION|NAME)=' /etc/os-release

OS=$(grep -E '^(VERSION|NAME)=' /etc/os-release)
echo $OS

if [[ "$OS" == "Astra Linux" ]]; then
     echo Astra Linux        
# ...
elif [[ "$OS" == "debian"* ]]; then
     echo Debian   
# ...
else
     echo Unknown   
        # Unknown.
fi

case "$OS" in
  solaris*) echo "SOLARIS" ;;
  darwin*)  echo "OSX" ;; 
  linux*)   echo "LINUX" ;;
  bsd*)     echo "BSD" ;;
  msys*)    echo "WINDOWS" ;;
  *)        echo "unknown: $OS" ;;
esac

