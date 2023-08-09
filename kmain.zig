
export fn kmain() c_ulong {
	for(0..24) |l| {
		putch(0, @intCast(l), '|');
		putch(79, @intCast(l), '|');
	}
	for(0..80) |l| {
		putch(@intCast(l), 0, '-');
		putch(@intCast(l), 24, '-');
	}

	putStr(0, 5, "fifth line");
	putStr(0, 10, "tenth line");

	return 0;
}

fn putch(x: c_ulong, y: c_ulong, c: u8) void {
	const addr: c_ulong = 0xb8000 + 2 * (x + y * 80);
	const c16: c_ushort = @intCast(c);
	const value: c_ushort = 0x0200 | c16; // 0x02 = green on black
	const framebuffer: *c_ushort = @ptrFromInt(addr);
	framebuffer.* = value;
}


fn putStr(x: u8, y: u8, s: []const u8) void {
	for(s, 0..) |c, i| {
		putch(x + i, y, c);
	}
}
