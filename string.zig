const mem = @import("mem.zig");

pub const String = struct {
    ptr: [*]const u8,
    len: u32,
    pub fn fromSlice(slice: []const u8) String {
        const ptr = mem.kmalloc(slice.len);
        for (slice, 0..) |c, i| {
            ptr[i] = c;
        }
        return String{ .ptr = ptr, .len = slice.len };
    }
};

fn digitToChar(digit: u8) u8 {
    return if (digit < 10) '0' + digit else 'a' + (digit - 10);
}

pub fn itoa3(num: c_ulong, base: u8) String {
    var len: u8 = 0;
    var x = num;
    while (x > 0) {
        len += 1;
        x /= base;
    }

    const strptr = mem.kmalloc(len);

    //const str: []u8 = random_mem[0..len];
    var rem = num;
    for (0..len) |digit| {
        const d: u8 = @intCast(rem % base);
        strptr[len - digit - 1] = digitToChar(d);

        rem /= base;
    }

    //return random_mem;
    return String{ .ptr = strptr, .len = len };
}

pub fn itoa2(num: c_ulong) [*]u8 {
    var len: u8 = 11;
    const random_mem: [*]u8 = @ptrFromInt(0x200000);
    mem.memset(0x200000, len, 0);

    //const str: []u8 = random_mem[0..len];
    var div: c_ulong = 1000000000;
    var rem = num;
    len = 0;

    for (0..11) |digit| {
        const d: u8 = @intCast(rem / div);
        random_mem[digit] = '0' + d;

        rem /= 10;
        div /= 10;
        len += 1;
        if (rem == 0) {
            break;
        }
    }

    return random_mem;
}

pub fn itoa(num: c_ulong, strlen: *u8) [*]u8 {
    //var s = [_]u8{0,0,0,0,0};

    //const f: f32 = @floatFromInt(i);
    // const l10 = @log10(f);
    //const len: u8 = @intFromFloat(l10); //11; // -2....
    var len: u8 = 11;
    const random_mem: [*]u8 = mem.kmalloc(len); //@ptrFromInt(0x200000);
    mem.memset(random_mem, len, 0);

    //const str: []u8 = random_mem[0..len];

    var rem = num;
    var reallen: u8 = 0;
    for (0..11) |digit| {
        const d: u8 = @intCast(rem % 10);
        random_mem[len - digit - 1] = '0' + d;
        rem /= 10;
        reallen += 1;
        if (rem == 0) {
            break;
        }
        //return random_mem; //return String{ .ptr = random_mem, .len = digit };
    }

    //var tmp: u8 = random_mem[0];
    //random_mem[0] = random_mem[2];
    //random_mem[2] = tmp;

    strlen.* = reallen;
    return random_mem + 11 - reallen;
    //return String{ .ptr = random_mem, .len = 11 };
}

pub fn sprintf(comptime format: []const u8, args: anytype) []const u8 {
    _ = args;
    return format;
}
