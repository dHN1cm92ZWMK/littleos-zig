const mem = @import("mem.zig");
const display = @import("display.zig");

// todo - format print

export fn kmain() c_ulong {
	display.clearScreen();

	for(0..24) |l| {
		display.putch(0, @intCast(l), '|');
		display.putch(79, @intCast(l), '|');
	}
	for(0..80) |l| {
		display.putch(@intCast(l), 0, '-');
		display.putch(@intCast(l), 24, '-');
	}

	display.putStr(0, 5, "fifth line");
	display.putStr(0, 10, "tenth line");

	return 0;
}
