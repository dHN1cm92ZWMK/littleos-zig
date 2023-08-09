const mem = @import("mem.zig");

pub const framebuffer_base = 0xb8000;

pub fn putch(x: c_ulong, y: c_ulong, c: u8) void {
	const addr: c_ulong = framebuffer_base + 2 * (x + y * 80);
	const c16: c_ushort = @intCast(c);
	const value: c_ushort = 0x0200 | c16; // 0x02 = green on black
	const framebuffer: *c_ushort = @ptrFromInt(addr);
	framebuffer.* = value;
}


pub fn putStr(x: u8, y: u8, s: []const u8) void {
	for(s, 0..) |c, i| {
		putch(x + i, y, c);
	}
}

pub fn clearScreen() void {
	mem.memset(framebuffer_base, 80 * 24 * 2, 0);
}
