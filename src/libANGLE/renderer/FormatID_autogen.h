// GENERATED FILE - DO NOT EDIT.
// Generated by gen_angle_format_table.py using data from angle_format_data.json
//
// Copyright 2020 The ANGLE Project Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// ANGLE format enumeration.

#ifndef LIBANGLE_RENDERER_FORMATID_H_
#define LIBANGLE_RENDERER_FORMATID_H_

#include <cstdint>

namespace angle
{

enum class FormatID
{
    NONE,
    D16_UNORM,
    D24_UNORM_S8_UINT,
    D24_UNORM_X8_UINT,
    D32_FLOAT,
    D32_FLOAT_S8X24_UINT,
    D32_UNORM,
    S8_UINT,
    A16_FLOAT,
    A1R5G5B5_UNORM,
    A2R10G10B10_SINT_VERTEX,
    A2R10G10B10_SNORM_VERTEX,
    A2R10G10B10_SSCALED_VERTEX,
    A2R10G10B10_UINT_VERTEX,
    A2R10G10B10_UNORM_VERTEX,
    A2R10G10B10_USCALED_VERTEX,
    A32_FLOAT,
    A8_UNORM,
    ASTC_10x10_SRGB_BLOCK,
    ASTC_10x10_UNORM_BLOCK,
    ASTC_10x5_SRGB_BLOCK,
    ASTC_10x5_UNORM_BLOCK,
    ASTC_10x6_SRGB_BLOCK,
    ASTC_10x6_UNORM_BLOCK,
    ASTC_10x8_SRGB_BLOCK,
    ASTC_10x8_UNORM_BLOCK,
    ASTC_12x10_SRGB_BLOCK,
    ASTC_12x10_UNORM_BLOCK,
    ASTC_12x12_SRGB_BLOCK,
    ASTC_12x12_UNORM_BLOCK,
    ASTC_3x3x3_UNORM_BLOCK,
    ASTC_3x3x3_UNORM_SRGB_BLOCK,
    ASTC_4x3x3_UNORM_BLOCK,
    ASTC_4x3x3_UNORM_SRGB_BLOCK,
    ASTC_4x4_SRGB_BLOCK,
    ASTC_4x4_UNORM_BLOCK,
    ASTC_4x4x3_UNORM_BLOCK,
    ASTC_4x4x3_UNORM_SRGB_BLOCK,
    ASTC_4x4x4_UNORM_BLOCK,
    ASTC_4x4x4_UNORM_SRGB_BLOCK,
    ASTC_5x4_SRGB_BLOCK,
    ASTC_5x4_UNORM_BLOCK,
    ASTC_5x4x4_UNORM_BLOCK,
    ASTC_5x4x4_UNORM_SRGB_BLOCK,
    ASTC_5x5_SRGB_BLOCK,
    ASTC_5x5_UNORM_BLOCK,
    ASTC_5x5x4_UNORM_BLOCK,
    ASTC_5x5x4_UNORM_SRGB_BLOCK,
    ASTC_5x5x5_UNORM_BLOCK,
    ASTC_5x5x5_UNORM_SRGB_BLOCK,
    ASTC_6x5_SRGB_BLOCK,
    ASTC_6x5_UNORM_BLOCK,
    ASTC_6x5x5_UNORM_BLOCK,
    ASTC_6x5x5_UNORM_SRGB_BLOCK,
    ASTC_6x6_SRGB_BLOCK,
    ASTC_6x6_UNORM_BLOCK,
    ASTC_6x6x5_UNORM_BLOCK,
    ASTC_6x6x5_UNORM_SRGB_BLOCK,
    ASTC_6x6x6_UNORM_BLOCK,
    ASTC_6x6x6_UNORM_SRGB_BLOCK,
    ASTC_8x5_SRGB_BLOCK,
    ASTC_8x5_UNORM_BLOCK,
    ASTC_8x6_SRGB_BLOCK,
    ASTC_8x6_UNORM_BLOCK,
    ASTC_8x8_SRGB_BLOCK,
    ASTC_8x8_UNORM_BLOCK,
    B10G10R10A2_UNORM,
    B4G4R4A4_UNORM,
    B5G5R5A1_UNORM,
    B5G6R5_UNORM,
    B8G8R8A8_TYPELESS,
    B8G8R8A8_TYPELESS_SRGB,
    B8G8R8A8_UNORM,
    B8G8R8A8_UNORM_SRGB,
    B8G8R8X8_UNORM,
    BC1_RGBA_UNORM_BLOCK,
    BC1_RGBA_UNORM_SRGB_BLOCK,
    BC1_RGB_UNORM_BLOCK,
    BC1_RGB_UNORM_SRGB_BLOCK,
    BC2_RGBA_UNORM_BLOCK,
    BC2_RGBA_UNORM_SRGB_BLOCK,
    BC3_RGBA_UNORM_BLOCK,
    BC3_RGBA_UNORM_SRGB_BLOCK,
    BC4_RED_SNORM_BLOCK,
    BC4_RED_UNORM_BLOCK,
    BC5_RG_SNORM_BLOCK,
    BC5_RG_UNORM_BLOCK,
    BPTC_RGBA_UNORM_BLOCK,
    BPTC_RGB_SIGNED_FLOAT_BLOCK,
    BPTC_RGB_UNSIGNED_FLOAT_BLOCK,
    BPTC_SRGB_ALPHA_UNORM_BLOCK,
    EAC_R11G11_SNORM_BLOCK,
    EAC_R11G11_UNORM_BLOCK,
    EAC_R11_SNORM_BLOCK,
    EAC_R11_UNORM_BLOCK,
    ETC1_LOSSY_DECODE_R8G8B8_UNORM_BLOCK,
    ETC1_R8G8B8_UNORM_BLOCK,
    ETC2_R8G8B8A1_SRGB_BLOCK,
    ETC2_R8G8B8A1_UNORM_BLOCK,
    ETC2_R8G8B8A8_SRGB_BLOCK,
    ETC2_R8G8B8A8_UNORM_BLOCK,
    ETC2_R8G8B8_SRGB_BLOCK,
    ETC2_R8G8B8_UNORM_BLOCK,
    G8_B8_R8_3PLANE_420_UNORM,
    L16A16_FLOAT,
    L16_FLOAT,
    L32A32_FLOAT,
    L32_FLOAT,
    L8A8_UNORM,
    L8_UNORM,
    PVRTC1_RGBA_2BPP_UNORM_BLOCK,
    PVRTC1_RGBA_2BPP_UNORM_SRGB_BLOCK,
    PVRTC1_RGBA_4BPP_UNORM_BLOCK,
    PVRTC1_RGBA_4BPP_UNORM_SRGB_BLOCK,
    PVRTC1_RGB_2BPP_UNORM_BLOCK,
    PVRTC1_RGB_2BPP_UNORM_SRGB_BLOCK,
    PVRTC1_RGB_4BPP_UNORM_BLOCK,
    PVRTC1_RGB_4BPP_UNORM_SRGB_BLOCK,
    R10G10B10A2_SINT,
    R10G10B10A2_SNORM,
    R10G10B10A2_SSCALED,
    R10G10B10A2_UINT,
    R10G10B10A2_UNORM,
    R10G10B10A2_USCALED,
    R10G10B10X2_UNORM,
    R11G11B10_FLOAT,
    R16G16B16A16_FLOAT,
    R16G16B16A16_SINT,
    R16G16B16A16_SNORM,
    R16G16B16A16_SSCALED,
    R16G16B16A16_UINT,
    R16G16B16A16_UNORM,
    R16G16B16A16_USCALED,
    R16G16B16_FLOAT,
    R16G16B16_SINT,
    R16G16B16_SNORM,
    R16G16B16_SSCALED,
    R16G16B16_UINT,
    R16G16B16_UNORM,
    R16G16B16_USCALED,
    R16G16_FLOAT,
    R16G16_SINT,
    R16G16_SNORM,
    R16G16_SSCALED,
    R16G16_UINT,
    R16G16_UNORM,
    R16G16_USCALED,
    R16_FLOAT,
    R16_SINT,
    R16_SNORM,
    R16_SSCALED,
    R16_UINT,
    R16_UNORM,
    R16_USCALED,
    R32G32B32A32_FIXED,
    R32G32B32A32_FLOAT,
    R32G32B32A32_SINT,
    R32G32B32A32_SNORM,
    R32G32B32A32_SSCALED,
    R32G32B32A32_UINT,
    R32G32B32A32_UNORM,
    R32G32B32A32_USCALED,
    R32G32B32_FIXED,
    R32G32B32_FLOAT,
    R32G32B32_SINT,
    R32G32B32_SNORM,
    R32G32B32_SSCALED,
    R32G32B32_UINT,
    R32G32B32_UNORM,
    R32G32B32_USCALED,
    R32G32_FIXED,
    R32G32_FLOAT,
    R32G32_SINT,
    R32G32_SNORM,
    R32G32_SSCALED,
    R32G32_UINT,
    R32G32_UNORM,
    R32G32_USCALED,
    R32_FIXED,
    R32_FLOAT,
    R32_SINT,
    R32_SNORM,
    R32_SSCALED,
    R32_UINT,
    R32_UNORM,
    R32_USCALED,
    R4G4B4A4_UNORM,
    R5G5B5A1_UNORM,
    R5G6B5_UNORM,
    R8G8B8A8_SINT,
    R8G8B8A8_SNORM,
    R8G8B8A8_SSCALED,
    R8G8B8A8_TYPELESS,
    R8G8B8A8_TYPELESS_SRGB,
    R8G8B8A8_UINT,
    R8G8B8A8_UNORM,
    R8G8B8A8_UNORM_SRGB,
    R8G8B8A8_USCALED,
    R8G8B8_SINT,
    R8G8B8_SNORM,
    R8G8B8_SSCALED,
    R8G8B8_UINT,
    R8G8B8_UNORM,
    R8G8B8_UNORM_SRGB,
    R8G8B8_USCALED,
    R8G8_SINT,
    R8G8_SNORM,
    R8G8_SSCALED,
    R8G8_UINT,
    R8G8_UNORM,
    R8G8_USCALED,
    R8_SINT,
    R8_SNORM,
    R8_SSCALED,
    R8_UINT,
    R8_UNORM,
    R8_UNORM_SRGB,
    R8_USCALED,
    R9G9B9E5_SHAREDEXP,
    X2R10G10B10_SINT_VERTEX,
    X2R10G10B10_SNORM_VERTEX,
    X2R10G10B10_SSCALED_VERTEX,
    X2R10G10B10_UINT_VERTEX,
    X2R10G10B10_UNORM_VERTEX,
    X2R10G10B10_USCALED_VERTEX
};

constexpr uint32_t kNumANGLEFormats = 225;

}  // namespace angle

#endif  // LIBANGLE_RENDERER_FORMATID_H_
