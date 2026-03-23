# Stable Diffusion WebUI AMDGPU Forge Optimized for AMD Radeon RX 7900 XTX

<p align="center">
  <img src="forge-icon.png" alt="Stable Diffusion WebUI AMDGPU Forge Optimized for XT 7900 XTX" width="120"/>
</p>

Stable Diffusion WebUI AMDGPU Forge Optimized for GPU XT 7900 XTX is forked repository a platform on top of [Stable Diffusion WebUI AMDGPU Forge
](https://github.com/lshqqytiger/stable-diffusion-webui-amdgpu-forge/fork) that itselft is a plataform on top of [Stable Diffusion WebUI AMDGPU](https://github.com/lshqqytiger/stable-diffusion-webui-amdgpu) (based on [Gradio](https://www.gradio.app/) <a href='https://github.com/gradio-app/gradio'><img src='https://img.shields.io/github/stars/gradio-app/gradio'></a>) to make development easier, optimize resource management, speed up inference, and study experimental features.

The name "Forge" is inspired from "Minecraft Forge". This project is aimed at becoming SD WebUI AMDGPU's Forge.

Forge is currently based on SD-WebUI 1.10.1 at [this commit](https://github.com/AUTOMATIC1111/stable-diffusion-webui/commit/82a973c04367123ae98bd9abdf80d9eda9b910e2). (Because original SD-WebUI is almost static now, Forge will sync with original WebUI every 90 days, or when important fixes.)

This fork is specifically optimized for **AMD Radeon RX 7900 XTX (24GB)** and similar AMD GPUs using ROCm 7.1/7.2.

News are moved to this link: [Click here to see the News section](https://github.com/lllyasviel/stable-diffusion-webui-forge/blob/main/NEWS.md)

## What's different from original forge?

This is a merge of [stable-diffusion-webui-forge](https://github.com/lllyasviel/stable-diffusion-webui-forge) and [stable-diffusion-webui-amdgpu](https://github.com/lshqqytiger/stable-diffusion-webui-amdgpu), with additional optimizations for AMD Radeon RX 7900 XTX and similar GPUs.

**[DirectML](https://github.com/microsoft/DirectML)** support for every GPUs that support DirectX 12 API.

**[ZLUDA](https://github.com/vosen/ZLUDA)** support for AMDGPUs.

- `--use-directml`: Use DirectML as a torch backend.
- `--use-zluda`: Use ZLUDA as a torch backend.
- Support [ONNX Runtime](https://github.com/microsoft/onnxruntime).
- Support [Olive](https://github.com/microsoft/Olive) model optimization.

### AMD GPU Optimizations

This fork includes specialized optimizations for AMD Radeon RX 7900 XTX and similar GPUs:

- **Full Precision Training**: `--no-half --no-half-vae` for numerical stability
- **Upcasted Sampling**: `--upcast-sampling` for better quality results
- **Optimized Attention**: `--opt-sdp-attention --opt-sub-quad-attention` for AMD ROCm
- **Memory Management**: Configured ROCm environment variables for efficient memory handling

## Installation and Running

### Recommended Operating System

**Ubuntu 24.04 LTS** is the recommended operating system for optimal AMD GPU support.

Supported Ubuntu-based distributions:
- Ubuntu 24.04 LTS (primary recommendation)
- Kubuntu 24.04
- Xubuntu 24.04
- Ubuntu Budgie 24.04
- Other Ubuntu-based derivatives

**Important**: Ensure ROCm 7.1 or 7.2 is properly installed before running the webui.

### Forced Reinstall of Torch on First Launch

If you encounter issues with PyTorch installation or need to force reinstall:

1. Edit `webui-user.sh` and uncomment:
   ```bash
   export REINSTALL_TORCH=1
   export REINSTALL_DEPS=1
   ```

2. Run the webui launcher:
   ```bash
   ./webui.sh
   ```

3. After successful installation, comment out these lines to prevent reinstallation on subsequent launches.

### Using DirectML

DirectML is available for every gpu that supports DirectX 12.

If you are using one of recent AMDGPUs, ZLUDA is more recommended.

Start WebUI with `--use-directml`.

### Using ZLUDA

Most of AMDGPUs are compatible.

Start WebUI with `--use-zluda`.

Visit [SD.Next ZLUDA installation guide](https://github.com/vladmandic/sdnext/wiki/ZLUDA) for details.  
(Everything is same except for which repository you clone. You'll clone this repository instead of SD.Next if you want to use the original Stable diffusion WebUI)

# Quick List

[Gradio 4 UI Must Read (TLDR: You need to use RIGHT MOUSE BUTTON to move canvas!)](https://github.com/lllyasviel/stable-diffusion-webui-forge/discussions/853)

[Flux Tutorial (BitsandBytes Models, NF4, "GPU Weight", "Offload Location", "Offload Method", etc)](https://github.com/lllyasviel/stable-diffusion-webui-forge/discussions/981)

[Flux Tutorial 2 (Seperated Full Models, GGUF, Technically Correct Comparison between GGUF and NF4, etc)](https://github.com/lllyasviel/stable-diffusion-webui-forge/discussions/1050)

[Forge Extension List and Extension Replacement List (Temporary)](https://github.com/lllyasviel/stable-diffusion-webui-forge/discussions/1754)

[How to make LoRAs more precise on low-bit models; How to Skip" Patching LoRAs"; How to only load LoRA one time rather than each generation; How to report LoRAs that do not work](https://github.com/lllyasviel/stable-diffusion-webui-forge/discussions/1038)

[Report Flux Performance Problems (TLDR: DO NOT set "GPU Weight" too high! Lower "GPU Weight" solves 99% problems!)](https://github.com/lllyasviel/stable-diffusion-webui-forge/discussions/1181)

[How to solve "Connection errored out" / "Press anykey to continue ..." / etc](https://github.com/lllyasviel/stable-diffusion-webui-forge/discussions/1474)

[(Save Flux BitsandBytes UNet/Checkpoint)](https://github.com/lllyasviel/stable-diffusion-webui-forge/discussions/1224#discussioncomment-10384104)

[LayerDiffuse Transparent Image Editing](https://github.com/lllyasviel/stable-diffusion-webui-forge/discussions/854)

[Tell us what is missing in ControlNet Integrated](https://github.com/lllyasviel/stable-diffusion-webui-forge/discussions/932)

[(Policy) Soft Advertisement Removal Policy](https://github.com/lllyasviel/stable-diffusion-webui-forge/discussions/1286)

(Flux BNB NF4 / GGUF Q8_0/Q5_0/Q5_1/Q4_0/Q4_1 are all natively supported with GPU weight slider and Quene/Async Swap toggle and swap location toggle. All Flux BNB NF4 / GGUF Q8_0/Q5_0/Q4_0 have LoRA support.)

## AMD GPU Optimization Tools

This fork includes several helper scripts for managing your Stable Diffusion WebUI:

### reset.sh
A convenient script to restart the webui server:
```bash
./reset.sh
```
This will kill any process on port 7860 and launch the webui.

### shutdownserver.sh
A script to cleanly shutdown the webui server:
```bash
./shutdownserver.sh
```

### shutdown.logs.sh
A diagnostic script that gathers system logs before shutdown for troubleshooting:
```bash
./shutdown.logs.sh
```
This creates `shutdown_investigate.log` with kernel info, ACPI errors, power state, and shutdown logs.

## Environment Variables

The following environment variables are configured in `webui-user.sh` for optimal AMD GPU performance:

### Memory Management
- **PYTORCH_ALLOC_CONF**: Configures expandable segments, garbage collection threshold (0.9), and max split size (512MB)
  ```bash
  export PYTORCH_ALLOC_CONF=expandable_segments:True,garbage_collection_threshold:0.9,max_split_size_mb:512
  ```

- **PYTORCH_HIP_ALLOC_CONF**: ROCm-specific memory allocation settings
  ```bash
  export PYTORCH_HIP_ALLOC_CONF=garbage_collection_threshold:0.9,max_split_size_mb:512
  ```

### Performance Optimization
- **TORCH_BLAS_PREFER_HIPBLASLT=1**: Forces use of HIP BLAS library for better AMD GPU performance

- **OPENCV_LOG_LEVEL=ERROR**: Limits OpenCV logging to errors only (use DEBUG/INFO for more verbose logs)

- **QT_QPA_PLATFORM=offscreen**: Enables off-screen rendering, useful for headless environments

### Torch Installation
The default configuration uses PyTorch nightly builds with ROCm 7.2:
```bash
export TORCH_COMMAND="pip install --pre torch torchvision torchaudio joblib --index-url https://download.pytorch.org/whl/nightly/rocm7.2"
```

For stable releases, uncomment the ROCm 7.1 pre-built binaries line.

### Advanced Install

If you are proficient in Git and you want to install Forge as another branch of SD-WebUI, please see [here](https://github.com/continue-revolution/sd-webui-animatediff/blob/forge/master/docs/how-to-use.md#you-have-a1111-and-you-know-git). In this way, you can reuse all SD checkpoints and all extensions you installed previously in your OG SD-WebUI, but you should know what you are doing.

If you know what you are doing, you can also install Forge using same method as SD-WebUI. (Install Git, Python, Git Clone the forge repo `https://github.com/lllyasviel/stable-diffusion-webui-forge.git` and then run webui-user.bat).

### Previous Versions

You can download previous versions [here](https://github.com/lllyasviel/stable-diffusion-webui-forge/discussions/849).

# Forge Status

Based on manual test one-by-one:

| Component                                           | Status                                      | Last Test    |
| --------------------------------------------------- | ------------------------------------------- | ------------ |
| Basic Diffusion                                     | Normal                                      | 2024 Aug 26  |
| GPU Memory Management System                        | Normal                                      | 2024 Aug 26  |
| LoRAs                                               | Normal                                      | 2024 Aug 26  |
| All Preprocessors                                   | Normal                                      | 2024 Aug 26  |
| All ControlNets                                     | Normal                                      | 2024 Aug 26  |
| All IP-Adapters                                     | Normal                                      | 2024 Aug 26  |
| All Instant-IDs                                     | Normal                                      | 2024 July 27 |
| All Reference-only Methods                          | Normal                                      | 2024 July 27 |
| All Integrated Extensions                           | Normal                                      | 2024 July 27 |
| Popular Extensions (Adetailer, etc)                 | Normal                                      | 2024 July 27 |
| Gradio 4 UIs                                        | Normal                                      | 2024 July 27 |
| Gradio 4 Forge Canvas                               | Normal                                      | 2024 Aug 26  |
| LoRA/Checkpoint Selection UI for Gradio 4           | Normal                                      | 2024 July 27 |
| Photopea/OpenposeEditor/etc for ControlNet          | Normal                                      | 2024 July 27 |
| Wacom 128 level touch pressure support for Canvas   | Normal                                      | 2024 July 15 |
| Microsoft Surface touch pressure support for Canvas | Broken, pending fix                         | 2024 July 29 |
| ControlNets (Union)                                 | Not implemented yet, pending implementation | 2024 Aug 26  |
| ControlNets (Flux)                                  | Not implemented yet, pending implementation | 2024 Aug 26  |
| API endpoints (txt2img, img2img, etc)               | Normal, but pending improved Flux support   | 2024 Aug 29  |
| OFT LoRAs                                           | Broken, pending fix                         | 2024 Sep 9   |

Feel free to open issue if anything is broken and I will take a look every several days. If I do not update this "Forge Status" then it means I cannot reproduce any problem. In that case, fresh re-install should help most.

# UnetPatcher

Below are self-supported **single file** of all codes to implement FreeU V2.

See also `extension-builtin/sd_forge_freeu/scripts/forge_freeu.py`:

```python
import torch
import gradio as gr

from modules import scripts


def Fourier_filter(x, threshold, scale):
    # FFT
    x_freq = torch.fft.fftn(x.float(), dim=(-2, -1))
    x_freq = torch.fft.fftshift(x_freq, dim=(-2, -1))

    B, C, H, W = x_freq.shape
    mask = torch.ones((B, C, H, W), device=x.device)

    crow, ccol = H // 2, W // 2
    mask[..., crow - threshold:crow + threshold, ccol - threshold:ccol + threshold] = scale
    x_freq = x_freq * mask

    # IFFT
    x_freq = torch.fft.ifftshift(x_freq, dim=(-2, -1))
    x_filtered = torch.fft.ifftn(x_freq, dim=(-2, -1)).real

    return x_filtered.to(x.dtype)


def patch_freeu_v2(unet_patcher, b1, b2, s1, s2):
    model_channels = unet_patcher.model.diffusion_model.config["model_channels"]
    scale_dict = {model_channels * 4: (b1, s1), model_channels * 2: (b2, s2)}
    on_cpu_devices = {}

    def output_block_patch(h, hsp, transformer_options):
        scale = scale_dict.get(h.shape[1], None)
        if scale is not None:
            hidden_mean = h.mean(1).unsqueeze(1)
            B = hidden_mean.shape[0]
            hidden_max, _ = torch.max(hidden_mean.view(B, -1), dim=-1, keepdim=True)
            hidden_min, _ = torch.min(hidden_mean.view(B, -1), dim=-1, keepdim=True)
            hidden_mean = (hidden_mean - hidden_min.unsqueeze(2).unsqueeze(3)) / (hidden_max - hidden_min).unsqueeze(2).unsqueeze(3)

            h[:, :h.shape[1] // 2] = h[:, :h.shape[1] // 2] * ((scale[0] - 1) * hidden_mean + 1)

            if hsp.device not in on_cpu_devices:
                try:
                    hsp = Fourier_filter(hsp, threshold=1, scale=scale[1])
                except:
                    print("Device", hsp.device, "does not support the torch.fft.")
                    on_cpu_devices[hsp.device] = True
                    hsp = Fourier_filter(hsp.cpu(), threshold=1, scale=scale[1]).to(hsp.device)
            else:
                hsp = Fourier_filter(hsp.cpu(), threshold=1, scale=scale[1]).to(hsp.device)

        return h, hsp

    m = unet_patcher.clone()
    m.set_model_output_block_patch(output_block_patch)
    return m


class FreeUForForge(scripts.Script):
    sorting_priority = 12  # It will be the 12th item on UI.

    def title(self):
        return "FreeU Integrated"

    def show(self, is_img2img):
        # make this extension visible in both txt2img and img2img tab.
        return scripts.AlwaysVisible

    def ui(self, *args, **kwargs):
        with gr.Accordion(open=False, label=self.title()):
            freeu_enabled = gr.Checkbox(label='Enabled', value=False)
            freeu_b1 = gr.Slider(label='B1', minimum=0, maximum=2, step=0.01, value=1.01)
            freeu_b2 = gr.Slider(label='B2', minimum=0, maximum=2, step=0.01, value=1.02)
            freeu_s1 = gr.Slider(label='S1', minimum=0, maximum=4, step=0.01, value=0.99)
            freeu_s2 = gr.Slider(label='S2', minimum=0, maximum=4, step=0.01, value=0.95)

        return freeu_enabled, freeu_b1, freeu_b2, freeu_s1, freeu_s2

    def process_before_every_sampling(self, p, *script_args, **kwargs):
        # This will be called before every sampling.
        # If you use highres fix, this will be called twice.

        freeu_enabled, freeu_b1, freeu_b2, freeu_s1, freeu_s2 = script_args

        if not freeu_enabled:
            return

        unet = p.sd_model.forge_objects.unet

        unet = patch_freeu_v2(unet, freeu_b1, freeu_b2, freeu_s1, freeu_s2)

        p.sd_model.forge_objects.unet = unet

        # Below codes will add some logs to the texts below the image outputs on UI.
        # The extra_generation_params does not influence results.
        p.extra_generation_params.update(dict(
            freeu_enabled=freeu_enabled,
            freeu_b1=freeu_b1,
            freeu_b2=freeu_b2,
            freeu_s1=freeu_s1,
            freeu_s2=freeu_s2,
        ))

        return
```

See also [Forge's Unet Implementation](https://github.com/lllyasviel/stable-diffusion-webui-forge/blob/main/backend/nn/unet.py).

# Under Construction

WebUI Forge is now under some constructions, and docs / UI / functionality may change with updates.
