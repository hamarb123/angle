// GENERATED FILE - DO NOT EDIT.
// Generated by gen_vk_internal_shaders.py.
//
// Copyright 2020 The ANGLE Project Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// shaders/gen/ImageClear.frag.00000003.inc:
//   Pre-generated shader for the ANGLE Vulkan back-end.

#pragma once
constexpr uint8_t kImageClear_frag_00000003[] = {
    0x1f,0x8b,0x08,0x00,0x00,0x00,0x00,0x00,0x02,0xff,0x4d,0x90,0x3d,0x4b,0x03,0x41,
    0x10,0x86,0x27,0xbb,0x66,0x2f,0xf7,0x61,0x2e,0xc9,0x79,0xd1,0x2a,0x44,0x52,0x0a,
    0xc1,0x42,0x25,0x10,0x14,0xac,0xb4,0x48,0xe7,0x2f,0x10,0x6c,0x2c,0xb4,0xd1,0x1f,
    0x6f,0x23,0xf8,0xce,0xde,0x23,0x64,0x61,0x76,0x66,0xde,0x79,0xe7,0x33,0x86,0x4d,
    0x61,0x36,0xb2,0xca,0x26,0x76,0x61,0xc3,0x9b,0x5b,0x10,0x62,0x56,0x5b,0xca,0xfa,
    0xe9,0xf0,0x72,0xd8,0x7e,0x7d,0xbf,0x6d,0x6f,0x6e,0xaf,0x3d,0x3e,0xb5,0x98,0x79,
    0x1e,0x6b,0xad,0xb0,0x13,0x69,0x97,0x8f,0xd7,0xf7,0x4f,0xc7,0x4b,0x49,0x27,0x99,
    0x89,0xe7,0x78,0x71,0x64,0x37,0x5e,0x4f,0x96,0x73,0x56,0xd4,0x78,0xb6,0xb1,0xfa,
    0x0f,0x6f,0x83,0xfe,0xc7,0x46,0x60,0xb3,0x9c,0x17,0x33,0x16,0xa8,0xd1,0xe5,0x19,
    0xcd,0x96,0xb9,0x5f,0xc8,0xf8,0xa5,0x38,0x11,0xce,0x52,0x56,0x92,0x5e,0x4b,0xce,
    0xc5,0xf7,0x39,0x12,0xb3,0xae,0xf5,0x4f,0xa4,0x23,0xf3,0xed,0xf1,0x4b,0xb0,0x95,
    0xfc,0x8a,0x58,0x82,0x5f,0x13,0xaf,0xe0,0xd7,0xec,0xe3,0x58,0x2f,0xff,0x94,0x5e,
    0x3e,0xf3,0x15,0xfe,0x94,0x7d,0x3c,0xbf,0x85,0x5b,0xe0,0x2f,0xe8,0x95,0xa8,0xb7,
    0xe0,0x6e,0xf1,0x28,0xff,0x8c,0x7a,0xce,0xef,0xc9,0x77,0xfe,0x9d,0xee,0x13,0xd8,
    0xc5,0xc8,0xf9,0x11,0x32,0x96,0x7e,0xd4,0xdf,0x72,0xb3,0x86,0x19,0xee,0xd9,0x7f,
    0x0e,0xfe,0xa0,0x8c,0x12,0xdf,0xf9,0x3d,0x77,0x6c,0xe8,0xe9,0xfc,0x94,0xef,0x36,
    0xe0,0xce,0xef,0xf0,0x7f,0x35,0xd1,0x4e,0xf2,0x07,0x1c,0xf7,0x86,0xfd,0x3c,0x02,
    0x00,0x00
};

// Generated from:
//
// #version 450 core
//
// layout(push_constant)uniform PushConstants {
//        vec4 clearColor;
//     float clearDepth;
// } params;
//
// layout(location = 1)out vec4 colorOut;
//
// void main()
// {
//     colorOut = params . clearColor;
//
//     gl_FragDepth = params . clearDepth;
//
// }
