.assembly EssIL {
  .hash algorithm 0x00008004
  .ver 0:4:0:0

  .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )
}

.class public abstract auto ansi sealed EssIL.ClassUtility`1<class T> extends [mscorlib]System.Object
{
    .field private static bool cctorRun

    .method private hidebysig specialname rtspecialname static void .cctor() cil managed
    {
        .maxstack 8
        ret 
    }

    .method public hidebysig static void EnsureClassConstructorRun() cil managed
    {
        .maxstack 8

        volatile. 
        ldsfld bool class EssIL.ClassUtility`1<!T>::cctorRun
        brtrue.s L_ret

        ldc.i4.1 
        volatile. 
        stsfld bool class EssIL.ClassUtility`1<!T>::cctorRun

        ldtoken !T
        call void [mscorlib]System.Runtime.CompilerServices.RuntimeHelpers::RunClassConstructor(valuetype [mscorlib]System.RuntimeTypeHandle)

        L_ret: 
        ret 
    }
}

 .class public abstract auto ansi sealed EssIL.AtomicVolatileAccessor`1<T> extends System.Object
{
  .field private static bool smUseInterlockedFor64bit

  .method private hidebysig specialname rtspecialname static void .cctor() cil managed
  {
    .locals init (class [mscorlib]System.Type, valuetype [mscorlib]System.RuntimeTypeHandle)

    // get type handle
    ldtoken !T
    //stloc.1

    // get type
    //ldloc.1
    call class [mscorlib]System.Type [mscorlib]System.Type::GetTypeFromHandle(valuetype [mscorlib]System.RuntimeTypeHandle)
    stloc.0

    // check if class
    ldloc.0
    callvirt instance bool [mscorlib]System.Type::get_IsClass()
    brtrue.s L_ref

    // check if pointer
    ldloc.0
    callvirt instance bool [mscorlib]System.Type::get_IsPointer()
    brfalse.s L_non_ref

    // return if class or pointer
    L_ref:
    ret

    // check if enum
    L_non_ref:

    ldloc.0
    callvirt instance bool [mscorlib]System.Type::get_IsEnum()
    brfalse.s L_non_enum

    // replace with underlying type if enum
    ldloc.0
    call class [mscorlib]System.Type [mscorlib]System.Enum::GetUnderlyingType(class [mscorlib]System.Type)
    stloc.0

    // determine if 64bit is native supported
    L_non_enum:

    call int32 [mscorlib]System.IntPtr::get_Size()
    ldc.i4.8
    bge.s L_native

    // not supported, check type size
    ldloc.0
    call valuetype [mscorlib]System.TypeCode [mscorlib]System.Type::GetTypeCode(class [mscorlib]System.Type)
    ldc.i4.s 11
    sub

    // set smUseInterlockedFor64bit to true if the type has 64 bits
    // 11 = Int64, 12 = UInt64, 13 = Single, 14 = Double
    switch (L_interlocked_64, L_interlocked_64, L_native, L_interlocked_64)
    br.s L_native

    // here is where it sets smUseInterlockedFor64bit
    L_interlocked_64:
    ldc.i4.1
    stsfld bool class EssIL.AtomicVolatileAccessor`1<!T>::smUseInterlockedFor64bit

    // not 64 bits, check if primitive
    L_native:

    ldloc.0
    callvirt instance bool [mscorlib]System.Type::get_IsPrimitive()
    brtrue.s L_ret

    // then wth is this?
    newobj instance void [mscorlib]System.ArgumentException::.ctor()
    throw

    // done!
    L_ret:
    ret
  }

  .method public hidebysig static !T Read(!T& 'address') cil managed
  {
    ldarg.0

    ldsfld bool class EssIL.AtomicVolatileAccessor`1<!T>::smUseInterlockedFor64bit
    brtrue.s L_interlocked_64

    call !!0 EssIL.Memory::VolatileReadNonAtomic<!T>(!!0&)
    ret

    L_interlocked_64:

    // get data from given address, without changing it's current value
    ldc.i4.0
    ldc.i4.0
    call int64 [mscorlib]System.Threading.Interlocked::CompareExchange(int64&, int64, int64)

    ret
  }
  .method public hidebysig static !T Write([out] !T& 'address', !T 'value') cil managed
  {
    ldarg.0
    ldarg.1

    ldsfld bool class EssIL.AtomicVolatileAccessor`1<!T>::smUseInterlockedFor64bit
    brtrue.s L_interlocked_64

    call !!0 EssIL.Memory::VolatileWriteNonAtomic<!T>(!!0&, !!0)
    ret

    L_interlocked_64:

    // call interlocked method and discard the result
    call int64 [mscorlib]System.Threading.Interlocked::Exchange(int64&, int64)
    pop

    ldarg.1
    ret
  }
}

.class public abstract auto ansi sealed beforefieldinit EssIL.FlagTypeExtensions extends System.Object
{
  .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

  .method private hidebysig static bool HasFlagUnchecked<valuetype .ctor T>(!!T 'value', !!T 'flag') cil managed aggressiveinlining
  {
    //.custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    and
    ldarg.1
    ceq
    ret
  }

  .method public hidebysig static bool Has<valuetype .ctor (System.Enum) T>(!!T 'value', !!T 'flag') cil managed aggressiveinlining
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call bool EssIL.FlagTypeExtensions::HasFlagUnchecked<!!T>(!!0, !!0)
    ret
  }

  .method public hidebysig static bool HasFlag(uint8 'value', uint8 'flag') cil managed aggressiveinlining
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call bool EssIL.FlagTypeExtensions::HasFlagUnchecked<uint8>(!!0, !!0)
    ret
  }
  .method public hidebysig static bool HasFlag(int8 'value', int8 'flag') cil managed aggressiveinlining
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call bool EssIL.FlagTypeExtensions::HasFlagUnchecked<int8>(!!0, !!0)
    ret
  }

  .method public hidebysig static bool HasFlag(int16 'value', int16 'flag') cil managed aggressiveinlining
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call bool EssIL.FlagTypeExtensions::HasFlagUnchecked<int16>(!!0, !!0)
    ret
  }
  .method public hidebysig static bool HasFlag(uint16 'value', uint16 'flag') cil managed aggressiveinlining
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call bool EssIL.FlagTypeExtensions::HasFlagUnchecked<uint16>(!!0, !!0)
    ret
  }

  .method public hidebysig static bool HasFlag(int32 'value', int32 'flag') cil managed aggressiveinlining
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call bool EssIL.FlagTypeExtensions::HasFlagUnchecked<int32>(!!0, !!0)
    ret
  }
  .method public hidebysig static bool HasFlag(uint32 'value', uint32 'flag') cil managed aggressiveinlining
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call bool EssIL.FlagTypeExtensions::HasFlagUnchecked<uint32>(!!0, !!0)
    ret
  }

  .method public hidebysig static bool HasFlag(int64 'value', int64 'flag') cil managed aggressiveinlining
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call bool EssIL.FlagTypeExtensions::HasFlagUnchecked<int64>(!!0, !!0)
    ret
  }
  .method public hidebysig static bool HasFlag(uint64 'value', uint64 'flag') cil managed aggressiveinlining
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call bool EssIL.FlagTypeExtensions::HasFlagUnchecked<uint64>(!!0, !!0)
    ret
  }

  .method private hidebysig static valuetype [mscorlib]System.Nullable`1<bool> TestFlagUnchecked<valuetype .ctor T>(!!T 'value', !!T 'flag') cil managed aggressiveinlining
  {
    //.custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    .locals init (!!T, valuetype [mscorlib]System.Nullable`1<bool>)

    ldarg.0
    ldarg.1
    and
    stloc.0
    
    ldloc.0
    ldarg.1
    ceq
    brfalse.s L_False
    ldc.i4.1
    br.s L_Nullable
    
    L_False:
    
    ldloc.0
    ldc.i4.0
    ceq
    brfalse.s L_Null
    ldc.i4.0
    
    L_Nullable:

    newobj instance void valuetype [mscorlib]System.Nullable`1<bool>::.ctor(!0)
    ret

    L_Null:

    ldloc.1
    ret
  }

  .method public hidebysig static valuetype [mscorlib]System.Nullable`1<bool> TestFlag<valuetype .ctor (System.Enum) T>(!!T 'value', !!T 'flag') cil managed
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call valuetype [mscorlib]System.Nullable`1<bool> EssIL.FlagTypeExtensions::TestFlagUnchecked<!!T>(!!0, !!0)
    ret
  }

  .method public hidebysig static valuetype [mscorlib]System.Nullable`1<bool> TestFlag(uint8 'value', uint8 'flag') cil managed
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call valuetype [mscorlib]System.Nullable`1<bool> EssIL.FlagTypeExtensions::TestFlagUnchecked<uint8>(!!0, !!0)
    ret
  }
  .method public hidebysig static valuetype [mscorlib]System.Nullable`1<bool> TestFlag(int8 'value', int8 'flag') cil managed
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call valuetype [mscorlib]System.Nullable`1<bool> EssIL.FlagTypeExtensions::TestFlagUnchecked<int8>(!!0, !!0)
    ret
  }

  .method public hidebysig static valuetype [mscorlib]System.Nullable`1<bool> TestFlag(int16 'value', int16 'flag') cil managed
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call valuetype [mscorlib]System.Nullable`1<bool> EssIL.FlagTypeExtensions::TestFlagUnchecked<int16>(!!0, !!0)
    ret
  }
  .method public hidebysig static valuetype [mscorlib]System.Nullable`1<bool> TestFlag(uint16 'value', uint16 'flag') cil managed
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call valuetype [mscorlib]System.Nullable`1<bool> EssIL.FlagTypeExtensions::TestFlagUnchecked<uint16>(!!0, !!0)
    ret
  }

  .method public hidebysig static valuetype [mscorlib]System.Nullable`1<bool> TestFlag(int32 'value', int32 'flag') cil managed
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call valuetype [mscorlib]System.Nullable`1<bool> EssIL.FlagTypeExtensions::TestFlagUnchecked<int32>(!!0, !!0)
    ret
  }
  .method public hidebysig static valuetype [mscorlib]System.Nullable`1<bool> TestFlag(uint32 'value', uint32 'flag') cil managed
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call valuetype [mscorlib]System.Nullable`1<bool> EssIL.FlagTypeExtensions::TestFlagUnchecked<uint32>(!!0, !!0)
    ret
  }

  .method public hidebysig static valuetype [mscorlib]System.Nullable`1<bool> TestFlag(int64 'value', int64 'flag') cil managed
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call valuetype [mscorlib]System.Nullable`1<bool> EssIL.FlagTypeExtensions::TestFlagUnchecked<int64>(!!0, !!0)
    ret
  }
  .method public hidebysig static valuetype [mscorlib]System.Nullable`1<bool> TestFlag(uint64 'value', uint64 'flag') cil managed
  {
    .custom instance void [System.Core]System.Runtime.CompilerServices.ExtensionAttribute::.ctor() = ( 01 00 00 00 )

    ldarg.0
    ldarg.1
    call valuetype [mscorlib]System.Nullable`1<bool> EssIL.FlagTypeExtensions::TestFlagUnchecked<uint64>(!!0, !!0)
    ret
  }
}

.class public abstract auto ansi sealed beforefieldinit EssIL.Memory extends System.Object
{
  .method public hidebysig static !!T VolatileReadAtomic<T>(!!T& 'address') cil managed
  {
    ldarg.0
    call !0 class EssIL.AtomicVolatileAccessor`1<!!T>::Read(!0&)
    ret
  }
  .method public hidebysig static !!T VolatileWriteAtomic<T>([out] !!T& 'address', !!T 'value') cil managed
  {
    ldarg.0
    ldarg.1
    call !0 class EssIL.AtomicVolatileAccessor`1<!!T>::Write(!0&, !0)
    ret
  }

  .method public hidebysig static !!T VolatileReadNonAtomic<T>(!!T& 'address') cil managed noinlining
  {
    ldarg.0
    volatile.
    ldobj !!T
    ret
  }
  .method public hidebysig static !!T VolatileWriteNonAtomic<T>([out] !!T& 'address', !!T 'value') cil managed noinlining
  {
    ldarg.0
    ldarg.1
    volatile.
    stobj !!T
    ldarg.1
    ret
  }

  .method public hidebysig static bool VolatileRead(bool& 'address') cil managed noinlining
  {
    ldarg.0
    volatile.
    ldind.i1
    ret
  }
  .method public hidebysig static bool VolatileWrite([out] bool& 'address', bool 'value') cil managed noinlining
  {
    ldarg.0
    ldarg.1
    volatile.
    stind.i1
    ldarg.1
    ret
  }

  .method public hidebysig static uint8 VolatileRead(uint8& 'address') cil managed noinlining
  {
    ldarg.0
    volatile.
    ldind.u1
    ret
  }
  .method public hidebysig static uint8 VolatileWrite([out] uint8& 'address', uint8 'value') cil managed noinlining
  {
    ldarg.0
    ldarg.1
    volatile.
    stind.i1
    ldarg.1
    ret
  }

  .method public hidebysig static int8 VolatileRead(int8& 'address') cil managed noinlining
  {
    ldarg.0
    volatile.
    ldind.i1
    ret
  }
  .method public hidebysig static int8 VolatileWrite([out] int8& 'address', int8 'value') cil managed noinlining
  {
    ldarg.0
    ldarg.1
    volatile.
    stind.i1
    ldarg.1
    ret
  }

  .method public hidebysig static char VolatileRead(char& 'address') cil managed noinlining
  {
    ldarg.0
    volatile.
    ldind.u2
    ret
  }
  .method public hidebysig static char VolatileWrite([out] char& 'address', char 'value') cil managed noinlining
  {
    ldarg.0
    ldarg.1
    volatile.
    stind.i2
    ldarg.1
    ret
  }

  .method public hidebysig static int16 VolatileRead(int16& 'address') cil managed noinlining
  {
    ldarg.0
    volatile.
    ldind.i2
    ret
  }
  .method public hidebysig static int16 VolatileWrite([out] int16& 'address', int16 'value') cil managed noinlining
  {
    ldarg.0
    ldarg.1
    volatile.
    stind.i2
    ldarg.1
    ret
  }

  .method public hidebysig static uint16 VolatileRead(uint16& 'address') cil managed noinlining
  {
    ldarg.0
    volatile.
    ldind.u2
    ret
  }
  .method public hidebysig static uint16 VolatileWrite([out] uint16& 'address', uint16 'value') cil managed noinlining
  {
    ldarg.0
    ldarg.1
    volatile.
    stind.i2
    ldarg.1
    ret
  }

  .method public hidebysig static int32 VolatileRead(int32& 'address') cil managed noinlining
  {
    ldarg.0
    volatile.
    ldind.i4
    ret
  }
  .method public hidebysig static int32 VolatileWrite([out] int32& 'address', int32 'value') cil managed noinlining
  {
    ldarg.0
    ldarg.1
    volatile.
    stind.i4
    ldarg.1
    ret
  }

  .method public hidebysig static uint32 VolatileRead(uint32& 'address') cil managed noinlining
  {
    ldarg.0
    volatile.
    ldind.u4
    ret
  }
  .method public hidebysig static uint32 VolatileWrite([out] uint32& 'address', uint32 'value') cil managed noinlining
  {
    ldarg.0
    ldarg.1
    volatile.
    stind.i4
    ldarg.1
    ret
  }

  .method public hidebysig static int64 VolatileRead(int64& 'address') cil managed noinlining
  {
    ldarg.0
    call !!0 EssIL.Memory::VolatileReadAtomic<int64>(!!0&)
    ret
  }
  .method public hidebysig static int64 VolatileWrite([out] int64& 'address', int64 'value') cil managed noinlining
  {
    ldarg.0
    ldarg.1
    call !!0 EssIL.Memory::VolatileWriteAtomic<int64>(!!0&, !!0)
    ret
  }

  .method public hidebysig static uint64 VolatileRead(uint64& 'address') cil managed noinlining
  {
    ldarg.0
    call !!0 EssIL.Memory::VolatileReadAtomic<uint64>(!!0&)
    ret
  }
  .method public hidebysig static uint64 VolatileWrite([out] uint64& 'address', uint64 'value') cil managed noinlining
  {
    ldarg.0
    ldarg.1
    call !!0 EssIL.Memory::VolatileWriteAtomic<uint64>(!!0&, !!0)
    ret
  }

  .method public hidebysig static float32 VolatileRead(float32& 'address') cil managed noinlining
  {
    ldarg.0
    volatile.
    ldind.r4
    ret
  }
  .method public hidebysig static float32 VolatileWrite([out] float32& 'address', float32 'value') cil managed noinlining
  {
    ldarg.0
    ldarg.1
    volatile.
    stind.r4
    ldarg.1
    ret
  }

  .method public hidebysig static float64 VolatileRead(float64& 'address') cil managed noinlining
  {
    ldarg.0
    call !!0 EssIL.Memory::VolatileReadAtomic<float64>(!!0&)
    ret
  }
  .method public hidebysig static float64 VolatileWrite([out] float64& 'address', float64 'value') cil managed noinlining
  {
    ldarg.0
    ldarg.1
    call !!0 EssIL.Memory::VolatileWriteAtomic<float64>(!!0&, !!0)
    ret
  }

  .method public hidebysig static native int VolatileRead(native int& 'address') cil managed noinlining
  {
    ldarg.0
    volatile.
    ldobj native int
    ret
  }
  .method public hidebysig static native int VolatileWrite([out] native int& 'address', native int 'value') cil managed noinlining
  {
    ldarg.0
    ldarg.1
    volatile.
    stobj native int
    ldarg.1
    ret
  }

  .method public hidebysig static native uint VolatileRead(native uint& 'address') cil managed noinlining
  {
    ldarg.0
    volatile.
    ldobj native uint
    ret
  }
  .method public hidebysig static native uint VolatileWrite([out] native uint& 'address', native uint 'value') cil managed noinlining
  {
    ldarg.0
    ldarg.1
    volatile.
    stobj native uint
    ldarg.1
    ret
  }

  .method public hidebysig static !!T VolatileRead<class T>(!!T& 'address') cil managed
  {
    ldarg.0
    call !!0 EssIL.Memory::VolatileReadNonAtomic<!!T>(!!0&)
    ret
  }
  .method public hidebysig static !!T VolatileWrite<class T>([out] !!T& 'address', !!T 'value') cil managed
  {
    ldarg.0
    ldarg.1
    call !!0 EssIL.Memory::VolatileWriteNonAtomic<!!T>(!!0&, !!0)
    ret
  }

  .method public hidebysig static !!T NormalRead<T>(!!T& 'address') cil managed aggressiveinlining
  {
    ldarg.0
    ldobj !!T
    ret
  }
  .method public hidebysig static !!T NormalWrite<T>([out] !!T& 'address', !!T 'value') cil managed aggressiveinlining
  {
    ldarg.0
    ldarg.1
    stobj !!T
    ldarg.1
    ret
  }
}
