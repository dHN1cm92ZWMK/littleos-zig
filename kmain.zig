const mem = @import("mem.zig");
const display = @import("display.zig");
const string = @import("string.zig");

extern fn xmmset() void;

//const Allocator = struct{}
// todo - format print

export fn kmain() c_ulong {
    loop();
    return 0;
}

fn loop() void {
    display.clearScreen();

    display.rollPutStr("Hello");
    display.rollPutStr("This is test");
    display.rollPutStr("Done.");
    //display.rollPutStr(itoa(123).asSlice());

    //    xmmset();
    const mystr = string.String.fromSlice("string from slice");
    display.putStr2(30, 6, &mystr);

    const si3 = string.itoa3(31, 2);
    display.putStr2(30, 7, &si3);

    display.rollPutStr(string.sprintf("x: {d}", .{7}));
}
