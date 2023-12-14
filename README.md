# aock

> AoC Kernel

Christmas-y RISC-V adventures

## building

> requirements: clang 16, lld, ninja, llvm risc-v target

```bash
ninja
```

### clangd/tools integration

to generate [`compile_commands.json`](https://clang.llvm.org/docs/JSONCompilationDatabase.html), run

```bash
ninja -t compdb > compile_commands.json
```

## running

> requirements: qemu

```bash
qemu-system-riscv64 -machine virt -kernel build/kern.elf -serial mon:stdio
```

## debugging

> requirements: lldb

```bash
$ qemu-system-riscv64 -s -S -machine virt -kernel build/kern.elf -serial mon:stdio
# in another session/tab:
$ lldb ./build/kern.elf
(lldb) target create "./build/kern.elf"
Current executable set to '.../kern.elf' (riscv64).
(lldb) gdb-remote localhost:1234
(lldb) b kernel_main
(lldb) continue # qemu is stopped by default
```
