export PATH="/home/ayamir/.cargo/bin:$PATH" 
 
STABLE=/home/ayamir/.rustup/toolchains/stable-x86_64-unknown-linux-gnu 
rustup toolchain link build-stable $STABLE &> /dev/null 
rustup default build-stable &> /dev/null
