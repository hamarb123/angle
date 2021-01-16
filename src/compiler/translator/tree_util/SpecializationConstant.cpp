//
// Copyright 2020 The ANGLE Project Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// SpecializationConst.cpp: Add code to generate AST node for various specialization constants.
//

#include "compiler/translator/tree_util/SpecializationConstant.h"
#include "common/PackedEnums.h"
#include "common/angleutils.h"
#include "compiler/translator/StaticType.h"
#include "compiler/translator/SymbolTable.h"
#include "compiler/translator/tree_util/IntermNode_util.h"

namespace sh
{

namespace
{
// Specialization constant names
constexpr ImmutableString kLineRasterEmulationSpecConstVarName =
    ImmutableString("ANGLELineRasterEmulation");
constexpr ImmutableString kSurfaceRotationSpecConstVarName =
    ImmutableString("ANGLESurfaceRotation");
constexpr ImmutableString kDrawableWidthSpecConstVarName  = ImmutableString("ANGLEDrawableWidth");
constexpr ImmutableString kDrawableHeightSpecConstVarName = ImmutableString("ANGLEDrawableHeight");

// When an Android surface is rotated differently than the device's native orientation, ANGLE must
// rotate gl_Position in the vertex shader and gl_FragCoord in the fragment shader.  The following
// are the rotation matrices used.
//
// This is 2x2 matrix in column major. The first column is for dFdx and second column is for dFdy.
using Mat2x2 = std::array<float, 4>;
using Mat2x2EnumMap =
    angle::PackedEnumMap<vk::SurfaceRotation, Mat2x2, angle::EnumSize<vk::SurfaceRotation>()>;

constexpr Mat2x2EnumMap kFragRotationMatrices = {
    {{vk::SurfaceRotation::Identity, {{1.0f, 0.0f, 0.0f, 1.0f}}},
     {vk::SurfaceRotation::Rotated90Degrees, {{0.0f, 1.0f, 1.0f, 0.0f}}},
     {vk::SurfaceRotation::Rotated180Degrees, {{1.0f, 0.0f, 0.0f, 1.0f}}},
     {vk::SurfaceRotation::Rotated270Degrees, {{0.0f, 1.0f, 1.0f, 0.0f}}},
     {vk::SurfaceRotation::FlippedIdentity, {{1.0f, 0.0f, 0.0f, 1.0f}}},
     {vk::SurfaceRotation::FlippedRotated90Degrees, {{0.0f, 1.0f, 1.0f, 0.0f}}},
     {vk::SurfaceRotation::FlippedRotated180Degrees, {{1.0f, 0.0f, 0.0f, 1.0f}}},
     {vk::SurfaceRotation::FlippedRotated270Degrees, {{0.0f, 1.0f, 1.0f, 0.0f}}}}};

// TODO: https://issuetracker.google.com/174066134. This is to make sure the specialization constant
// code path behaves exactly the same as driver uniform code path. Not sure why this has to be
// different from kFragRotationMatrices.
constexpr Mat2x2EnumMap kHalfRenderAreaRotationMatrices = {
    {{vk::SurfaceRotation::Identity, {{1.0f, 0.0f, 0.0f, 1.0f}}},
     {vk::SurfaceRotation::Rotated90Degrees, {{0.0f, 1.0f, 1.0f, 0.0f}}},
     {vk::SurfaceRotation::Rotated180Degrees, {{1.0f, 0.0f, 0.0f, 1.0f}}},
     {vk::SurfaceRotation::Rotated270Degrees, {{1.0f, 0.0f, 0.0f, 1.0f}}},
     {vk::SurfaceRotation::FlippedIdentity, {{1.0f, 0.0f, 0.0f, 1.0f}}},
     {vk::SurfaceRotation::FlippedRotated90Degrees, {{0.0f, 1.0f, 1.0f, 0.0f}}},
     {vk::SurfaceRotation::FlippedRotated180Degrees, {{1.0f, 0.0f, 0.0f, 1.0f}}},
     {vk::SurfaceRotation::FlippedRotated270Degrees, {{1.0f, 0.0f, 0.0f, 1.0f}}}}};

// Returns mat2(m0, m1, m2, m3)
TIntermAggregate *CreateMat2x2(const Mat2x2EnumMap &matrix, vk::SurfaceRotation rotation)
{
    auto mat2Type             = new TType(EbtFloat, 2, 2);
    TIntermSequence *mat2Args = new TIntermSequence();
    mat2Args->push_back(CreateFloatNode(matrix[rotation][0]));
    mat2Args->push_back(CreateFloatNode(matrix[rotation][1]));
    mat2Args->push_back(CreateFloatNode(matrix[rotation][2]));
    mat2Args->push_back(CreateFloatNode(matrix[rotation][3]));
    TIntermAggregate *constVarConstructor =
        TIntermAggregate::CreateConstructor(*mat2Type, mat2Args);
    return constVarConstructor;
}

// Generates an array of vec2 and then use rotation to retrieve the desired flipXY out.
TIntermTyped *GenerateMat2x2ArrayWithIndex(const Mat2x2EnumMap &matrix, TIntermSymbol *rotation)
{
    auto mat2Type        = new TType(EbtFloat, 2, 2);
    TType *typeMat2Array = new TType(*mat2Type);
    typeMat2Array->makeArray(static_cast<unsigned int>(vk::SurfaceRotation::EnumCount));

    TIntermSequence *sequences;
    sequences =
        new TIntermSequence({CreateMat2x2(matrix, vk::SurfaceRotation::Identity),
                             CreateMat2x2(matrix, vk::SurfaceRotation::Rotated90Degrees),
                             CreateMat2x2(matrix, vk::SurfaceRotation::Rotated180Degrees),
                             CreateMat2x2(matrix, vk::SurfaceRotation::Rotated270Degrees),
                             CreateMat2x2(matrix, vk::SurfaceRotation::FlippedIdentity),
                             CreateMat2x2(matrix, vk::SurfaceRotation::FlippedRotated90Degrees),
                             CreateMat2x2(matrix, vk::SurfaceRotation::FlippedRotated180Degrees),
                             CreateMat2x2(matrix, vk::SurfaceRotation::FlippedRotated270Degrees)});
    TIntermTyped *array = TIntermAggregate::CreateConstructor(*typeMat2Array, sequences);
    return new TIntermBinary(EOpIndexDirect, array, rotation);
}

using Vec2 = std::array<float, 2>;
using Vec2EnumMap =
    angle::PackedEnumMap<vk::SurfaceRotation, Vec2, angle::EnumSize<vk::SurfaceRotation>()>;
constexpr Vec2EnumMap kFlipXYValue = {
    {{vk::SurfaceRotation::Identity, {{1.0f, 1.0f}}},
     {vk::SurfaceRotation::Rotated90Degrees, {{1.0f, 1.0f}}},
     {vk::SurfaceRotation::Rotated180Degrees, {{-1.0f, 1.0f}}},
     {vk::SurfaceRotation::Rotated270Degrees, {{-1.0f, -1.0f}}},
     {vk::SurfaceRotation::FlippedIdentity, {{1.0f, -1.0f}}},
     {vk::SurfaceRotation::FlippedRotated90Degrees, {{1.0f, 1.0f}}},
     {vk::SurfaceRotation::FlippedRotated180Degrees, {{1.0f, 1.0f}}},
     {vk::SurfaceRotation::FlippedRotated270Degrees, {{-1.0f, -1.0f}}}}};

// Returns [[flipX*m0+flipY*m1]  [flipX*m2+flipY*m3]] where [m0 m1] is the first column of
// kFragRotation matrix and [m2 m3] is the second column of kFragRotation matrix.
constexpr Vec2 CalcFragRotationMultiplyFlipXY(vk::SurfaceRotation rotation)
{
    return Vec2({kFlipXYValue[rotation][0] * kFragRotationMatrices[rotation][0] +
                     kFlipXYValue[rotation][1] * kFragRotationMatrices[rotation][1],
                 kFlipXYValue[rotation][0] * kFragRotationMatrices[rotation][2] +
                     kFlipXYValue[rotation][1] * kFragRotationMatrices[rotation][3]});
}

// Returns vec2(vec2Values.x, vec2Values.y*yscale)
TIntermAggregate *CreateVec2(Vec2EnumMap vec2Values, float yscale, vk::SurfaceRotation rotation)
{
    auto vec2Type             = new TType(EbtFloat, 2);
    TIntermSequence *vec2Args = new TIntermSequence();
    vec2Args->push_back(CreateFloatNode(vec2Values[rotation][0]));
    vec2Args->push_back(CreateFloatNode(vec2Values[rotation][1] * yscale));
    TIntermAggregate *constVarConstructor =
        TIntermAggregate::CreateConstructor(*vec2Type, vec2Args);
    return constVarConstructor;
}

// Generates an array of vec2 and then use rotation to retrieve the desired flipXY out.
TIntermTyped *CreateVec2ArrayWithIndex(Vec2EnumMap vec2Values,
                                       float yscale,
                                       TIntermSymbol *rotation)
{
    auto vec2Type        = new TType(EbtFloat, 2);
    TType *typeVec2Array = new TType(*vec2Type);
    typeVec2Array->makeArray(static_cast<unsigned int>(vk::SurfaceRotation::EnumCount));

    TIntermSequence *sequences;
    sequences = new TIntermSequence(
        {CreateVec2(vec2Values, yscale, vk::SurfaceRotation::Identity),
         CreateVec2(vec2Values, yscale, vk::SurfaceRotation::Rotated90Degrees),
         CreateVec2(vec2Values, yscale, vk::SurfaceRotation::Rotated180Degrees),
         CreateVec2(vec2Values, yscale, vk::SurfaceRotation::Rotated270Degrees),
         CreateVec2(vec2Values, yscale, vk::SurfaceRotation::FlippedIdentity),
         CreateVec2(vec2Values, yscale, vk::SurfaceRotation::FlippedRotated90Degrees),
         CreateVec2(vec2Values, yscale, vk::SurfaceRotation::FlippedRotated180Degrees),
         CreateVec2(vec2Values, yscale, vk::SurfaceRotation::FlippedRotated270Degrees)});
    TIntermTyped *vec2Array = TIntermAggregate::CreateConstructor(*typeVec2Array, sequences);
    return new TIntermBinary(EOpIndexDirect, vec2Array, rotation);
}

// Returns [flipX*m0, flipY*m1], where [m0 m1] is the first column of kFragRotation matrix.
constexpr Vec2 CalcRotatedFlipXYValueForDFdx(vk::SurfaceRotation rotation)
{
    return Vec2({kFlipXYValue[rotation][0] * kFragRotationMatrices[rotation][0],
                 kFlipXYValue[rotation][1] * kFragRotationMatrices[rotation][1]});
}
constexpr Vec2EnumMap kRotatedFlipXYForDFdx = {
    {{vk::SurfaceRotation::Identity, CalcRotatedFlipXYValueForDFdx(vk::SurfaceRotation::Identity)},
     {vk::SurfaceRotation::Rotated90Degrees,
      CalcRotatedFlipXYValueForDFdx(vk::SurfaceRotation::Rotated90Degrees)},
     {vk::SurfaceRotation::Rotated180Degrees,
      CalcRotatedFlipXYValueForDFdx(vk::SurfaceRotation::Rotated180Degrees)},
     {vk::SurfaceRotation::Rotated270Degrees,
      CalcRotatedFlipXYValueForDFdx(vk::SurfaceRotation::Rotated270Degrees)},
     {vk::SurfaceRotation::FlippedIdentity,
      CalcRotatedFlipXYValueForDFdx(vk::SurfaceRotation::FlippedIdentity)},
     {vk::SurfaceRotation::FlippedRotated90Degrees,
      CalcRotatedFlipXYValueForDFdx(vk::SurfaceRotation::FlippedRotated90Degrees)},
     {vk::SurfaceRotation::FlippedRotated180Degrees,
      CalcRotatedFlipXYValueForDFdx(vk::SurfaceRotation::FlippedRotated180Degrees)},
     {vk::SurfaceRotation::FlippedRotated270Degrees,
      CalcRotatedFlipXYValueForDFdx(vk::SurfaceRotation::FlippedRotated270Degrees)}}};

// Returns [flipX*m2, flipY*m3], where [m2 m3] is the second column of kFragRotation matrix.
constexpr Vec2 CalcRotatedFlipXYValueForDFdy(vk::SurfaceRotation rotation)
{
    return Vec2({kFlipXYValue[rotation][0] * kFragRotationMatrices[rotation][2],
                 kFlipXYValue[rotation][1] * kFragRotationMatrices[rotation][3]});
}
constexpr Vec2EnumMap kRotatedFlipXYForDFdy = {
    {{vk::SurfaceRotation::Identity, CalcRotatedFlipXYValueForDFdy(vk::SurfaceRotation::Identity)},
     {vk::SurfaceRotation::Rotated90Degrees,
      CalcRotatedFlipXYValueForDFdy(vk::SurfaceRotation::Rotated90Degrees)},
     {vk::SurfaceRotation::Rotated180Degrees,
      CalcRotatedFlipXYValueForDFdy(vk::SurfaceRotation::Rotated180Degrees)},
     {vk::SurfaceRotation::Rotated270Degrees,
      CalcRotatedFlipXYValueForDFdy(vk::SurfaceRotation::Rotated270Degrees)},
     {vk::SurfaceRotation::FlippedIdentity,
      CalcRotatedFlipXYValueForDFdy(vk::SurfaceRotation::FlippedIdentity)},
     {vk::SurfaceRotation::FlippedRotated90Degrees,
      CalcRotatedFlipXYValueForDFdy(vk::SurfaceRotation::FlippedRotated90Degrees)},
     {vk::SurfaceRotation::FlippedRotated180Degrees,
      CalcRotatedFlipXYValueForDFdy(vk::SurfaceRotation::FlippedRotated180Degrees)},
     {vk::SurfaceRotation::FlippedRotated270Degrees,
      CalcRotatedFlipXYValueForDFdy(vk::SurfaceRotation::FlippedRotated270Degrees)}}};

// Returns an array of float and then use rotation to retrieve the desired float value out.
TIntermTyped *CreateFloatArrayWithRotationIndex(const Vec2EnumMap &valuesEnumMap,
                                                int subscript,
                                                float scale,
                                                TIntermSymbol *rotation)
{
    const TType *floatType = StaticType::GetBasic<EbtFloat>();
    TType *typeFloat8      = new TType(*floatType);
    typeFloat8->makeArray(static_cast<unsigned int>(vk::SurfaceRotation::EnumCount));

    TIntermSequence *sequences;
    sequences = new TIntermSequence(
        {CreateFloatNode(valuesEnumMap[vk::SurfaceRotation::Identity][subscript] * scale),
         CreateFloatNode(valuesEnumMap[vk::SurfaceRotation::Rotated90Degrees][subscript] * scale),
         CreateFloatNode(valuesEnumMap[vk::SurfaceRotation::Rotated180Degrees][subscript] * scale),
         CreateFloatNode(valuesEnumMap[vk::SurfaceRotation::Rotated270Degrees][subscript] * scale),
         CreateFloatNode(valuesEnumMap[vk::SurfaceRotation::FlippedIdentity][subscript] * scale),
         CreateFloatNode(valuesEnumMap[vk::SurfaceRotation::FlippedRotated90Degrees][subscript] *
                         scale),
         CreateFloatNode(valuesEnumMap[vk::SurfaceRotation::FlippedRotated180Degrees][subscript] *
                         scale),
         CreateFloatNode(valuesEnumMap[vk::SurfaceRotation::FlippedRotated270Degrees][subscript] *
                         scale)});
    TIntermTyped *array = TIntermAggregate::CreateConstructor(*typeFloat8, sequences);

    return new TIntermBinary(EOpIndexDirect, array, rotation);
}
}  // anonymous namespace

SpecConst::SpecConst(TSymbolTable *symbolTable, ShCompileOptions compileOptions)
    : mSymbolTable(symbolTable), mCompileOptions(compileOptions)
{
    // Mark SpecConstUsage::Rotation unconditionally.  gl_Position is always rotated.
    if ((mCompileOptions & SH_USE_SPECIALIZATION_CONSTANT) != 0 &&
        (mCompileOptions & SH_ADD_PRE_ROTATION) != 0)
    {
        mUsageBits.set(vk::SpecConstUsage::Rotation);
    }
}

SpecConst::~SpecConst() {}

void SpecConst::outputLayoutString(TInfoSinkBase &sink) const
{
    // Add specialization constant declarations.  The default value of the specialization
    // constant is irrelevant, as it will be set when creating the pipeline.
    // Only emit specialized const layout string if it has been referenced.
    if (mUsageBits.test(vk::SpecConstUsage::LineRasterEmulation))
    {
        sink << "layout(constant_id="
             << static_cast<uint32_t>(vk::SpecializationConstantId::LineRasterEmulation)
             << ") const bool " << kLineRasterEmulationSpecConstVarName << " = false;\n\n";
    }

    if (mUsageBits.test(vk::SpecConstUsage::YFlip) || mUsageBits.test(vk::SpecConstUsage::Rotation))
    {
        sink << "layout(constant_id="
             << static_cast<uint32_t>(vk::SpecializationConstantId::SurfaceRotation)
             << ") const uint " << kSurfaceRotationSpecConstVarName << " = 0;\n\n";
    }

    if (mUsageBits.test(vk::SpecConstUsage::DrawableSize))
    {
        sink << "layout(constant_id="
             << static_cast<uint32_t>(vk::SpecializationConstantId::DrawableWidth)
             << ") const uint " << kDrawableWidthSpecConstVarName << " = 0;\n\n";
        sink << "layout(constant_id="
             << static_cast<uint32_t>(vk::SpecializationConstantId::DrawableHeight)
             << ") const uint " << kDrawableHeightSpecConstVarName << " = 0;\n\n";
    }
}

TIntermSymbol *SpecConst::getLineRasterEmulation()
{
    if ((mCompileOptions & SH_ADD_BRESENHAM_LINE_RASTER_EMULATION) == 0)
    {
        return nullptr;
    }
    TVariable *specConstVar =
        new TVariable(mSymbolTable, kLineRasterEmulationSpecConstVarName,
                      StaticType::GetBasic<EbtBool>(), SymbolType::AngleInternal);
    mUsageBits.set(vk::SpecConstUsage::LineRasterEmulation);
    return new TIntermSymbol(specConstVar);
}

TIntermSymbol *SpecConst::getFlipRotation()
{
    TVariable *specConstVar =
        new TVariable(mSymbolTable, kSurfaceRotationSpecConstVarName,
                      StaticType::GetBasic<EbtUInt>(), SymbolType::AngleInternal);
    return new TIntermSymbol(specConstVar);
}

TIntermTyped *SpecConst::getMultiplierXForDFdx()
{
    if ((mCompileOptions & SH_USE_SPECIALIZATION_CONSTANT) == 0)
    {
        return nullptr;
    }
    mUsageBits.set(vk::SpecConstUsage::YFlip);
    mUsageBits.set(vk::SpecConstUsage::Rotation);
    return CreateFloatArrayWithRotationIndex(kRotatedFlipXYForDFdx, 0, 1, getFlipRotation());
}

TIntermTyped *SpecConst::getMultiplierYForDFdx()
{
    if ((mCompileOptions & SH_USE_SPECIALIZATION_CONSTANT) == 0)
    {
        return nullptr;
    }
    mUsageBits.set(vk::SpecConstUsage::YFlip);
    mUsageBits.set(vk::SpecConstUsage::Rotation);
    return CreateFloatArrayWithRotationIndex(kRotatedFlipXYForDFdx, 1, 1, getFlipRotation());
}

TIntermTyped *SpecConst::getMultiplierXForDFdy()
{
    if ((mCompileOptions & SH_USE_SPECIALIZATION_CONSTANT) == 0)
    {
        return nullptr;
    }
    mUsageBits.set(vk::SpecConstUsage::YFlip);
    mUsageBits.set(vk::SpecConstUsage::Rotation);
    return CreateFloatArrayWithRotationIndex(kRotatedFlipXYForDFdy, 0, 1, getFlipRotation());
}

TIntermTyped *SpecConst::getMultiplierYForDFdy()
{
    if ((mCompileOptions & SH_USE_SPECIALIZATION_CONSTANT) == 0)
    {
        return nullptr;
    }
    mUsageBits.set(vk::SpecConstUsage::YFlip);
    mUsageBits.set(vk::SpecConstUsage::Rotation);
    return CreateFloatArrayWithRotationIndex(kRotatedFlipXYForDFdy, 1, 1, getFlipRotation());
}

TIntermTyped *SpecConst::getFragRotationMatrix()
{
    if ((mCompileOptions & SH_USE_SPECIALIZATION_CONSTANT) == 0)
    {
        return nullptr;
    }
    mUsageBits.set(vk::SpecConstUsage::Rotation);
    return GenerateMat2x2ArrayWithIndex(kFragRotationMatrices, getFlipRotation());
}

TIntermTyped *SpecConst::getHalfRenderAreaRotationMatrix()
{
    if ((mCompileOptions & SH_USE_SPECIALIZATION_CONSTANT) == 0)
    {
        return nullptr;
    }
    mUsageBits.set(vk::SpecConstUsage::Rotation);
    return GenerateMat2x2ArrayWithIndex(kHalfRenderAreaRotationMatrices, getFlipRotation());
}

TIntermTyped *SpecConst::getFlipXY()
{
    if ((mCompileOptions & SH_USE_SPECIALIZATION_CONSTANT) == 0)
    {
        return nullptr;
    }
    mUsageBits.set(vk::SpecConstUsage::YFlip);
    return CreateVec2ArrayWithIndex(kFlipXYValue, 1.0, getFlipRotation());
}

TIntermTyped *SpecConst::getNegFlipXY()
{
    if ((mCompileOptions & SH_USE_SPECIALIZATION_CONSTANT) == 0)
    {
        return nullptr;
    }
    mUsageBits.set(vk::SpecConstUsage::YFlip);
    return CreateVec2ArrayWithIndex(kFlipXYValue, -1.0, getFlipRotation());
}

TIntermTyped *SpecConst::getFlipY()
{
    if ((mCompileOptions & SH_USE_SPECIALIZATION_CONSTANT) == 0)
    {
        return nullptr;
    }
    mUsageBits.set(vk::SpecConstUsage::YFlip);
    return CreateFloatArrayWithRotationIndex(kFlipXYValue, 1, 1, getFlipRotation());
}

TIntermTyped *SpecConst::getNegFlipY()
{
    if ((mCompileOptions & SH_USE_SPECIALIZATION_CONSTANT) == 0)
    {
        return nullptr;
    }
    mUsageBits.set(vk::SpecConstUsage::YFlip);
    return CreateFloatArrayWithRotationIndex(kFlipXYValue, 1, -1, getFlipRotation());
}

TIntermTyped *SpecConst::getFragRotationMultiplyFlipXY()
{
    if ((mCompileOptions & SH_USE_SPECIALIZATION_CONSTANT) == 0)
    {
        return nullptr;
    }

    constexpr Vec2EnumMap kFragRotationMultiplyFlipXY = {
        {{vk::SurfaceRotation::Identity,
          CalcFragRotationMultiplyFlipXY(vk::SurfaceRotation::Identity)},
         {vk::SurfaceRotation::Rotated90Degrees,
          CalcFragRotationMultiplyFlipXY(vk::SurfaceRotation::Rotated90Degrees)},
         {vk::SurfaceRotation::Rotated180Degrees,
          CalcFragRotationMultiplyFlipXY(vk::SurfaceRotation::Rotated180Degrees)},
         {vk::SurfaceRotation::Rotated270Degrees,
          CalcFragRotationMultiplyFlipXY(vk::SurfaceRotation::Rotated270Degrees)},
         {vk::SurfaceRotation::FlippedIdentity,
          CalcFragRotationMultiplyFlipXY(vk::SurfaceRotation::FlippedIdentity)},
         {vk::SurfaceRotation::FlippedRotated90Degrees,
          CalcFragRotationMultiplyFlipXY(vk::SurfaceRotation::FlippedRotated90Degrees)},
         {vk::SurfaceRotation::FlippedRotated180Degrees,
          CalcFragRotationMultiplyFlipXY(vk::SurfaceRotation::FlippedRotated180Degrees)},
         {vk::SurfaceRotation::FlippedRotated270Degrees,
          CalcFragRotationMultiplyFlipXY(vk::SurfaceRotation::FlippedRotated270Degrees)}}};

    mUsageBits.set(vk::SpecConstUsage::YFlip);
    mUsageBits.set(vk::SpecConstUsage::Rotation);
    return CreateVec2ArrayWithIndex(kFragRotationMultiplyFlipXY, 1.0, getFlipRotation());
}

TIntermSymbol *SpecConst::getDrawableWidth()
{
    TVariable *widthSpecConstVar =
        new TVariable(mSymbolTable, kDrawableWidthSpecConstVarName,
                      StaticType::GetBasic<EbtFloat>(), SymbolType::AngleInternal);
    TIntermSymbol *drawableWidth = new TIntermSymbol(widthSpecConstVar);
    return drawableWidth;
}

TIntermSymbol *SpecConst::getDrawableHeight()
{
    TVariable *heightSpecConstVar =
        new TVariable(mSymbolTable, kDrawableHeightSpecConstVarName,
                      StaticType::GetBasic<EbtFloat>(), SymbolType::AngleInternal);
    TIntermSymbol *drawableHeight = new TIntermSymbol(heightSpecConstVar);
    return drawableHeight;
}

TIntermBinary *SpecConst::getHalfRenderArea()
{
    if ((mCompileOptions & SH_USE_SPECIALIZATION_CONSTANT) == 0)
    {
        return nullptr;
    }

    // vec2 drawableSize(drawableWidth, drawableHeight)
    auto vec2Type                    = new TType(EbtFloat, 2);
    TIntermSequence *widthHeightArgs = new TIntermSequence();
    widthHeightArgs->push_back(getDrawableWidth());
    widthHeightArgs->push_back(getDrawableHeight());
    TIntermAggregate *drawableSize =
        TIntermAggregate::CreateConstructor(*vec2Type, widthHeightArgs);

    // drawableSize * 0.5f
    TIntermBinary *halfRenderArea =
        new TIntermBinary(EOpVectorTimesScalar, drawableSize, CreateFloatNode(0.5));
    mUsageBits.set(vk::SpecConstUsage::DrawableSize);

    // drawableSize * 0.5f * halfRenderAreaRotationMatrix (See comment in
    // kHalfRenderAreaRotationMatrices)
    TIntermBinary *rotatedHalfRenderArea =
        new TIntermBinary(EOpMatrixTimesVector, getHalfRenderAreaRotationMatrix(), halfRenderArea);

    return rotatedHalfRenderArea;
}
}  // namespace sh
