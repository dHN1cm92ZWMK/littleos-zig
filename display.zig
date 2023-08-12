const mem = @import("mem.zig");
const string = @import("string.zig");

pub const framebuffer_base: [*]u8 = @ptrFromInt(0xb8000);

pub fn putch(x: c_ulong, y: c_ulong, c: u8) void {
    const addr = framebuffer_base + 2 * (x + y * 80);
    const c16: c_ushort = @intCast(c);
    const value: c_ushort = 0x0200 | c16; // 0x02 = green on black
    const framebuffer: *c_ushort = @ptrFromInt(@intFromPtr(addr));
    framebuffer.* = value;
}

pub fn putStr(x: u8, y: u8, s: []const u8) void {
    for (s, 0..) |c, i| {
        putch(x + i, y, c);
    }
}

pub fn putStr2(x: u8, y: u8, s: *const string.String) void {
    for (0..s.len) |i| {
        //putch(x + i, y, '?');
        putch(x + i, y, s.ptr[i]);
    }
}

pub fn clearScreen() void {
    mem.memset(framebuffer_base, 80 * 24 * 2, 0);
}

pub fn rollPutStr(s: []const u8) void {
    for (1..25) |line| {
        mem.memcpy(framebuffer_base + (line - 1) * 80 * 2, framebuffer_base + line * 80 * 2, 80 * 2);
    }
    mem.memset(framebuffer_base + 24 * 80 * 2, 80 * 2, 0);

    putStr(0, 24, s);
}
