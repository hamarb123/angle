//
// Copyright 2019 The ANGLE Project Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//

// system_utils_winuwp.cpp: Implementation of OS-specific functions for Windows UWP

#include "common/debug.h"
#include "system_utils.h"

#include <stdarg.h>
#include <windows.h>
#include <array>
#include <string>

namespace angle
{

bool SetEnvironmentVar(const char *variableName, const char *value)
{
    // Not supported for UWP
    return false;
}

std::string GetEnvironmentVar(const char *variableName)
{
    // Not supported for UWP
    return "";
}

void *OpenSystemLibraryWithExtensionAndGetError(const char *libraryName,
                                                SearchType searchType,
                                                std::string *errorOut)
{
    char buffer[MAX_PATH];
    int ret = snprintf(buffer, MAX_PATH, "%s.%s", libraryName, GetSharedLibraryExtension());
    if (ret <= 0 || ret >= MAX_PATH)
    {
        fprintf(stderr, "Error loading shared library: 0x%x", ret);
        return nullptr;
    }

    HMODULE libraryModule = nullptr;

    switch (searchType)
    {
        case SearchType::ModuleDir:
        {
            // Preserve original google/angle logic, before we fall back to LoadLibraryW:
            libraryModule = LoadPackagedLibrary(Widen(libraryName).c_str(), 0);
            if (libraryModule != nullptr)
            {
                break;
            }

            std::string moduleRelativePath = ConcatenatePath(GetModuleDirectory(), libraryName);
            libraryModule                  = LoadLibraryW(Widen(moduleRelativePath).c_str());
            if (libraryModule == nullptr && errorOut)
            {
                *errorOut = std::string("failed to load library (SearchType::ModuleDir) ") +
                            moduleRelativePath;
            }
            break;
        }

        case SearchType::SystemDir:
        {
            libraryModule =
                LoadLibraryExW(Widen(libraryName).c_str(), nullptr, LOAD_LIBRARY_SEARCH_SYSTEM32);
            if (libraryModule == nullptr && errorOut)
            {
                *errorOut =
                    std::string("failed to load library (SearchType::SystemDir) ") + libraryName;
            }
            break;
        }

        case SearchType::AlreadyLoaded:
        {
            libraryModule = GetModuleHandleW(Widen(libraryName).c_str());
            if (libraryModule == nullptr && errorOut)
            {
                *errorOut = std::string("failed to load library (SearchType::AlreadyLoaded) ") +
                            libraryName;
            }
            break;
        }
    }

    return reinterpret_cast<void *>(libraryModule);
}

namespace
{
class UwpPageFaultHandler : public PageFaultHandler
{
  public:
    UwpPageFaultHandler(PageFaultCallback callback) : PageFaultHandler(callback) {}
    ~UwpPageFaultHandler() override {}

    bool enable() override;
    bool disable() override;
};

bool UwpPageFaultHandler::disable()
{
    UNIMPLEMENTED();
    return true;
}

bool UwpPageFaultHandler::enable()
{
    UNIMPLEMENTED();
    return true;
}
}  // namespace

bool ProtectMemory(uintptr_t start, size_t size)
{
    UNIMPLEMENTED();
    return true;
}

bool UnprotectMemory(uintptr_t start, size_t size)
{
    UNIMPLEMENTED();
    return true;
}

size_t GetPageSize()
{
    UNIMPLEMENTED();
    return 4096;
}

PageFaultHandler *CreatePageFaultHandler(PageFaultCallback callback)
{
    return new UwpPageFaultHandler(callback);
}

uint64_t GetProcessMemoryUsageKB()
{
    // Not available on UWP.
    return 0;
}
}  // namespace angle
