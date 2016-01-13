using System;
using System.Runtime.CompilerServices;

namespace EssIL
{
    public static class FlagTypeExtensions
    {
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private static bool HasFlagUnchecked<T>(T value, T flag) where T : struct
        {
            return (value & flag) == flag;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool Has<T>(this T value, T flag) where T : struct, Enum
        {
            return FlagTypeExtensions.HasFlagUnchecked<T>(value, flag);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool HasFlag(this byte value, byte flag)
        {
            return FlagTypeExtensions.HasFlagUnchecked<byte>(value, flag);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool HasFlag(this sbyte value, sbyte flag)
        {
            return FlagTypeExtensions.HasFlagUnchecked<sbyte>(value, flag);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool HasFlag(this short value, short flag)
        {
            return FlagTypeExtensions.HasFlagUnchecked<short>(value, flag);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool HasFlag(this ushort value, ushort flag)
        {
            return FlagTypeExtensions.HasFlagUnchecked<ushort>(value, flag);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool HasFlag(this int value, int flag)
        {
            return FlagTypeExtensions.HasFlagUnchecked<int>(value, flag);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool HasFlag(this uint value, uint flag)
        {
            return FlagTypeExtensions.HasFlagUnchecked<uint>(value, flag);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool HasFlag(this long value, long flag)
        {
            return FlagTypeExtensions.HasFlagUnchecked<long>(value, flag);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool HasFlag(this ulong value, ulong flag)
        {
            return FlagTypeExtensions.HasFlagUnchecked<ulong>(value, flag);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private static bool? TestFlagUnchecked<T>(T value, T flag) where T : struct
        {
            T t = value & flag;
            bool arg_14_0;
            if (t == flag)
            {
                arg_14_0 = true;
            }
            else
            {
                if (t != 0)
                {
                    bool? result;
                    return result;
                }
                arg_14_0 = false;
            }
            return new bool?(arg_14_0);
        }

        public static bool? TestFlag<T>(this T value, T flag) where T : struct, Enum
        {
            return FlagTypeExtensions.TestFlagUnchecked<T>(value, flag);
        }

        public static bool? TestFlag(this byte value, byte flag)
        {
            return FlagTypeExtensions.TestFlagUnchecked<byte>(value, flag);
        }

        public static bool? TestFlag(this sbyte value, sbyte flag)
        {
            return FlagTypeExtensions.TestFlagUnchecked<sbyte>(value, flag);
        }

        public static bool? TestFlag(this short value, short flag)
        {
            return FlagTypeExtensions.TestFlagUnchecked<short>(value, flag);
        }

        public static bool? TestFlag(this ushort value, ushort flag)
        {
            return FlagTypeExtensions.TestFlagUnchecked<ushort>(value, flag);
        }

        public static bool? TestFlag(this int value, int flag)
        {
            return FlagTypeExtensions.TestFlagUnchecked<int>(value, flag);
        }

        public static bool? TestFlag(this uint value, uint flag)
        {
            return FlagTypeExtensions.TestFlagUnchecked<uint>(value, flag);
        }

        public static bool? TestFlag(this long value, long flag)
        {
            return FlagTypeExtensions.TestFlagUnchecked<long>(value, flag);
        }

        public static bool? TestFlag(this ulong value, ulong flag)
        {
            return FlagTypeExtensions.TestFlagUnchecked<ulong>(value, flag);
        }
    }
}
