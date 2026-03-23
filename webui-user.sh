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

# Generic AMD optimizations (commented examples - uncomment and adjust as needed)
# Full precision training with optimized attention
#export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --precision full --no-half --upcast-sampling --no-half-vae --medvram --opt-sub-quad-attention --disable-nan-check"
#
# Low RAM optimization (trade quality for memory efficiency)
#export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --precision full --no-half --no-half-vae --opt-sdp-attention --medvram --disable-nan-check"

## Specific AMD optimizations for The AMD Radeon RX 7900 XTX 24GB
export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --loglevel debug"
## Enables lower memory usage for the VAE (VAE = Variational Autoencoder)
## Trade-off: May cause lower quality results and increased VRAM usage during sampling
#export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --lowvram --vae-in-cpu  "

## Disables certain operations that can slow down training/generation:
##   --no-half         : Use full precision (float32) instead of half precision (float16)
##   --no-half-vae     : Use full precision for VAE, preventing potential quality loss
##   --upcast-sampling : Convert sampling to float32 for better numerical stability
##   --opt-sdp-attention: Use scaled dot product attention (optimized for ROCm)
##   --disable-nan-check: Skip NaN value checks (faster execution)
##   --opt-sub-quad-attention: Optimized attention mechanism for AMD GPUs
export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --no-half --no-half-vae --upcast-sampling --opt-sdp-attention --disable-nan-check --opt-sub-quad-attention "

## Skips the test to run Torch CUDA operations, which can be faster on AMD GPUs
## This prevents unnecessary CUDA detection checks that don't apply to ROCm
export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --skip-torch-cuda-test "

## Run locally LAN only (accessible from other devices on your network)
##   --listen      : Allow connections from any IP (0.0.0.0)
##   --api         : Enable REST API endpoint for programmatic access
##   --port 7860   : Web UI will be accessible at http://your-ip:7860
export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --listen --api --port 7860 "

## Allows access to insecure extensions in the UI (use with caution)
## This bypasses safety checks for extensions not from official repository
export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --enable-insecure-extension-access  "

# Waiting time before disconnecting idle requests (in seconds)
# Set to higher values (e.g., 3600 = 1 hour) if you have long-running generations
# export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --timeout-keep-alive 3600"

# Enable TLS for secure communication. If self-signed certs are not present, they will be created.
# This enables HTTPS access instead of HTTP
#export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --tls-keyfile key.pem --tls-certfile cert.pem "

## Memory efficient attention for AMD GPUs
## AMD ROCm specific environment variables

## PYTORCH_ALLOC_CONF - PyTorch memory allocator configuration:
##   expandable_segments:True      : Allows GPU memory segments to grow dynamically
##                                   This prevents fragmentation and improves memory utilization
##   garbage_collection_threshold:0.9 : Triggers garbage collection when 90% of memory is used
##   max_split_size_mb:512         : Maximum size for memory split operations (prevents fragmentation)
export PYTORCH_ALLOC_CONF=expandable_segments:True,garbage_collection_threshold:0.9,max_split_size_mb:512

## PYTORCH_HIP_ALLOC_CONF - HIP (Heterogeneous-compute Interface for Portability) specific config:
##   Similar to PYTORCH_ALLOC_CONF but specifically for ROCm/HIP memory management
##   HIP is AMD's alternative to CUDA for GPU computing
export PYTORCH_HIP_ALLOC_CONF=garbage_collection_threshold:0.9,max_split_size_mb:512

## TORCH_BLAS_PREFER_HIPBLASLT=1 - BLAS (Basic Linear Algebra Subprograms) configuration:
##   HIPBLASLt is AMD's optimized linear algebra library for ROCm
##   Setting to 1 uses AMD's GPU-optimized BLAS instead of CPU fallback
##   Set to 0 only if you need to compare performance with CPU-based BLAS
export TORCH_BLAS_PREFER_HIPBLASLT=1

## OPENCV_LOG_LEVEL=ERROR - OpenCV library logging control:
##   Controls verbosity of OpenCV (computer vision) operations
##   Options: DEBUG, INFO, WARN, ERROR, FATAL
##   Use DEBUG/INFO during development/troubleshooting; ERROR for production
export OPENCV_LOG_LEVEL=ERROR

## QT_QPA_PLATFORM=offscreen - Qt platform configuration:
##   Qt is used by some Python libraries for image display functions
##   offscreen mode: No GUI rendering (saves resources in headless/server setup)
##   Remove this if you need GUI features in extensions that use Qt
export QT_QPA_PLATFORM=offscreen

# python3 executable
python_cmd="python3.10"
## Defines the Python interpreter command to be used for executing scripts.
## Python 3.10 is specified because it's the most stable version with ROCm pre-built binaries.

# git executable
#export GIT="git"

# python3 venv without trailing slash (defaults to ${install_dir}/${clone_dir}/venv)
#venv_dir="venv"

