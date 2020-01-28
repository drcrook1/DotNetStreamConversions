using StreamCon.Core;
using StreamCon.Core.DataModels;
using System;
using System.Threading.Tasks;

namespace StreamCon.DataGenerator
{
    class Program
    {
        static void Main(string[] args)
        {
            Device myDevice = new Device();
            myDevice.SerialNumber = "1";

            while (true)
            {
                Console.WriteLine($"{myDevice.SerialNumber}");
                Task.Delay(2000).Wait();
            }

        }
    }
}
