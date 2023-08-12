pub fn memset(addr: [*]u8, len: c_ulong, val: u8) void {
    for (0..len) |i| {
        addr[i] = val;
    }
}

pub fn memcpy(dest: [*]u8, src: [*]u8, len: c_ulong) void {
    for (0..len) |i| {
        dest[i] = src[i];
    }
}

var freeMem: [*]u8 = @ptrFromInt(0x200000);
pub fn kmalloc(len: c_ulong) [*]u8 {
    defer freeMem += len;
    return freeMem;
}
