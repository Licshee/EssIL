using System;
using System.Threading;

namespace EssIL
{
    public static class AtomicVolatileAccessor<T>
    {
        private static bool smUseInterlockedFor64bit;

        static AtomicVolatileAccessor()
        {
            Type type = typeof(T);
            if (type.IsClass || type.IsPointer)
            {
                return;
            }
            if (type.IsEnum)
            {
                type = Enum.GetUnderlyingType(type);
            }
            if (IntPtr.Size < 8)
            {
                switch (Type.GetTypeCode(type))
                {
                    case TypeCode.Int64:
                    case TypeCode.UInt64:
                    case TypeCode.Double:
                        AtomicVolatileAccessor<T>.smUseInterlockedFor64bit = true;
                        break;
                }
            }
            if (!type.IsPrimitive)
            {
                throw new ArgumentException();
            }
        }

        public static T Read(ref T address)
        {
            if (!AtomicVolatileAccessor<T>.smUseInterlockedFor64bit)
            {
                return Memory.VolatileReadNonAtomic<T>(ref address);
            }
            return Interlocked.CompareExchange(ref address, 0L, 0L);
        }

        public static T Write(out T address, T value)
        {
            if (!AtomicVolatileAccessor<T>.smUseInterlockedFor64bit)
            {
                return Memory.VolatileWriteNonAtomic<T>(out address, value);
            }
            Interlocked.Exchange(ref address, value);
            return value;
        }
    }
}
