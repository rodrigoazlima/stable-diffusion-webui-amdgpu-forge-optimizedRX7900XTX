#!/bin/bash
#########################################################
# Uncomment and change the variables below to your need:#
#########################################################

# Install directory without trailing slash
#install_dir="/home/$(whoami)"

# Name of the subdirectory
#clone_dir="stable-diffusion-webui"

# Commandline arguments for webui.py, for example: export COMMANDLINE_ARGS="--medvram --opt-split-attention"
#export COMMANDLINE_ARGS=""

# Generic AMD optimizations
#export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --precision full --no-half --upcast-sampling --no-half-vae --medvram --opt-sub-quad-attention --disable-nan-check"

# Generic AMD Low RAM optimizations
#export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --precision full --no-half --no-half-vae --opt-sdp-attention --medvram --disable-nan-check"

## Specific AMD optimizations for The AMD Radeon RX 7900 XTX 24GB
export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --loglevel debug"
## Enables lower memory usage for the VAE, but may cause lower quality results and increased VRAM usage during sampling
#export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --lowvram --vae-in-cpu  "

## Disables certain operations that can slow down training:
# - Half-precision (float16) conversions
# - Using half-precision for the VAE
# - Upcasting sampling to use float32 instead of float16
# - Applying optimized attention mechanisms
# - Disabling NaN check during training
# - Applying sub-quadruple attention mechanism
export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --no-half --no-half-vae --upcast-sampling --opt-sdp-attention --disable-nan-check --opt-sub-quad-attention "

## Skips the test to run Torch CUDA operations, which can be faster on AMD GPUs
export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --skip-torch-cuda-test "

## Run locally LAN only
export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --listen --api --port 7860 "

## Allows access to insecure extensions in the UI (use with caution)
export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --enable-insecure-extension-access  "

# Waiting time before disconnecting idle requests (in seconds)
# This is commented out by default and should be adjusted based on your needs
# export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --timeout-keep-alive 3600"

# Enable TLS for secure communication. If self-signed certs are not present, they will be created.
#export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --tls-keyfile key.pem --tls-certfile cert.pem "

## Memory efficient attention for AMD GPUs
## AMD ROCm specific environment variables

export PYTORCH_ALLOC_CONF=expandable_segments:True,garbage_collection_threshold:0.9,max_split_size_mb:512
### This configuration enables expandable segments for memory management, which can help manage memory more efficiently by dynamically adjusting segment sizes.
### The garbage collection threshold is set to 0.9, meaning garbage will be collected when the memory usage exceeds 90% of the allocated capacity.
### The maximum split size for each segment is limited to 512 MB.

export PYTORCH_HIP_ALLOC_CONF=garbage_collection_threshold:0.9,max_split_size_mb:512
### Similar to PYTORCH_ALLOC_CONF, but specific to ROCm environments. It adjusts memory management and garbage collection parameters for better performance on AMD GPUs.

export TORCH_BLAS_PREFER_HIPBLASLT=1
####                               or 0 to test
### This setting ensures that the HIP BLAS library (part of the AMD ROCm stack) is used instead of the CPU-based BLAS library by default.
### Setting it to 0 might test the performance difference by using the CPU-based BLAS library, although this should be done with caution as ROCm often provides better performance.

export OPENCV_LOG_LEVEL=ERROR
## This variable controls the logging level for OpenCV. Setting it to ERROR ensures that only error messages are logged, which is useful for production environments.
## More detailed logs can be enabled by setting this to DEBUG or INFO if needed.

export QT_QPA_PLATFORM=offscreen
## This sets the Qt platform to off-screen rendering, which is useful for applications that do not require real-time visuals. It avoids unnecessary resource consumption in headless environments.

# python3 executable
python_cmd="python3.10"
## Defines the Python interpreter command to be used for executing scripts. Here, it points to Python 3.10 because its the most stable with rocm binaries.


# git executable
#export GIT="git"

# python3 venv without trailing slash (defaults to ${install_dir}/${clone_dir}/venv)
#venv_dir="venv"

# script to launch to start the app
#export LAUNCH_SCRIPT="launch.py"

# install command for torch

##Nvidea CUDA 11.3 (does not work on amd gpu)
#export TORCH_COMMAND="pip install torch==1.12.1+cu113 --extra-index-url https://download.pytorch.org/whl/cu113"


## Recomended instalation parameters
## Rocm (with PyTorch pre-built binaries):
## Nightly build for ROCm latest: please check https://download.pytorch.org/whl/nightly/ for latest rocm version, 
export TORCH_COMMAND="pip install --pre torch torchvision torchaudio joblib --index-url https://download.pytorch.org/whl/nightly/rocm7.2 " 
### Note: This option is useful for developers who need access to the latest features and bug fixes from PyTorch.

## Optional installations:
### Cmment these lines if you want to install cleaner versions.
export TORCH_COMMAND="$TORCH_COMMAND ; pip install onnxruntime-rocm --index-url https://pypi.org/simple "
export TORCH_COMMAND="$TORCH_COMMAND ; pip install \"setuptools<69\" ; pip install \"wheel<0.43\" "

## For more advanced users, you might want to use the optimum package for pre-trained models and transformers:
export TORCH_COMMAND="$TORCH_COMMAND ; pip install \"optimum[onnxruntime]\""

### If you need to use imageio-ffmpeg for handling video files in your scripts:
export TORCH_COMMAND="$TORCH_COMMAND ; pip install imageio-ffmpeg "

# Requirements file to use for stable-diffusion-webui
#export REQS_FILE="requirements_versions.txt"

# Fixed git repos
#export K_DIFFUSION_PACKAGE=""
#export GFPGAN_PACKAGE=""

# Fixed git commits
#export STABLE_DIFFUSION_COMMIT_HASH=""
#export CODEFORMER_COMMIT_HASH=""
#export BLIP_COMMIT_HASH=""

# Uncomment to enable accelerated launch
#export ACCELERATE="True"

# Uncomment to disable TCMalloc
#export NO_TCMALLOC="True"

###########################################

# Force reinstall torch next launch
#export REINSTALL_TORCH=1
#export REINSTALL_DEPS=1

###########################################
