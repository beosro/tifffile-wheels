function build_wheel {
    # Horrible set of build requirements installs too-recent numpy when using
    # default pip wheel command
    #ls -lah
    #ls -lah tifffile/
    #mkdir tifffile/tifffile/tests
    #ls -lah tifffile/tifffile/tests
    #touch tffffile/tifffile/tests/__init__.py
    #mv tifffile/test_tifffile.py tifffile/tifffile/tests/.
    build_bdist_wheel $@
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    pytest --doctest-modules --pyargs tifffile
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
