const std = @import("std");


const c_flags = [_][]const u8{
    "-std=c99",
    "-Werror=implicit-function-declaration",
};

const src_files = [_][]const u8{
    "src/cargs.c",
};

// check on https://github.com/raysan5/raylib/blob/master/build.zig
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const cargs_mod = b.createModule(.{
        .optimize = optimize,
        .target = target,
        .link_libc = true,
        
    });

    const cargs_lib = b.addLibrary(.{
        .name = "cargs",
        .root_module = cargs_mod,
    });



    cargs_lib.root_module.addCSourceFiles(.{
        .files = &src_files,
        .flags = &c_flags,
    });
    cargs_lib.root_module.addIncludePath(b.path("include"));
    
    cargs_lib.installHeadersDirectory(b.path("include"), "", .{});
    b.installArtifact(cargs_lib);
}
