local project_name = string.match(_MAIN_SCRIPT_DIR, ".*/([^/]+)") -- E:/repo/foobar -> foobar

print("Building Solution " .. project_name)

workspace (project_name)
  characterset ("MBCS")
  configurations { "Debug", "DebugFast", "Release" }
  startproject "cast"
  location ".build/projects"
  targetdir ".build/bin/%{cfg.buildcfg}"
  debugdir "bin"
  kind "StaticLib"
  language "C++"
  warnings "Off"
  architecture "x64"
  --cppdialect "C++17"

  filter "action:vs*"
    disablewarnings {
      4996, -- 'fopen': This function or variable may be unsafe. Consider using fopen_s instead.
      4244, -- conversion from 'int' to 'float', possible loss of data
    }
    linkoptions {
      "/ignore:4006", -- F already defined in X.lib; second definition ignored
    }

  filter "configurations:Debug"
    defines { "DEBUG", "EA_DEBUG" }
    symbols "Full"
    optimize "Off"
    targetsuffix "-d"

  filter "configurations:DebugFast"
    defines { "DEBUG", "EA_DEBUG" }
    symbols "Full"
    optimize "Size"
    targetsuffix "-df"

  filter "configurations:Release"
    defines { "RELEASE", "NDEBUG" }
    symbols "Off"
    optimize "Size"

project "libtcc"
  defines { "ONE_SOURCE=0", "TCC_TARGET_X86_64", "TCC_TARGET_PE=1" }
  includedirs { "external/tinycc/" }
  includedirs { "source/" }
  files { "external/tinycc/i386-asm.c" }
  files { "external/tinycc/libtcc.c" }
  files { "external/tinycc/tccasm.c" }
  files { "external/tinycc/tccelf.c" }
  files { "external/tinycc/tccgen.c" }
  files { "external/tinycc/tccpe.c" }
  files { "external/tinycc/tccpp.c" }
  files { "external/tinycc/tccrun.c" }
  files { "external/tinycc/tcctools.c" }
  files { "external/tinycc/x86_64-gen.c" }
  files { "external/tinycc/x86_64-link.c" }

project "tcc"
  debugargs { "-Lcrt/lib", "-Icrt/include", "-std=c11", " -isystem", "../external/tinycc/include", "-o", "myprog.exe", "test.c" }
  defines { "ONE_SOURCE=0", "TCC_TARGET_X86_64", "TCC_TARGET_PE=1" }
  kind "ConsoleApp"
  warnings "Extra"
  includedirs { "external/tinycc/" }
  includedirs { "source/" }
  files { "source/config.h" }
  files { "external/tinycc/tcc.c" }
  links { "libtcc" }

project "cast"
  debugargs { "-Lcrt/lib", "-Icrt/include", "-std=c11", " -isystem", "../external/tinycc/include", "-o", "myprog.exe", "test.c" }
  defines { "ONE_SOURCE=0", "TCC_TARGET_X86_64", "TCC_TARGET_PE=1" }
  kind "ConsoleApp"
  warnings "Extra"
  includedirs { "external/tinycc/" }
  includedirs { "source/" }
  files { "source/**" }
  --files { "external/tinycc/tcc.c" }
  links { "libtcc" }