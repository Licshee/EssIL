using System;
using System.Runtime.CompilerServices;

namespace EssIL
{
    public static class Memory
    {
        public static T VolatileReadAtomic<T>(ref T address)
        {
            return AtomicVolatileAccessor<T>.Read(ref address);
        }

        public static T VolatileWriteAtomic<T>(out T address, T value)
        {
            return AtomicVolatileAccessor<T>.Write(out address, value);
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static T VolatileReadNonAtomic<T>(ref T address)
        {
            return address;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static T VolatileWriteNonAtomic<T>(out T address, T value)
        {
            address = value;
            return value;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static bool VolatileRead(ref bool address)
        {
            return address;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static bool VolatileWrite(out bool address, bool value)
        {
            address = value;
            return value;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static byte VolatileRead(ref byte address)
        {
            return address;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static byte VolatileWrite(out byte address, byte value)
        {
            address = value;
            return value;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static sbyte VolatileRead(ref sbyte address)
        {
            return address;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static sbyte VolatileWrite(out sbyte address, sbyte value)
        {
            address = value;
            return value;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static char VolatileRead(ref char address)
        {
            return address;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static char VolatileWrite(out char address, char value)
        {
            address = value;
            return value;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static short VolatileRead(ref short address)
        {
            return address;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static short VolatileWrite(out short address, short value)
        {
            address = value;
            return value;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static ushort VolatileRead(ref ushort address)
        {
            return address;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static ushort VolatileWrite(out ushort address, ushort value)
        {
            address = value;
            return value;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static int VolatileRead(ref int address)
        {
            return address;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static int VolatileWrite(out int address, int value)
        {
            address = value;
            return value;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static uint VolatileRead(ref uint address)
        {
            return address;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static uint VolatileWrite(out uint address, uint value)
        {
            address = value;
            return value;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static long VolatileRead(ref long address)
        {
            return Memory.VolatileReadAtomic<long>(ref address);
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static long VolatileWrite(out long address, long value)
        {
            return Memory.VolatileWriteAtomic<long>(out address, value);
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static ulong VolatileRead(ref ulong address)
        {
            return Memory.VolatileReadAtomic<ulong>(ref address);
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static ulong VolatileWrite(out ulong address, ulong value)
        {
            return Memory.VolatileWriteAtomic<ulong>(out address, value);
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static float VolatileRead(ref float address)
        {
            return address;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static float VolatileWrite(out float address, float value)
        {
            address = value;
            return value;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static double VolatileRead(ref double address)
        {
            return Memory.VolatileReadAtomic<double>(ref address);
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static double VolatileWrite(out double address, double value)
        {
            return Memory.VolatileWriteAtomic<double>(out address, value);
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static IntPtr VolatileRead(ref IntPtr address)
        {
            return address;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static IntPtr VolatileWrite(out IntPtr address, IntPtr value)
        {
            address = value;
            return value;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static UIntPtr VolatileRead(ref UIntPtr address)
        {
            return address;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static UIntPtr VolatileWrite(out UIntPtr address, UIntPtr value)
        {
            address = value;
            return value;
        }

        public static T VolatileRead<T>(ref T address) where T : class
        {
            return Memory.VolatileReadNonAtomic<T>(ref address);
        }

        public static T VolatileWrite<T>(out T address, T value) where T : class
        {
            return Memory.VolatileWriteNonAtomic<T>(out address, value);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static T NormalRead<T>(ref T address)
        {
            return address;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static T NormalWrite<T>(out T address, T value)
        {
            address = value;
            return value;
        }
    }
}
