pub fn memset(addr: c_ulong, len: c_ulong, val: u8) void {
	for(0..len) |i| {
		const target: *u8 = @ptrFromInt(addr + i);
		target.* = val;
	}
}
