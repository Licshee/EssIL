using System;
using System.Runtime.CompilerServices;

namespace EssIL
{
    public static class ClassUtility<T> where T : class
    {
        private static bool cctorRun;

        static ClassUtility()
        {
        }

        public static void EnsureClassConstructorRun()
        {
            if (!ClassUtility<T>.cctorRun)
            {
                ClassUtility<T>.cctorRun = true;
                RuntimeHelpers.RunClassConstructor(typeof(T).TypeHandle);
            }
        }
    }
}
