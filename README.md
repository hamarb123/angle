# Additional info for hamarb123:

Latest stable Google Chrome chromium build branch can be found [here](https://chromiumdash.appspot.com/branches)

Download depot_tools from [here](https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools_tutorial.html#_setting_up)

To set up powershell building, do the following:
```ps1
$Env:PATH = "<path to depot_tools>;"+$Env:PATH
python scripts/bootstrap.py
gclient sync
cmd /c mklink /D out "<path to out directory>"
gn args out/Debug_x86 && gn args out/Checked_x86 && gn args out/Release_x86 && gn args out/Debug_x64 && gn args out/Checked_x64 && gn args out/Release_x64 && gn args out/Debug_arm64 && gn args out/Checked_arm64 && gn args out/Release_arm64
```

Can set up VS solutions with: `gn gen out/Debug_x86 --sln=angle --ide=vs2022 && gn gen out/Checked_x86 --sln=angle --ide=vs2022 && gn gen out/Release_x86 --sln=angle --ide=vs2022 && gn gen out/Debug_x64 --sln=angle --ide=vs2022 && gn gen out/Checked_x64 --sln=angle --ide=vs2022 && gn gen out/Release_x64 --sln=angle --ide=vs2022 && gn gen out/Debug_arm64 --sln=angle --ide=vs2022 && gn gen out/Checked_arm64 --sln=angle --ide=vs2022 && gn gen out/Release_arm64 --sln=angle --ide=vs2022`

Can build all configs like so: `autoninja -C out/Debug_x86 && autoninja -C out/Checked_x86 && autoninja -C out/Release_x86 && autoninja -C out/Debug_x64 && autoninja -C out/Checked_x64 && autoninja -C out/Release_x64 && autoninja -C out/Debug_arm64 && autoninja -C out/Checked_arm64 && autoninja -C out/Release_arm64 && .\make_win_files.ps1`

# How to move from one chromium feature branch base to another

To move from `4692` to `4951`:

Run `git fetch upstream chromium/4692 chromium/4951`

Run `git log upstream/chromium/4951..upstream/chromium/4692 --oneline`

Output:
```
a254f5c62 (upstream/chromium/4692) M97: Vulkan: Fix incorrect bit test when mipmapping
907d22344 [M97] Vulkan: Fix the UAF issue with BufferData
9272f74e2 M97: D3D11: Fix OOB access in vertex conversion code.
7ccfe9ae7 M97: Validate SamplerFormat
f4e66c4ba M97: Vulkan: Fix deferred flush vs UtilsVk
...
```

Run `git revert 9272f74e2 7ccfe9ae7 f4e66c4ba ...` with the commits above, in the order above, starting with the commit it is based off

Run `git merge upstream/chromium/4951`

To verify, run `git diff upstream/chromium/4951..hamarb123-main`

This should allow conflict-less merging & keep history intact.

# Recommended build settings:

```
# Build arguments go here.
# See "gn args <out_dir> --list" for available build arguments.
is_component_build = false
target_cpu = "x86"
is_clang = true
is_debug = true
is_official_build = false
angle_enable_null = true
angle_build_tests = false
```

or `target_cpu = "x64"` / `target_cpu = "arm64"` for those processors

or `is_debug = false` for Checked/Release mode

or `is_official_build = true` for Release mode

`is_component_build = false` allows only needing to distribute `libEGL.dll`, `libGLESv2.dll`, and (for &lt; Win 8.1) `d3dcompiler_47.dll`

`angle_build_tests = false` skips the tests, which makes the out folder much smaller

Windows fixes, modification to `build/compute_build_timestamp.py`:
```diff
-    if os.name == 'nt':
+    if os.name == 'nt_NEVER':
```

Windows and macOS fixes, modification to `build/config/compiler/pgo/pgo.gni`:
```diff
-    chrome_pgo_phase = 2
+    chrome_pgo_phase = 0
```

Windows fixes, modification to `third_party\libpng\BUILD.gn`:
```diff
     ]
     defines = [ "PNG_INTEL_SSE_OPT=1" ]
   } else if (target_cpu == "arm" || target_cpu == "arm64") {
-    sources += [
-      "src/arm/arm_init.c",
-      "src/arm/filter_neon_intrinsics.c",
-      "src/arm/palette_neon_intrinsics.c",
-    ]
     defines = [
-      "PNG_ARM_NEON_OPT=2",
-      "PNG_ARM_NEON_IMPLEMENTATION=1",
+      "PNG_ARM_NEON_OPT=0",
+      "PNG_ARM_NEON_IMPLEMENTATION=0",
     ]
   }
```

UWP fixes, modification to `src/common/platform.h`:
```diff
+#    include "winapifamily.h"
 #    include <intrin.h>

 #    if defined(WINAPI_FAMILY) && (WINAPI_FAMILY != WINAPI_FAMILY_DESKTOP_APP)
 #        define ANGLE_ENABLE_WINDOWS_UWP 1
 #    endif
```

# Note - To build UWP on Windows:

Change:
```
target_os = "winuwp"
is_clang = false
```

# macOS additional info

To set up building:
```
python scripts/bootstrap.py
gclient sync
gn args out/Debug_x64 && gn args out/Checked_x64 && gn args out/Release_x64 && gn args out/Debug_arm64 && gn args out/Checked_arm64 && gn args out/Release_arm64
```

Can build all configs like so: `autoninja -C out/Debug_x64 && autoninja -C out/Checked_x64 && autoninja -C out/Release_x64 && autoninja -C out/Debug_arm64 && autoninja -C out/Checked_arm64 && autoninja -C out/Release_arm64 && ./make_mac_files.command`

# ANGLE - Almost Native Graphics Layer Engine

The goal of ANGLE is to allow users of multiple operating systems to seamlessly run WebGL and other
OpenGL ES content by translating OpenGL ES API calls to one of the hardware-supported APIs available
for that platform. ANGLE currently provides translation from OpenGL ES 2.0, 3.0 and 3.1 to Vulkan,
desktop OpenGL, OpenGL ES, Direct3D 9, and Direct3D 11. Future plans include ES 3.2, translation to
Metal and MacOS, Chrome OS, and Fuchsia support.

### Level of OpenGL ES support via backing renderers

|                |  Direct3D 9   |  Direct3D 11     |   Desktop GL   |    GL ES      |  Vulkan  |    Metal      |
|----------------|:-------------:|:----------------:|:--------------:|:-------------:|:--------:|:-------------:|
| OpenGL ES 2.0  |    complete   |    complete      |    complete    |    complete   | complete |    complete   |
| OpenGL ES 3.0  |               |    complete      |    complete    |    complete   | complete |    complete   |
| OpenGL ES 3.1  |               |                  |    complete    |    complete   | complete |               |
| OpenGL ES 3.2  |               |                  |  in progress   |  in progress  | complete |               |

Additionally, OpenGL ES 1.1 is implemented in the front-end using OpenGL ES 3.0 features.  This
version of the specification is thus supported on all platforms specified above that support OpenGL
ES 3.0 with [known issues][ES1].

[ES1]: doc/ES1Status.md

### Platform support via backing renderers

|              |    Direct3D 9  |   Direct3D 11  |   Desktop GL  |    GL ES    |   Vulkan    |    Metal             |   WebGPU   |
|-------------:|:--------------:|:--------------:|:-------------:|:-----------:|:-----------:|:--------------------:|:----------:|
| Windows      |    complete    |    complete    |   complete    |   complete  |   complete  |                      |            |
| Linux        |                |                |   complete    |             |   complete  |                      |            |
| Mac OS X     |                |                |  deprecated   |             |             | complete [1]         |            |
| iOS          |                |                |               |             |             | complete [2]         |            |
| Chrome OS    |                |                |               |   complete  |   planned   |                      |            |
| Android      |                |                |               |   complete  |   complete  |                      |            |
| Fuchsia      |                |                |               |             |   complete  |                      |            |

[1] Metal is supported on macOS 10.14+

[2] Metal is supported on iOS 12+

ANGLE v1.0.772 was certified compliant by passing the OpenGL ES 2.0.3 conformance tests in October 2011.

ANGLE has received the following certifications with the Vulkan backend:
* OpenGL ES 2.0: ANGLE 2.1.0.d46e2fb1e341 (Nov, 2019)
* OpenGL ES 3.0: ANGLE 2.1.0.f18ff947360d (Feb, 2020)
* OpenGL ES 3.1: ANGLE 2.1.0.f5dace0f1e57 (Jul, 2020)
* OpenGL ES 3.2: ANGLE 2.1.2.21688.59f158c1695f (Sept, 2023)

ANGLE also provides an implementation of the EGL 1.5 specification.

ANGLE is used as the default WebGL backend for both Google Chrome and Mozilla Firefox on Windows
platforms. Chrome uses ANGLE for all graphics rendering on Windows, including the accelerated
Canvas2D implementation and the Native Client sandbox environment.

Portions of the ANGLE shader compiler are used as a shader validator and translator by WebGL
implementations across multiple platforms. It is used on Mac OS X, Linux, and in mobile variants of
the browsers. Having one shader validator helps to ensure that a consistent set of GLSL ES shaders
are accepted across browsers and platforms. The shader translator can be used to translate shaders
to other shading languages, and to optionally apply shader modifications to work around bugs or
quirks in the native graphics drivers. The translator targets Desktop GLSL, Vulkan GLSL, Direct3D
HLSL, and even ESSL for native GLES2 platforms.

### OpenCL Implementation

In addition to OpenGL ES, ANGLE also provides an optional `OpenCL` runtime built into the same
output GLES lib.

This work/effort is currently **work-in-progress/experimental**.

This work provides the same benefits as the OpenGL implementation, having OpenCL APIs be
translated to other HW-supported APIs available on that platform.

### Level of OpenCL support via backing renderers

|             |  Vulkan     |  OpenCL     |
|-------------|:-----------:|:-----------:|
| OpenCL 1.0  | in progress | in progress |
| OpenCL 1.1  | in progress | in progress |
| OpenCL 1.2  | in progress | in progress |
| OpenCL 3.0  | in progress | in progress |

Each supported backing renderer above ends up being an OpenCL `Platform` for the user to choose from.

The `OpenCL` backend is a "passthrough" implementation which does not perform any API translation
at all, instead forwarding API calls to other OpenCL driver(s)/implementation(s).

OpenCL also has an online compiler component to it that is used to compile `OpenCL C` source code at runtime
(similarly to GLES and GLSL). Depending on the chosen backend(s), compiler implementations may vary. Below is
a list of renderers and what OpenCL C compiler implementation is used for each:

- `Vulkan` : [clspv](https://github.com/google/clspv/tree/main)
- `OpenCL` : Compiler is part of the native driver

## Sources

ANGLE repository is hosted by Chromium project and can be
[browsed online](https://chromium.googlesource.com/angle/angle) or cloned with

    git clone https://chromium.googlesource.com/angle/angle


## Building

View the [Dev setup instructions](doc/DevSetup.md).

## Contributing

* Join our [Google group](https://groups.google.com/group/angleproject) to keep up to date.
* Join us on [Slack](https://chromium.slack.com) in the #angle channel. You can
  follow the instructions on the [Chromium developer page](https://www.chromium.org/developers/slack)
  for the steps to join the Slack channel. For Googlers, please follow the
  instructions on this [document](https://docs.google.com/document/d/1wWmRm-heDDBIkNJnureDiRO7kqcRouY2lSXlO6N2z6M/edit?usp=sharing)
  to use your google or chromium email to join the Slack channel.
* [File bugs](http://anglebug.com/new) in the [issue tracker](https://bugs.chromium.org/p/angleproject/issues/list) (preferably with an isolated test-case).
* [Choose an ANGLE branch](doc/ChoosingANGLEBranch.md) to track in your own project.


* Read ANGLE development [documentation](doc).
* Look at [pending](https://chromium-review.googlesource.com/q/project:angle/angle+status:open)
  and [merged](https://chromium-review.googlesource.com/q/project:angle/angle+status:merged) changes.
* Become a [code contributor](doc/ContributingCode.md).
* Use ANGLE's [coding standard](doc/CodingStandard.md).
* Learn how to [build ANGLE for Chromium development](doc/BuildingAngleForChromiumDevelopment.md).
* Get help on [debugging ANGLE](doc/DebuggingTips.md).
* Go through [ANGLE's orientation](doc/Orientation.md) and sift through [issues](https://issues.angleproject.org/). If you decide to take on any task, write a comment so you can get in touch with us, and more importantly, set yourself as the "owner" of the bug. This avoids having multiple people accidentally working on the same issue.


* Read about WebGL on the [Khronos WebGL Wiki](http://khronos.org/webgl/wiki/Main_Page).
* Learn about the internals of ANGLE:
  * [Overview](https://docs.google.com/presentation/d/1qal4GgddwlUw-TPaXRYeTWLXUoaemgggBuTfg6_rwjU) with a focus on the Vulkan backend (2022)
  * A [short presentation](https://youtu.be/QrIKdjmpmaA) on the Vulkan back-end (2018).
  * Historical [presentation](https://docs.google.com/presentation/d/1CucIsdGVDmdTWRUbg68IxLE5jXwCb2y1E9YVhQo0thg/pub?start=false&loop=false) on the evolution of ANGLE and its use in Chromium
  * Historical [presentation](https://drive.google.com/file/d/0Bw29oYeC09QbbHoxNE5EUFh0RGs/view?usp=sharing&resourcekey=0-CNvGnQGgFSvbXgX--Y_Iyg) with a focus on D3D
  * The details of the initial implementation of ANGLE in the [OpenGL Insights chapter on ANGLE](http://www.seas.upenn.edu/~pcozzi/OpenGLInsights/OpenGLInsights-ANGLE.pdf) (these details are severely out-of-date, and this reference is listed here for historical reference only)
* Read design docs on the [Vulkan back-end](src/libANGLE/renderer/vulkan/README.md)
* Read about ANGLE's [testing infrastructure](infra/README.md)
* View information on ANGLE's [supported extensions](doc/ExtensionSupport.md)
* If you use ANGLE in your own project, we'd love to hear about it!
