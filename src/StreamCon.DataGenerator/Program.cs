using StreamCon.Core;
using StreamCon.Core.DataModels;
using System;

namespace StreamCon.DataGenerator
{
    class Program
    {
        static void Main(string[] args)
        {
            Device myDevice = new Device();
            myDevice.SerialNumber = "1";

            Console.WriteLine($"{myDevice.SerialNumber}");

            Console.ReadKey();
        }
    }
}