# script to launch to start the app
#export LAUNCH_SCRIPT="launch.py"

## T torch - Core PyTorch library for tensor computations and deep learning on GPU
##   Provides automatic differentiation, GPU acceleration via ROCm/HIP, and neural network modules

## torchvision - Computer vision library extending PyTorch:
##   Includes popular datasets (ImageNet, CIFAR), pre-trained models (ResNet, VGG),
##   and image transformations/augmentations for Stable Diffusion image processing

## torchaudio - Audio processing extension for PyTorch:
##   Provides audio I/O, transforms, and models for audio-related features in extensions

## joblib - Lightweight Python package for pipelining:
##   Used by scikit-learn and other libraries for caching and parallel processing
##   Helps with memory management during model loading

## onnxruntime-rocm - ROCm-optimized ONNX Runtime:
##   Executes ML models in ONNX (Open Neural Network Exchange) format on AMD GPUs
##   Used by some extensions and model optimization features

## setuptools <69 - Python package development tools:
##   Version constraint prevents compatibility issues with older Python packages
##   Required for installing packages from source distributions

## wheel <0.43 - Built distribution format support:
##   Version constraint ensures compatibility with PyTorch ROCm wheels
##   Faster installation than source distributions (pre-compiled)

## optimum[onnxruntime] - Model optimization library:
##   Enables model quantization, pruning, and other optimizations
##   Supports ONNX Runtime execution for faster inference

## imageio-ffmpeg - Video file handling with FFmpeg backend:
##   Allows extensions to read/write video files
##   Required for video generation features in some extensions

# install command for torch
## This installs the complete PyTorch ecosystem with AMD ROCm support

## NVIDA CUDA 11.3 (does not work on AMD GPU - use only for NVIDIA cards)
#export TORCH_COMMAND="pip install torch==1.12.1+cu113 --extra-index-url https://download.pytorch.org/whl/cu113"

## Recommended installation parameters

## ROCm with PyTorch pre-built binaries (stable release):
## Uncomment below for stable ROCm 7.1/7.2 release builds
#export TORCH_COMMAND="pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm7.1"

## Nightly build for ROCm latest: please check https://download.pytorch.org/whl/nightly/ for latest rocm version
## Why use nightly builds:
##   - Latest AMD GPU driver support and bug fixes
##   - Performance improvements not yet in stable releases
##   - Support for newer ROCm versions before they're fully released
## Trade-offs: May be less stable than official releases but usually very reliable
export TORCH_COMMAND="pip install --pre torch torchvision torchaudio joblib --index-url https://download.pytorch.org/whl/nightly/rocm7.2"

## Optional installations - uncomment these lines if you want cleaner versions without extras:

## ONNX Runtime for ROCm (enables ONNX model execution on AMD GPUs)
export TORCH_COMMAND="$TORCH_COMMAND ; pip install onnxruntime-rocm --index-url https://pypi.org/simple "

## Version constraints for compatibility with PyTorch and Python:
## setuptools <69 : Prevents installation errors with older packages
## wheel <0.43    : Ensures binary wheel compatibility
export TORCH_COMMAND="$TORCH_COMMAND ; pip install \"setuptools<69\" ; pip install \"wheel<0.43\" "

## For more advanced users - Optimum library for model optimization:
##   Provides quantization, pruning, and other optimizations
##   Useful for running larger models on limited VRAM
export TORCH_COMMAND="$TORCH_COMMAND ; pip install \"optimum[onnxruntime]\""

### If you need to use imageio-ffmpeg for handling video files in your scripts:
##   Enables reading/writing video files with FFmpeg backend
##   Used by some extensions for video generation features
export TORCH_COMMAND="$TORCH_COMMAND ; pip install imageio-ffmpeg "

# Requirements file to use for stable-diffusion-webui
#export REQS_FILE="requirements_versions.txt"

# Fixed git repos (uncomment and set specific commits for reproducibility)
#export K_DIFFUSION_PACKAGE=""
#export GFPGAN_PACKAGE=""

# Fixed git commits (pin specific versions for stability)
#export STABLE_DIFFUSION_COMMIT_HASH=""
#export CODEFORMER_COMMIT_HASH=""
#export BLIP_COMMIT_HASH=""

# Uncomment to enable accelerated launch (uses accelerate package for multi-GPU)
#export ACCELERATE="True"

# Uncomment to disable TCMalloc (Google's memory allocator)
## TCMalloc can improve memory allocation performance; disable only if causing issues
#export NO_TCMALLOC="True"

###########################################

# Force reinstall torch on next launch:
##   Set these to 1 to force reinstall PyTorch and dependencies
##   Useful when switching between CUDA/ROCm or fixing installation issues
#export REINSTALL_TORCH=1
#export REINSTALL_DEPS=1

###########################################