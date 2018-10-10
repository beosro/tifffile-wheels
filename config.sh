function build_wheel {
    # Horrible set of build requirements installs too-recent numpy when using
    # default pip wheel command
    build_bdist_wheel $@
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    # Doctests require dictorionaries to respect insertion order
    # This was an implementation detail in CPython3.6
    # And is standard in Python3.7
    # pytest --doctest-modules --pyargs tifffile
    python -c 'import tifffile'
}

if [ -n "$IS_OSX" ]; then
    function before_install {
        # Custom before_install to temporarily pin wheel to 0.31.1
        brew cask uninstall oclint || true
        export CC=clang
        export CXX=clang++
        get_macpython_environment $MB_PYTHON_VERSION venv
        source venv/bin/activate
        pip install --upgrade pip
        pip install wheel==0.31.1
    }
fi
